require './app/uploaders/header_uploader'

class Expedition < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :start_locations, lambda { where 'start_location = true' }, class_name: 'Coordinate'
  has_many :end_locations, lambda { where 'end_location = true' }, class_name: 'Coordinate'

  has_many :journeys
  has_many :invited_users, lambda { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :user
  has_many :rejected_users, lambda { where journeys: { :status => 'rejected' } }, through: :journeys, source: :user
  has_many :attending_users, lambda { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :user
  has_many :requested_users, lambda { where journeys: { :status => 'requested' } }, through: :journeys, source: :user
  has_many :attended_users, lambda { where journeys: { :status => 'attended' } }, through: :journeys, source: :user

  # Convenience methods for development
  scope :invited, lambda { joins(:journeys).where('journeys.status =?', 'invited') }
  scope :rejected, lambda { joins(:journeys).where('journeys.status =?', 'rejected') }
  scope :attending, lambda { joins(:journeys).where('journeys.status =?', 'attending') }
  scope :attended, lambda { joins(:journeys).where('journeys.status =?', 'attended') }

  scope :recent, lambda { where('complete = true').order('end_time DESC') }

  accepts_nested_attributes_for :start_locations, :end_locations

  mount_uploader :header, HeaderUploader

  def start_location
    self.start_locations.first
  end

  def end_location
    self.end_locations.first
  end

  def invite(user)
    # Unless user is already attending or has been invited
    unless self.attending?(user) && self.invited?(user)
      # If user is requested, change to invited, else just invite
      self.requested?(user) ? self.requested_users.find_by(user: user).status = 'invited' : self.journeys.create(user: user)
    end
  end

  def request(user)
    # Unless user is already requested/invited/attending
    unless self.requested?(user) || self.invited?(user) || self.attending?(user)
      self.journeys.create(user: user, status: 'requested')
    end
  end

  def requested?(user)
    self.requested_users.include?(user)
  end

  def invited?(user)
    self.invited_users.include?(user)
  end

  def attending?(user)
    self.attending_users.include?(user)
  end

  def creator?(user)
    user == self.creator
  end

  def permit_attendance(user)
    journey = self.journeys.find_by(user: user)
    journey.status = "attending"
    journey.save
  end

  def reject_attendance(user)
    journey = self.journeys.find_by(user: user)
    journey.status = "rejected"
    journey.save
  end

  def set_as_complete
    self.journeys.where('status =?', 'attending').each do |journey|
      journey.status = "attended"
      journey.save!
    end
    self.complete = true
    self.save
  end

end
