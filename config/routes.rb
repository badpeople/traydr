ActionController::Routing::Routes.draw do |map|

  map.connect 'blog/:year/:month/:title', :controller => 'posts', :action => 'show'

  map.blog 'blog',:controller => 'posts',:action=>"index"

  map.resources :posts

  map.resources :reviews

  map.resources :reviews

  map.resources :smsalerts

  map.resources :emailalerts

  map.resources :subscriptions,:collection=>{:ajax_create=>[:get,:post],:order_completed =>[:get,:post],:order_done =>:get,:order_cancel=>:get} 

  map.resources :systems
                                                
  map.resources :profiles

  map.contact 'contact', :controller => 'dashboard', :action => 'contact'
  map.contact 'disclaimer', :controller => 'dashboard', :action => 'disclaimer'
  map.contact 'why_join', :controller => 'dashboard', :action => 'why_join'
  map.contact 'join_us', :controller => 'dashboard', :action => 'why_join2'

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.welcome 'welcome', :controller => 'users', :action => 'welcome'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :users

  map.confirm 'confirm',:controller=> 'users',:action =>'confirm_email'
  map.confirm 'resend',:controller=> 'users',:action =>'resend_confirmation'
  map.faq 'faq',:controller=>'dashboard',:action=>'faq'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "users", :action => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect 'sitemap.xml', :controller => "sitemap", :action => "sitemap"
end
