class ObjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @results = {
      items: Item.where('name like ?', "#{params[:object_search][:token]}%"),
      groups: Group.where('name like ?', "#{params[:object_search][:token]}%")
    }
  end
end