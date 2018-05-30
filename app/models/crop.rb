class Crop < ApplicationRecord

  belongs_to :garden
  
  has_and_belongs_to_many :plots, 
    join_table: 'crops_items_plots',
    class_name: 'Plot'
  
  has_and_belongs_to_many :items, 
    join_table: 'crops_items_plots',
    class_name: 'Item'
  
  before_save :set_default, if: :new_record?
  validates :date, presence: true
  validates :date, uniqueness: true

  def set_date= date
    self.date = Date.parse(date)
  end

  private
  def set_default
    self.active = false
  end
end