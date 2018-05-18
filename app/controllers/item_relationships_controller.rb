class GroupRelationshipsController < ApplicationController
  before_action :set_group, only: [:index, :create, :destroy]

  def index
  end

  def create
    relation = Relationship.new(group_relationship_params)
    relation.group_id = @group.id
    relation.save

    redirect_to item_relationships_url(item_id: params[:item_id])
  end

  def destroy
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_relationship_params
    params.require(:group_relation).permit(:is_friend, :other_item_id, :other_group_id)
  end
end


class ItemRelationshipsController < ApplicationController
  before_action :set_item, only: [:index, :create, :destroy]


  def index
    @redirect_id = @item.id
  end
  
  def create
    relation = Relationship.new(item_relationship_params)
    relation.item_id = @item.id
    relation.save
    redirect_to item_relationships_url(@item)
  end

  def destroy
    if params[:other_item_id].present?
      relation = Relationship.find_by_item_id_and_other_item_id(@item.id, params[:other_item_id])
    elsif params[:group_id].present?
      relation = Relationship.find_by_item_id_and_group_id(@item.id, params[:group_id])
    end

    relation.destroy
    redirect_to item_relationships_url(@item)
  end
  
  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_relationship_params
    params.require(:item_relation).permit(:is_friend, :other_item_id, :other_group_id)
  end
end