class ItemsController < ApplicationController
  before_action :set_items, only: [:index]
  before_action :set_groups, only: [:index]

  def index
    # @item_groups = ItemGroup.all.collect {|group| group.name }
  end

  def show
    item
        
  end

  def create
    item = ItemBuilder.new(
      item_name: new_item_params[:name], 
      group_names: group_names)

    item.save
    redirect_to items_path
  end

  def destroy
    item.destroy
    redirect_to items_path
  end

  # def edit
  #   item
  #   @form_properties = FormProperty.all
  # end
  
  private
  def new_item_params
    params.require(:new_item).permit(:name, :new_group_name, selected_group_names: [])
  end

  def item
    @item = Item.find(params[:id])
  end

  def set_items
    @items = Item.all
  end

  def set_groups
    @groups = Group.all
  end  

  def group_names
    @group_name ||= if new_item_params[:new_group_name].empty?
      selected_group_names
    else
      [new_item_params[:new_group_name]]
    end
  end

  def selected_group_names
    @selected_group_names ||= new_item_params[:selected_group_names].delete_if do |i|
      i.empty?
    end
  end

end