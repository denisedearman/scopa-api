Rails.application.routes.draw do
  resources :players, except: [:new, :edit, :destroy]
  resources :games, except: [:new, :edit, :update, :destroy]
  resources :games, only:[] do
    resources :players, only:[:show, :edit, :update]
  end
  get '/games/:id/play' => 'games#play'
  get '/games/:id/summary' => 'games#summary'
end
