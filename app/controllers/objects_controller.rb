class ObjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:object]
      render json: {
        items: Item.where('name like ?', "#{params[:object_search][:token]}%")  
      }
    else

      render json: {
        items: Item.where('name like ?', "#{params[:object_search][:token]}%"),
        groups: Group.where('name like ?', "#{params[:object_search][:token]}%")
      }
    end
  end
end