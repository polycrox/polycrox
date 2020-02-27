class FormPropertiesController < ApplicationController
  before_action :set_form_prop, only: [:update]
  before_action :set_form_prop_option, only: [:update]

  skip_before_action :verify_authenticity_token

  def create
    @fp = FormProperty.new(
      name: form_property_params[:name], 
      html: form_property_params[:html],
      description: form_property_params[:description],
      options: form_property_params[:options],
      multiple: form_property_params[:multiple])

    @fp.save
    
    @item = Item.find(form_property_params[:item_id]) 
  end

  def update
    @form_prop_option_valid = @fp.set_option(@form_prop_option)
  end

  def update_ajax
    @fp = FormProperty.find(form_property_params_ajax[:id])
    @fp.name = form_property_params_ajax[:name].strip
    @fp.description = form_property_params_ajax[:description].strip
    if @fp.save
      head :no_content
    else
      head :bad_request
    end
  end

  private

  def set_form_prop
    @fp = FormProperty.find(params[:id])
  end

  def set_form_prop_option
    @form_prop_option = params[:form_property][:option]
  end
  
  def form_property_params
    params.require(:form_property).permit(:name, :html, :description, :options, :multiple, :item_id)
  end

  def form_property_params_ajax
    params.require(:form_property).permit(:id, :name, :description)
  end
end

