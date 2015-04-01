Rails.application.routes.draw do
  resources :contacts do
    get :download, on: :collection
    put :upload, on: :collection
  end
end
