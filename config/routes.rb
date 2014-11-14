UpgSequences::Application.routes.draw do
  namespace :admin do
    match 'login', :to => 'user_sessions#new', :as => 'login'
    match 'logout', :to => 'user_sessions#destroy', :as => 'logout'
    match 'paid_unpaid/:id', :to => 'sequence_requests#paid_unpaid', :as => 'paid_unpaid'
    match 'cancel/:id', :to => 'sequence_requests#cancel', :as => 'cancel'
    match 'add_sequence_request_detail', :to => 'sequence_requests#add_sequence_request_detail', :as => 'add_sequence_request_detail'
    match 'download_file', :to => 'sequence_requests#download_file', :as => 'download_file'
    match 'send_results/:id', :to => 'sequence_requests#send_results', :as => 'send_results'
    match 'generate_and_download_xls', :to => 'sequence_requests#generate_and_download_xls', :as => 'generate_and_download_xls'
    match 'reports_by_ur', :to => 'sequence_requests#reports_by_ur', :as => 'reports_by_ur'
    post 'generate_reports_by_ur', :to => 'sequence_requests#generate_reports_by_ur', :as => 'generate_reports_by_ur'
    post 'search_by_folio', :to => 'sequence_requests#search_by_folio', :as => 'search_by_folio'
    resources :user_sessions, :users, :sequence_requests,:prices
  end

  resources :sequence_requests

  match 'add_sequence_request_detail', :to => 'sequence_requests#add_sequence_request_detail', :as => 'add_sequence_request_detail'
  match 'sequence_request_sent', :to => 'sequence_requests#sent', :as => 'sequence_request_sent'
  match 'sequence_request_download_file', :to => 'sequence_requests#download_file', :as => 'sequence_request_download_file'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.back.
  # root :to => "welcome#index"
  root :to => "sequence_requests#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
