class Nursery < ApplicationRecord

  belongs_to :garden
  has_many :items, class_name: 'NurseryItem'

  has_many :seeds, class_name: 'NurseryItem'
    -> { where(type: 'Seed') }
  
  has_many :cuttings, class_name: 'NurseryItem'
    -> { where(type: 'Cutting') }
  
  has_many :seedlings, class_name: 'NurseryItem'
    -> { where(type: 'Seedling') }

end