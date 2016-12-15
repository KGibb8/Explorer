class Message < ApplicationRecord
  # Make this polymorphic for extensible message model
  belongs_to :chat, required: false
  belongs_to :user

  validates_presence_of :body

  validate :journey_status

  private

  def journey_status
    if self.chat
      journey = Journey.find_by(expedition: self.chat.expedition, user: self.user)
      journey ? (self.errors.add(:rejected, "user not authorised") if journey.status == "rejected" || journey.status == "requested")
        : self.errors.add(:uninvoled, "user not authorised")
    end
  end

end
