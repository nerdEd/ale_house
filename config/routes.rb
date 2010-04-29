ActionController::Routing::Routes.draw do |map|
  map.root :controller => "neighborhoods", :action => "index"
  
  map.resources :neighborhoods do |n|
    n.resources :ale_houses, :collection => {:listing => :get}
  end
  
  map.login "/login", :controller => "authorizations", :action => "login"
  map.logout "/logout", :controller => "authorizations", :action => "logout"
  map.admin "/admin", :controller => "authorizations", :action => "index"
  map.geocode '/geocode', :controller=>'geocoding', :action=>'geocode'
end
