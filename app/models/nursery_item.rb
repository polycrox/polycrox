
class NurseryItem < ApplicationRecord

  belongs_to :nursery

  belongs_to :item

  self.inheritance_column = :type
  
  def as_json(options = {})
    super.merge({'type' => type})
  end  
    
end
