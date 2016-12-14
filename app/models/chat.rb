class Chat < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :expedition

  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages

  validate :journey_status

  private

  def journey_status
    journey = Journey.find_by(expedition: self.expedition, user: self.creator)
    journey ? (self.errors.add(:rejected, "user not authorised") if journey.status == "rejected" || journey.status == "requested")
      : self.errors.add(:uninvoled, "user not authorised")
  end
end
