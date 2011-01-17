Sixsoon2::Application.routes.draw do
  match "/auth/:provider/callback" => "sessions#create"  
  match "/user/validate_user_name" => "user#validate_user_name"

  root :to => "home#index" 
  resources :favorites
  resources :search
  resources :votes
  resources :replies
  resources :answers 
  resources :badges
  resources :tags
  resources :questions do
      post 'solved', :on => :member
  end
  resources :user 
  resource :session do
    post 'rpx_token', :on => :member
  end



match "/autocomplete" => "autocomplete#autocomplete"
match "/autocomplete/tags_search" => "autocomplete#tags_search"
match "/autocomplete/users_search" => "autocomplete#users_search"
 
end
