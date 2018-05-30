Rails.application.routes.draw do
  
  delete 'relationships/:relation_id/:redirect_id', to: 'relationships#destroy', as: :delete_relation
  # resources :relationships
  post 'objects', to: 'objects#index', as: :objects
  post 'objects/:object', to: 'objects#index', as: :objects_objects

  get '/groups/count', to: 'groups#count'
  get '/items/count', to: 'items#count'

  resources :groups
  get 'groups/:group_id/items', to: 'groups#items'

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

  resources :gardens do
    resource :nursery do
      resources :nursery_items
    end

    resources :plots do
      resources :boxes, only: [:index, :edit]
    end
  end

  resources :plots do
    resources :crops
  end
  # get 'plots/:plot_id/crops', to: 'crops#index'
  # post 'plots/:plot_id/crops', to: 'crops#create'
  # put 'plots/:plot_id/crops/:id', to: 'crops#update'

  get 'plots/:plot_id/crops/:id/items', to: 'crops#index_items'
  post 'plots/:plot_id/crops/:id/items', to: 'crops#add_item'

  get 'items/:item_id/spacings', to: 'spacings#index'
  post 'items/:item_id/spacings', to: 'spacings#create'
  put 'items/:item_id/spacings/:spacing_id', to: 'spacings#update'

  get 'spacings/square/new', to: 'spacings#new_square'
  get 'spacings/corner/new', to: 'spacings#new_corner'

  get 'library', to: 'library#index'
  
  root to: 'home#index'
end
