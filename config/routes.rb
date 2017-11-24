Rails.application.routes.draw do
  resources :players, except: [:new, :edit, :update, :destroy]
end
