RTedServiceRails::Application.routes.draw do
  get "day_hist_rss/index"

  get "water_img/index"

  get "solar_img/index"

  get "dayhist_updater/tedhist"

  get "home/index"
  get "hist_updater/autoupdate"
  get "ted_data/index"
  get "day_hists/index"
  get "solar_img/index"
  get "water_img/index"
  get "day_hist_rss/index"
  
  post "tedpostserver/init"
  post "tedpostserver/postdata"

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
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match 'tedpostserver/init/' => 'tedpostserver#init', :via => :post, :defaults => {:format => 'xml'}
  match 'tedpostserver/postdata/' => 'tedpostserver#postdata', :via => :post, :defaults => {:format => 'xml'}
  match 'dayhist_updater/autoupdate' => 'dayhist_updater#autoupdate', :via => :get
end
