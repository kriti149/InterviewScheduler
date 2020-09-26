Rails.application.routes.draw do
	 require 'sidekiq/web'
  	 mount Sidekiq::Web => "/sidekiq"
	 resources :users
	 resources :interviews
  
	 root "interviews#index"

	 namespace 'api' do
	 	namespace 'v1' do
     		resources :interviews
     		resources :users
     	end
 	 end
end
