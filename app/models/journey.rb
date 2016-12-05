class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :expedition

  before_create :set_status

  def set_status_as_attended
    self.status = 'attended'
  end

  private

  def set_status
    self.expedition.creator == self.user ? self.status = 'attending' : self.status = 'invited'
  end

end
