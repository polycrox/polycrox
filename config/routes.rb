Rails.application.routes.draw do
  
  resources :items do
    # resource :properties
  end
  post 'items/:item_id/properties', to: 'properties#create', as: :item_properties

  get 'items/:item_id/properties/edit', to: 'properties#edit', as: :edit_item_properties
  delete 'items/:item_id/properties/:id', to: 'properties#destroy', as: :delete_item_properties
  
  resources :form_properties

  resources :fidjis
  resources :gardens do
    resources :plots do
      resources :boxes
    end
  end
  root to: 'home#index'
end
