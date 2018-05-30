
class NurseryItem < ApplicationRecord

  belongs_to :nursery

  has_one :item

  self.inheritance_column = :type
  
end
