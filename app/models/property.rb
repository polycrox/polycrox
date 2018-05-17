class Property < ApplicationRecord
  belongs_to :item

  belongs_to :form_property
  
  validates :value, presence: true
end



# class Properties

#   def self.all
#     InputProperty.all + SelectProperty.all
#   end
# end



