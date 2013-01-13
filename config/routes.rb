ActionController::Routing::Routes.draw do |map|
  map.connect "album/:id", :controller => "gallery", :action => "album"
  map.connect "", :controller => "gallery", :action => "index"

  # Install the default route as the lowest priority.
  map.connect ":controller/:action/:id"
end
