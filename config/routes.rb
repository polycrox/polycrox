Rails.application.routes.draw do
  
  delete 'relationships/:relation_id/:redirect_id', to: 'relationships#destroy', as: :delete_relation
  # resources :relationships
  post 'objects', to: 'objects#index', as: :objects

  resources :groups
  resources :items do
    # resource :properties
    

    get 'relationships', to: 'item_relationships#index'
    post 'relationships', to: 'item_relationships#create'

  
    post 'group_relationships/:group_id', to: 'group_relationships#create', as: :group_relationships


  end


  post 'items/:item_id/properties', to: 'properties#create', as: :item_properties

  get 'items/:item_id/properties/edit', to: 'properties#edit', as: :edit_item_properties
  delete 'items/:item_id/properties/:id', to: 'properties#destroy', as: :delete_item_properties
  
  resources :form_properties


  root to: 'items#index'
end
