Rails.application.routes.draw do
	root to: 'volunteers#index'
	devise_for :admins
	get '/groups/:id/volunteers' => 'groups#show_volunteers',as: 'show_volunteers'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resources :volunteers,only: [:index, :show]
	resources :groups,only: [:new, :index, :create, :show, :edit, :destroy, :update]
end
