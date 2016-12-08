class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :expedition

  before_create :set_status

  private

  def set_status
    unless self.status
      self.expedition.creator == self.user ? self.status = 'attending' : self.status = 'invited'
    end
  end

end
