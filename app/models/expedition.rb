require './app/uploaders/header_uploader'

class Expedition < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :coordinates, dependent: :destroy
  has_many :start_locations, -> { where 'start_location = true' }, class_name: 'Coordinate'
  has_many :end_locations, -> { where 'end_location = true' }, class_name: 'Coordinate'

  has_many :journeys, dependent: :destroy
  has_many :invited_users, -> { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :user
  has_many :rejected_users, -> { where journeys: { :status => 'rejected' } }, through: :journeys, source: :user
  has_many :attending_users, -> { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :user
  has_many :requested_users, -> { where journeys: { :status => 'requested' } }, through: :journeys, source: :user
  has_many :attended_users, -> { where journeys: { :status => 'attended' } }, through: :journeys, source: :user

  # Convenience methods for development
  scope :invited, -> { joins(:journeys).where('journeys.status =?', 'invited') }
  scope :rejected, -> { joins(:journeys).where('journeys.status =?', 'rejected') }
  scope :attending, -> { joins(:journeys).where('journeys.status =?', 'attending') }
  scope :attended, -> { joins(:journeys).where('journeys.status =?', 'attended') }

  scope :recent, -> { where('complete = true').order('end_time DESC') }

  accepts_nested_attributes_for :start_locations, :end_locations

  validates_presence_of :start_time, :end_time, :name, :description

  mount_uploader :header, HeaderUploader

  def start_location
    self.start_locations.first
  end

  def end_location
    self.end_locations.first
  end

  def format_start_time
    self.start_time.to_date.strftime('%b %e %Y, %H:%M')
  end

  def days
    days = (Date.parse(end_time.to_s) - Date.parse(start_time.to_s)).truncate
    days == 0 ? 1 : days
  end

  def invite(user)
    unless self.attending?(user) && self.invited?(user)
      self.requested?(user) ? self.requested_users.find_by(user: user).status = 'invited' : self.journeys.create(user: user)
    end
  end

  def request(user)
    unless self.requested?(user) && self.invited?(user) && self.attending?(user)
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

  def rejected?(user)
    self.rejected_users.include?(user)
  end

  def complete?
    self.complete == true
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
