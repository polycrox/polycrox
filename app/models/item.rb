class Relationship < ApplicationRecord

  def items
    @items ||= if other_item_id.present?
      Item.find(other_item_id)
    else
      Group.find(group_id).items
    end 
  end
end

class Item < ApplicationRecord

  validates :name, :groups, presence: true

  has_and_belongs_to_many :groups, join_table: 'items_groups'
  

  # module RELATIONSHIPS
  has_many :item_group_friends, -> { where(is_friend: true)}, class_name: 'Relationship', foreign_key: :item_id
  has_many :item_group_enemies, -> { where(is_friend: false)}, class_name: 'Relationship', foreign_key: :item_id

  has_many :indirect_friends, -> { where(is_friend: true)}, class_name: 'Relationship', foreign_key: :other_item_id

  def friends
    @friends ||= item_group_friends.each_with_object([]) do |r, friends|
      if r.other_item_id.present?
        friends.push(Item.find(r.other_item_id))
      elsif r.group_id.present?
        Group.find(r.group_id).items.each do |item|
          friends.push(item)
        end
      end
    end
  end

  def enemies
    @enemies ||= item_group_enemies.each_with_object([]) do |r, enemies|
      if r.other_item_id.present?
        enemies.push(Item.find(r.other_item_id))
      elsif r.group_id.present?
        Group.find(r.group_id).items.each do |item|
          enemies.push(item)
        end
      end
    end
  end  

  # module PROPERTIES

  has_many :properties

  def create_property form_prop_id, value
    prop = Property.new
    prop.form_property_id = form_prop_id
    prop.value = value
    prop.item = self
    prop.save
    prop
  end

  def update_property form_prop_id, value
    prop = self.properties.find do |prop|
      prop.form_property_id == form_prop_id
    end
    prop.value = value
    prop.save
    prop
  end

  def hash_properties_values
    @hash_properties_values ||= self.properties.each_with_object({}) do |prop, hash|
      hash[prop.form_property.name.to_sym] = prop.value
    end
  end

  def hash_properties_objects
    @hash_properties_objects ||= self.properties.each_with_object({}) do |prop, hash|
      hash[prop.form_property.name.to_sym] = prop
    end
  end  

  def form_property_ids
    @property_ids ||= self.properties.map do |prop|
      prop.form_property_id
    end
  end


end
