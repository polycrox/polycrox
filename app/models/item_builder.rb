class ItemBuilder

  attr_reader :item

  def initialize item_name:, group_names:
    @item = Item.new
    @item.name = item_name
  
    group_names.each do |name|
      @item.groups << Group.find_or_create(name: name)
    end
  end
  
  def save
    @item.save
  end

  def create_property form_prop_id:, value:
    @item.create_property(form_prop_id, value)
  end

  def properties
    @item.hash_properties
  end



end