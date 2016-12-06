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

  validates_presence_of :username

  after_create :build_profile

  def create_expedition(title, description, start_time, end_time)
    self.expeditions.create(creator: self, title: title, description: description, start_time: start_time, end_time: end_time)
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

  private

  def build_profile
    self.create_profile
  end

end
