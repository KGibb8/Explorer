class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy

  has_many :journeys
  has_many :expeditions, through: :journeys
  has_many :expedition_invites, lambda { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :expedition
  has_many :attending_expeditions, lambda { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :expedition

  validates_presence_of :username

  after_create :build_profile

  def create_expedition(start_time, end_time)
    self.expeditions.create(creator: self, start_time: start_time, end_time: end_time)
  end

  private

  def build_profile
    self.create_profile
  end

end
