class Relationship < ApplicationRecord

  # belongs_to :item, class_name: 'Item', foreign_key: 'item_id'

  def items
    @items ||= if other_item_id.present?
      Item.find(other_item_id)
    else
      Group.find(group_id).items
    end 
  end
end
