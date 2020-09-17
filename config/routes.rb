Rails.application.routes.draw do
	 resources :users
	 resources :interviews
  
	 root "interviews#index"
end
