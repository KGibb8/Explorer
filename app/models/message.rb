class Message < ApplicationRecord
  belongs_to :chat, required: false
  belongs_to :user

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
