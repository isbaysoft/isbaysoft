ActionController::Routing::Routes.draw do |map|
  map.home '', :controller => 'main', :action => 'index'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.registration 'registration', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.productfile 'file/:document_id/:file_id', :controller => 'main', :action => 'download'
  map.administrator 'administrator', :controller => 'admin/administrator'
  map.dialog 'dialog/:dialog_name', :controller => 'dialogs', :action => 'show_dialog'

  map.resources :products do |e|
    e.resources :screenshots
  end

#END FRONTEND  **********************************

  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resource :config, :controller => 'admin/config'

  map.resources :users,
    :member => {:activate => :get}

  map.resources :sections, :controller => 'admin/sections'

  map.resources :categories, :controller => 'admin/categories'
  map.resources :filelists, :controller => 'admin/filelists',
    :member => {:download => :get}
  map.resources :documents, :controller => 'admin/documents',
    :member => {
      :publish => :post,
      :unpublish => :post
    } do |e|
    e.resources 'file', :controller => 'admin/document_files', :only => [:destroy]
    e.resources 'screenshots', :controller => 'admin/screenshots', :only => [:destroy,:show]
  end

  map.resources :userlists, :controller => 'admin/userlists',
    :member => {
      :activate => :post,
      :deactivate => :post
    }
  map.resources :contents, :controller => 'admin/static_contents'
  map.resources :usergroups, :controller => 'admin/usergroups'

  map.resources :menus, :controller => 'admin/menus', :member => {
        :reordering => :post,
        :save_sorting => :post,
        :publish => :post,
        :unpublish => :post
      } do |menu|
    menu.resources :menu_items, :controller => 'admin/menu_items',
      :name_prefix => nil, :member => {
        :publish => :post,
        :unpublish => :post
      }
  end

  map.resources 'show', :controller => 'static_content'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '*path', :controller =>  'main_application', :action => 'p404'
end
