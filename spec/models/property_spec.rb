require 'rails_helper'

RSpec.describe Property, type: :model do
  
  
  before {
    @prop_height = FormProperty.create(name: 'height', html: :input)
    @item = ItemBuilder.new(item_name: 'onion', group_names: ['allium'])
    @item.save    
  }

  it 'should create a property height with a value of 20' do
    @item.create_property(form_prop_id: @prop_height.id, value: '20')

    expect(@item.properties.count).to eq(1)
    expect(@item.properties[:height]).to eq('20')
  end

  it 'should return nil for unknown prop' do
    expect(@item.properties[:foo]).to eq(nil)
  end


end