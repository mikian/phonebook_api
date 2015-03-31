Rails.application.routes.draw do
  resources :contacts do
    get :download, on: :collection
  end
end
