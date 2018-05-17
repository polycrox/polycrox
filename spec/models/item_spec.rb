require 'rails_helper'

RSpec.describe ItemBuilder, type: :model do
  before {

    @item = ItemBuilder.new(item_name: 'onion', group_names: group_names)
    @item.save
  }

  context '0 group' do
    let (:group_names) { [''] }
    it 'should fail' do
      expect(Item.count).to eq(0)
    end
  end

  context 'one group' do
    let (:group_names) { ['allium'] }
    it 'should create an Item and an Group' do
      
      expect(Item.count).to eq(1)
      expect(Group.count).to eq(1)

      expect(Item.first.groups.first).to eq(Group.first)
    end
  end

  context 'two groups' do
    let (:group_names) { ['allium', 'solano'] }

    it 'should create an Item and two Groups' do
      expect(Item.count).to eq(1)
      expect(Group.count).to eq(2)

      expect(Group.first.items.count).to eq(1)
      expect(Group.second.items.count).to eq(1)
    end

    it 'should remove' do
      Item.first.destroy

      expect(Group.first.items.count).to eq(0)
      expect(Group.second.items.count).to eq(0)

    end
  end
end

RSpec.describe Group, type: :model do
  describe 'find_or_create' do
    context 'Group does not exist yet' do
      it 'should create an Group' do
        item_group = Group.find_or_create(name: 'item_group')
        expect(Group.count).to eq(1)
      end
    end

    context 'Group does exist' do
      before {
        item_group = Group.find_or_create(name: 'item_group')
      }

      it 'should create an Group' do
        item_group = Group.find_or_create(name: 'item_group')
              
        expect(Group.count).to eq(1)
        expect(item_group).to eq(Group.first)
      end
    end    
  end
end
