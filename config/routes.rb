Rails.application.routes.draw do
  resources :players, except: [:new, :edit, :update, :destroy]
  resources :games, except: [:new, :edit, :update, :destroy]
  resources :games, only:[] do
    resources :players, only:[:show]
  end
  get '/games/:id/play' => 'games#play'
end
