Rails.application.routes.draw do
	 require 'sidekiq/web'
  	 mount Sidekiq::Web => "/sidekiq"
	 resources :users
	 resources :interviews
  
	 root "interviews#index"
end
