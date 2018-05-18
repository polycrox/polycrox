require 'rails_helper'

describe Relationship do 
  before {
    @item = ItemBuilder.new(item_name: 'item', group_names: ['group_1'])
    @item.save

    @other_item = ItemBuilder.new(item_name: 'other_item', group_names: ['group_2'])
    @other_item.save

  }

  let (:item) { @item.item }
  let (:other_item) { @other_item.item }

  let (:group) { item.groups.first }
  let (:other_group) { other_item.groups.first }

  describe 'item to item' do

    before {
      @r = Relationship.new
      @r.item_id = item.id
      @r.other_item_id = other_item.id
      @r.is_friend = is_friend
      @r.save
    }
    context 'friend' do
      let (:is_friend) { true }

      it 'should have a friend' do
        expect(item.friends.count).to eq(1)
        expect(item.friends.first).to eq(other_item)

        expect(item.enemies.count).to eq(0)
      end
    end

    context 'enemy' do
      let (:is_friend) { false }

      it 'should have an enemy' do
        expect(item.enemies.count).to eq(1)
        expect(item.enemies.first).to eq(other_item)

        expect(item.friends.count).to eq(0)

      end
    end
  end

  describe 'item to group' do
    before {
      @r = Relationship.new
      @r.item_id = item.id
      @r.other_group_id = other_group.id
      @r.is_friend = is_friend
      @r.save
    }

    context 'friend' do
      let (:is_friend) { true }

      it 'should have a group friend' do
        expect(item.group_friends.count).to eq(1)
        expect(item.group_enemies.count).to eq(0)
        expect(item.group_friends.first).to eq(other_group)
        
        expect(item.friends.count).to eq(1)
        expect(item.friends.first).to eq(other_item)
      end
    end

    context 'enemy' do
      let (:is_friend) { false }

      it 'should have a group enemy' do
        expect(item.group_enemies.count).to eq(1)
        expect(item.group_friends.count).to eq(0)
        expect(item.group_enemies.first).to eq(other_group)
        
        expect(item.enemies.count).to eq(1)
        expect(item.enemies.first).to eq(other_item)
      end
    end    
  end

  describe 'group to group' do
    before {
      @r = Relationship.new
      @r.group_id = group.id
      @r.other_group_id = other_group.id
      @r.is_friend = is_friend
      @r.save
    }
    context 'friend' do
      let (:is_friend) { true }
      
      it 'should have a group friend' do
        expect(group.group_friends.count).to eq(1)
        expect(group.group_enemies.count).to eq(0)
        expect(group.group_friends.first).to eq(other_group)
        expect(group.friends.count).to eq(1)
        expect(group.friends.first).to eq(other_item)
        expect(group.enemies.count).to eq(0)
      end
    end

    context 'enemy' do
      let (:is_friend) { false }
      
      it 'should have a group enemy' do
        expect(group.group_enemies.count).to eq(1)
        expect(group.group_friends.count).to eq(0)
        expect(group.group_enemies.first).to eq(other_group)
        expect(group.enemies.count).to eq(1)
        expect(group.enemies.first).to eq(other_item)
        expect(group.friends.count).to eq(0)
      end    
    end
  end

  describe 'group to item' do
    before {
      @r = Relationship.new
      @r.group_id = group.id
      @r.other_item_id = other_item.id
      @r.is_friend = is_friend
      @r.save
    }

    context 'friend' do
      let (:is_friend) { true }

      it 'should have a friend' do
        expect(group.friends.count).to eq(1)
        expect(group.friends.first).to eq(other_item)
        expect(group.group_friends.count).to eq(0)

        expect(group.enemies.count).to eq(0)
      end
    end    

    context 'enemy' do
      let (:is_friend) { false }

      it 'should have an enemy' do
        expect(group.enemies.count).to eq(1)
        expect(group.enemies.first).to eq(other_item)
        expect(group.group_enemies.count).to eq(0)

        expect(group.friends.count).to eq(0)
      end
    end        
  end
end