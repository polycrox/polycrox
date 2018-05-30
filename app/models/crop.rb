class Crop < ApplicationRecord

  belongs_to :plot
    
  belongs_to :item
  
  before_save :set_default, if: :new_record?
  validates :date, presence: true

  def set_date= date
    self.date = Date.parse(date)
  end

  private
  def set_default
    self.active = false
  end
end