class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  has_many :journeys
  has_many :expeditions, through: :journeys
  has_many :invited_expeditions, lambda { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :expedition
  has_many :rejected_expeditions, lambda { where journeys: { :status => 'rejected'  }  }, through: :journeys, source: :expedition
  has_many :attending_expeditions, lambda { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :expedition
  has_many :requested_expeditions, lambda { where journeys: { :status => 'requested' } }, through: :journeys, source: :expedition
  has_many :attended_expeditions, lambda { where journeys: { :status => 'attended'  }  }, through: :journeys, source: :expedition

  has_many :friendships
  has_many :requested_friends, lambda { where friendships: { :status => 'pending'  }  }, through: :friendships, source: :friend
  has_many :friend_requests, lambda { where friendships: { :status => 'requested'  }  }, through: :friendships, source: :friend
  has_many :friends, lambda { where friendships: { :status => 'confirmed'  }  }, through: :friendships, source: :friend

  validates_presence_of :username

  after_create :build_profile

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
    unless self == user || Friendship.where('(user_id =? AND friend_id =?) OR (user_id =? AND friend_id =?)', self.id, user.id, user.id, self.id).any?
      transaction do
        Friendship.create(user: self, friend: user, status: 'pending')
        Friendship.create(user: user, friend: self, status: 'requested')
      end
    end
  end

  private

  def build_profile
    self.create_profile
  end

end
