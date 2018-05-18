class RelationshipsController < ApplicationController
  before_action :set_item, only: [:destroy]
  before_action :set_relation, only: [:destroy]

  def destroy
    @relation.destroy
    redirect_to item_relationships_url(@item)
  end

  private
  def set_item
    @item = Item.find(params[:redirect_id])
  end

  def set_relation
    @relation = Relationship.find(params[:relation_id])
  end  
end
