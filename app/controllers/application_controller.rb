class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :garden_template

  def garden_template
    @layout_garden_template = false
  
    if params[:garden_id].present? || (params[:controller] == "gardens" && params[:action] != "index")
      @layout_garden_template = true
    end
  end
end
