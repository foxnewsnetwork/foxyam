Fuxueyan::Application.routes.draw do
  devise_for :users,
    class_name: 'FoxYam::User',
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :companies do
    resources :negotiations, only: [:index], controller: 'companies/negotiations'
  end

  resources :users, only: [:show]
  resources :merchants, only: [:show] do
    resources :negotiations, only: [:index], controller: 'merchants/negotiations'
    resources :email_accounts, only: [:index], controller: 'merchants/email_accounts'
    resources :email_accounts, only: [:new, :create], controller: 'merchants/create_accounts'
  end

  resources :communications, only: [:show]
  resources :offers, only: [:show, :destroy]
  resources :negotiations, only: [:show] do
    resources :buyers, only: [:new, :create], controller: 'negotiations/buyers'
    resources :email_companies, only: [:edit, :update], controller: 'negotiations/email_companies'
  end

  resources :scrape_accounts, only: [:update]
  resources :email_accounts, only: [:show] do
    resources :email_inboxes, only: [:index], controller: 'email_accounts/email_inboxes'
  end
  resources :email_inboxes, only: [:show] do
    resources :emails, only: [:index], controller: 'email_inboxes/emails'
  end
  resources :emails, only: [:show] do
    resources :negotiations, only: [:edit, :update], controller: 'emails/edit_negotiations'
    resources :negotiations, only: [:new, :create], controller: 'emails/negotiations'
  end

  resources :conversations, only: [:show] do
    resources :companies, only: [:edit, :update], controller: 'conversations/edit_companies'
    resources :companies, only: [:new, :create], controller: 'conversations/companies'
    resources :tags, only: [:index, :create], controller: 'conversations/tags'
    resources :pictures, only: [:new, :create], controller: 'conversations/pictures'
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
