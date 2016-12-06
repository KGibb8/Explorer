class Expedition < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :journeys
  has_many :invited_users, lambda { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :user
  has_many :rejected_users, lambda { where journeys: { :status => 'rejected' } }, through: :journeys, source: :user
  has_many :attending_users, lambda { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :user
  has_many :requested_users, lambda { where journeys: { :status => 'requested' } }, through: :journeys, source: :user
  has_many :attended_users, lambda { where journeys: { :status => 'attended' } }, through: :journeys, source: :user

  def invite(user)
    self.journeys.create(user: user)
  end

  def invited?(user)
    self.invited_users.include?(user)
  end

  def attending?(user)
    self.attending_users.include?(user)
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

  def complete
    journeys = self.attending_users.map(&:journeys).flatten
    transaction do
      journeys.each do |journey|
        journey.status = "attended"
        journey.save!
      end
    end
  end

end
