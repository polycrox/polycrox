class PropertiesController < ApplicationController
 skip_before_action :verify_authenticity_token
 before_action :set_item, only: [:create, :edit, :destroy]
 before_action :set_property, only: [:destroy]
  
  def edit
    @form_properties = FormProperty.all
  end
  
  def create
    # binding.pry
    params[:properties].each do |form_prop_id, hash|
      
      # next if !hash["value"].present? || hash["value"].empty? || hash["value"].nil?
      if hash["value"].is_a? Array
        value = hash["value"].join(',')
      else
        value = hash["value"]
      end
      @form_prop_id = form_prop_id.to_i
      
      @fp = FormProperty.find(@form_prop_id)

      if @item.form_property_ids.include?(@form_prop_id)
        @prop = @item.update_property(@form_prop_id, value)

      else 
        @prop = @item.create_property(@form_prop_id, value)
      end

    end
    
  end

  def destroy
    @form_prop_id = @property.form_property_id
    @property.destroy
  end
  
  private
  

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_property
    @property = Property.find(params[:id])
  end  
end