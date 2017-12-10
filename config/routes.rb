Rails.application.routes.draw do
  resources :players, except: [:new, :edit, :update, :destroy]
  resources :games, except: [:new, :edit, :update, :destroy]
end
