class GroupsController < ApplicationController
  before_action :set_group, only: [:items]

  def index
    render json: Group.all.to_json(include: :items)
  end

  def count
    render json: Group.all.count
  end

  def items
    render json: @group.items
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end