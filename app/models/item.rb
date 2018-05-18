class Item < ApplicationRecord

  validates :name, :groups, presence: true

  has_and_belongs_to_many :groups, join_table: 'items_groups'
  
  has_many :relationships
  # module RELATIONSHIPS
  # has_many :item_group_friends, -> { where(is_friend: true)}, class_name: 'Relationship', foreign_key: :item_id
  # has_many :item_group_enemies, -> { where(is_friend: false)}, class_name: 'Relationship', foreign_key: :item_id

  
  # has_many :indirect_friends, -> { where(is_friend: true)}, class_name: 'Relationship', foreign_key: :other_item_id

  has_many :item_friend_relations, 
    -> { where(is_friend: true, other_group_id: nil, group_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :item_id

  def item_friends
    @item_friends ||= item_friend_relations.each_with_object([]) do |relation, item_friends|
      item_friends.push(Item.find(relation.other_item_id))
    end
  end

  has_many :group_friend_relations, 
    -> { where(is_friend: true, other_item_id: nil, group_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :item_id

  def group_friends
    @group_friends ||= group_friend_relations.each_with_object([]) do |relation, group_friends|
      group_friends.push(Group.find(relation.other_group_id))
    end
  end

  def group_friends_to_items
    @group_friends_to_items ||= group_friends.each_with_object([]) do |group, items|
      group.items.each do |item|
        items.push(item)
      end
    end
  end

  def friends
    @friends ||= item_friends + group_friends_to_items
  end

  has_many :item_enemy_relations, 
    -> { where(is_friend: false, other_group_id: nil, group_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :item_id

  def item_enemies
    @item_enemies ||= item_enemy_relations.each_with_object([]) do |relation, item_enemies|
      item_enemies.push(Item.find(relation.other_item_id))
    end    
  end

  has_many :group_enemy_relations, 
    -> { where(is_friend: false, other_item_id: nil, group_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :item_id

  def group_enemies
    @group_enemies ||= group_enemy_relations.each_with_object([]) do |relation, group_enemies|
      group_enemies.push(Group.find(relation.other_group_id))
    end
  end

  def group_enemies_to_items
    @group_enemies_to_items ||= group_enemies.each_with_object([]) do |group, items|
      group.items.each do |item|
        items.push(item)
      end
    end
  end  

  def enemies
    @enemies ||= item_enemies + group_enemies_to_items
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
