class Group < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true

  has_and_belongs_to_many :items, join_table: 'items_groups'

  has_many :relationships
  
  def self.find_or_create name:
    Group.find_by_name(name) || Group.create(name: name)
  end

  has_many :item_friend_relations, 
    -> { where(is_friend: true, other_group_id: nil, item_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :group_id

  def item_friends
    @item_friends ||= item_friend_relations.each_with_object([]) do |relation, item_friends|
      item_friends.push(Item.find(relation.other_item_id))
    end
  end

  has_many :group_friend_relations, 
    -> { where(is_friend: true, other_item_id: nil, item_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :group_id

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
    -> { where(is_friend: false, other_group_id: nil, item_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :group_id

  def item_enemies
    @item_enemies ||= item_enemy_relations.each_with_object([]) do |relation, item_enemies|
      item_enemies.push(Item.find(relation.other_item_id))
    end    
  end

  has_many :group_enemy_relations, 
    -> { where(is_friend: false, other_item_id: nil, item_id: nil)}, 
    class_name: 'Relationship', 
    foreign_key: :group_id

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

end


