class Nursery < ApplicationRecord

  belongs_to :garden
  has_many :items, class_name: 'NurseryItem'

  # has_many :seeds, class_name: 'NurseryItem', -> { where(type: 'Seed') }  
  # has_many :cuttings, class_name: 'NurseryItem', -> { where(type: 'Cutting') }
  # has_many :seedlings, class_name: 'NurseryItem', -> { where(type: 'Seedling') }

  # def seeds
  #   @seeds ||= items.where(type: 'Seed')
  # end

  # def seedlings
  #   @seedlings ||= items.where(type: 'Seedling')
  # end  

  # def cuttings
  #   @cuttings ||= items.where(type: 'Cutting')
  # end  
end