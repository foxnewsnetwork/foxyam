Fuxueyan::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :companies do
    resources :negotiations, only: [:index], controller: 'companies/negotiations'
  end

  resources :communications, only: [:show]

  resources :negotiations, only: [:show]

  resources :email_accounts, only: [:show]
  resources :email_inboxes, only: [:show]
  resources :emails, only: [:show] do
    resources :negotiations, only: [:edit, :update], controller: 'emails/edit_negotiations'
    resources :negotiations, only: [:new, :create], controller: 'emails/negotiations' do
      resources :exists, only: [:new, :create], controller: 'emails/negotiations/exists'
    end
  end

  resources :conversations, only: [] do
    resources :companies, only: [:edit, :update], controller: 'conversations/edit_companies'
    resources :companies, only: [:new, :create], controller: 'conversations/companies'
    resources :tags, only: [:index, :create], controller: 'conversations/tags'
  end

  resources :tags, only: [:destroy]

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
