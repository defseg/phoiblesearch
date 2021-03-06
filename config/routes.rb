Rails.application.routes.draw do
  root to: 'home#home'
  get '/info' => 'home#info', as: :info
  get '/languages' => 'languages#index', as: :languages
  get '/languages/text_search' => 'languages#text_search', as: :text_search
  get '/languages/text_search_results' => 'languages#text_search_results', as: :text_search_results
  get '/languages/:language_code' => 'languages#by_code', as: :language_by_code, constraints: { language_code: /[a-z]+/}
  get '/languages/:id' => 'languages#show', as: :language
  get '/search' => 'languages#search', as: :search
  get '/search_results' => 'languages#search_results', as: :language_search_results
  resources :phonemes, only: [:index, :show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
