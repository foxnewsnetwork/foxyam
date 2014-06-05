Fuxueyan::Application.routes.draw do
  default_url_options host: "www.fox_yam.co"
  namespace :apiv1 do
    resources :materials, only: [:index]
    resources :locations, only: [:index]
  end
  devise_for :users,
    class_name: 'FoxYam::User',
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :companies, only: [:show], controller: 'fox_yam/companies' do
    resources :negotiations, only: [:index], controller: 'companies/negotiations'
  end

  resources :buys, only: [:index], controller: 'fox_yam/buys' 
  resources :sells, only: [:index], controller: 'fox_yam/sells' 
  
  resources :contact, only: [:show], controller: 'fox_yam/contact'
  resources :contacts, only: [:edit, :update], controller: 'fox_yam/contacts'

  resources :users, only: [:show] do
    resources :merchants, only: [:index], controller: 'fox_yam/users/merchants'
  end

  resources :sell_conversations, only: [] do
    resources :tags, only: [:index, :create], controller: 'fox_yam/sell_conversations/tags'
    resources :pictures, only: [:index, :create], controller: 'fox_yam/sell_conversations/pictures'
  end

  resources :anon_listings, only: [:new, :create], controller: 'fox_yam/anon_listings'
  resources :anon_wishlists, only: [:new, :create], controller: 'fox_yam/anon_wishlists'

  resources :listings, only: [:edit, :update], controller: 'fox_yam/listings' do
    resources :tags, only: [:index, :create], controller: 'fox_yam/listings/tags'
    resources :pictures, only: [:new, :create], controller: 'fox_yam/listings/pictures'
  end

  resources :merchants, only: [:show], controller: 'fox_yam/merchants' do
    resources :listings, only: [:new, :create], controller: 'fox_yam/merchants/listings'
    resources :wishlists, only: [:new, :create], controller: 'fox_yam/merchants/wishlists'
    resources :negotiations, only: [:index], controller: 'merchants/negotiations'
    resources :email_accounts, only: [:index], controller: 'merchants/email_accounts'
    resources :email_accounts, only: [:new, :create], controller: 'merchants/create_accounts'
  end

  resources :picture_attachment_relationships, only: [:delete]

  resources :communications, only: [:show]

  resources :agree_contracts, only: [:show], controller: 'fox_yam/agree_contracts'

  resources :line_items, only: [:destroy], controller: 'fox_yam/line_items'
  resources :preview_contracts, only: [:show], controller: 'gtps/preview_contracts'
  resources :parties, only: [:update], controller: 'gtps/parties'
  resources :delete_party, only: [:destroy], controller: 'gtps/delete_party'
  resources :delete_document, only: [:destroy], controller: 'gtps/delete_document'
  resources :delete_punishment, only: [:destroy], controller: 'gtps/delete_punishment'
  resources :delete_requirement, only: [:destroy], controller: 'gtps/delete_requirement'
  
  resources :escrow_progressions, only: [:show], controller: 'gtps/escrow_progressions'  
  resources :contracts, only: [] do
    resources :outbound_emails, only: [:new, :create], controller: 'fox_yam/contracts/outbound_emails'
    resources :documents, only: [:create], controller: 'gtps/contracts/documents'
    resources :parties, only: [:create], controller: 'gtps/contracts/parties'
    resources :punishments, only: [:create], controller: 'gtps/contracts/punishments'
    resources :requirements, only: [:create], controller: 'gtps/contracts/requirements'
  end
  resources :offers, only: [:show, :destroy], controller: 'fox_yam/offers' do
    resources :contracts, only: [:create], controller: 'fox_yam/offers/contracts'
    resources :line_items, only: [:index, :create], controller: 'fox_yam/offers/line_items'
    resources :finalizes, only: [:new, :create], controller: 'fox_yam/offers/finalizes'
    resources :neverminds, only: [:new, :create], controller: 'fox_yam/offers/neverminds'
  end
  resources :negotiations, only: [:show], controller: 'fox_yam/negotiations' do
    resources :deaths, only: [:create], controller: 'fox_yam/negotiations/deaths'
    resources :revives, only: [:create], controller: 'fox_yam/negotiations/revives'
    resources :bug_reports, only: [:new, :create], controller: 'fox_yam/negotiations/bug_reports'
    resources :sell_offers, only: [:new, :create], controller: 'fox_yam/negotiations/sell_offers'
    resources :buy_offers, only: [:new, :create], controller: 'fox_yam/negotiations/buy_offers'
    resources :publicizes, only: [:create], controller: 'fox_yam/negotiations/publicizes'
    resources :privatizes, only: [:create], controller: 'fox_yam/negotiations/privatizes'
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
    resources :pictures, only: [:index, :create], controller: 'conversations/pictures'
  end

  resources :tags, only: [:destroy]

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'welcome/unauthorized', controller: 'welcome#unauthorized'

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
