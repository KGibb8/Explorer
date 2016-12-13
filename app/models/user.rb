class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  has_one :profile, dependent: :destroy
  has_many :activities

  has_many :journeys, dependent: :destroy
  has_many :expeditions, through: :journeys
  has_many :invited_expeditions, -> { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :expedition
  has_many :rejected_expeditions, -> { where journeys: { :status => 'rejected'  }  }, through: :journeys, source: :expedition
  has_many :attending_expeditions, -> { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :expedition
  has_many :requested_expeditions, -> { where journeys: { :status => 'requested' } }, through: :journeys, source: :expedition
  has_many :attended_expeditions, -> { where journeys: { :status => 'attended'  }  }, through: :journeys, source: :expedition

  has_many :friendships, dependent: :destroy
  has_many :requested_friends, -> { where friendships: { :status => 'pending'  }  }, through: :friendships, source: :friend
  has_many :friend_requests, -> { where friendships: { :status => 'requested'  }  }, through: :friendships, source: :friend
  has_many :rejected_friends, -> { where friendships: { :status => 'rejected'  }  }, through: :friendships, source: :friend
  has_many :friends, -> { where friendships: { :status => 'confirmed'  }  }, through: :friendships, source: :friend

  validates :username, :presence => true, :uniqueness => { :case_sensitive => true }

  after_create :build_profile

  def name
    self.profile.full_name || self.username
  end

  # --------------------------------------- Omniauth related ------------------------------------------ #

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name.split(" ").join("_")
      user.fb_profile = auth.info.image
    end
  end

  # ------------------------------------- Expedition related ------------------------------------------ #

  def create_expedition(expedition_params)
    self.expeditions.create(expedition_params.merge(creator: self))
  end

  def accept_invite(expedition)
    journey = self.journeys.find_by(expedition: expedition)
    journey.status = 'attending'
    journey.save
  end

  def request_attendance(expedition)
    journey = self.journeys.create(expedition: expedition)
    journey.status = 'requested'
    journey.save
  end

  # ------------------------------------- Friendship related ------------------------------------------ #

  def befriend(user)
    unless self == user || Friendship.between(self, user).any?
      transaction do
        Friendship.create(user: self, friend: user, status: 'pending')
        Friendship.create(user: user, friend: self, status: 'requested')
      end
    end
  end

  def accept_friend(user)
    accepted_at = Time.now
    friendships = Friendship.between(self, user)
    transaction do
      friendships.each do |friendship|
        friendship.status = "confirmed"
        friendship.accepted_at = accepted_at
        friendship.save!
      end
    end
  end

  def reject_friend(user)
    friendships = Friendship.between(self, user)
    transaction do
      friendships.each do |friendship|
        friendship.status = "rejected"
        friendship.save
      end
    end
  end

  # --------------------------------------- Activity related ------------------------------------------ #

  def related_activities
    (self.friends.map(&:activities).flatten + self.activities.to_a).sort_by(&:created_at).reverse
  end

  private

  def build_profile
    self.create_profile
  end

end
