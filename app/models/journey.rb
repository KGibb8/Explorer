class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :expedition
  has_many :activities, as: :subject
  has_many :messages

  before_create :set_status
  after_create :create_activity

  def inflection
    case self.status
    when "invited"
      "was #{self.status} to"
    when "attending"
      "is #{self.status}"
    when "attended"
      "#{self.status}"
    when "rejected"
      "was #{self.status} from"
    else ""
    end
  end

  private

  def set_status
    unless self.status
      self.expedition.creator == self.user ? self.status = 'attending' : self.status = 'invited'
    end
  end

  def create_activity
    Activity.create(
      subject: self.expedition,
      user: self.user,
      action: self.inflection,
      topic: self.class.to_s,
      path: 'expedition'
    )
  end

end
