ActionController::Routing::Routes.draw do |map|
  map.home '', :controller => 'catalog', :action => 'index'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.registration 'registration', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.file 'file/:id', :controller => 'catalog', :action => 'download'
  map.administrator 'administrator', :controller => 'admin/administrator'
  map.dialog 'dialog/:dialog_name', :controller => 'dialogs', :action => 'show_dialog'

  map.with_options :controller => 'catalog' do |c|
    c.catalog_section 'section/:section_id', :action => 'documents'
    c.catalog_category 'section/:section_id/category/:category_id', :action => 'documents'
    c.show_document 'doc/:id', :action => 'show'
    c.show_categories 'catalog', :action => 'catalog'
  end
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.resource :config, :controller => 'admin/config'

  map.resources :users,
    :member => {:activate => :get}

  map.resources :sections, :controller => 'admin/sections'

  map.resources :categories, :controller => 'admin/categories'
  map.resources :filelists, :controller => 'admin/filelists',
    :member => {:download => :get}
  map.resources :documents, :controller => 'admin/documents' do |e|
    e.resources 'file', :controller => 'admin/document_files', :only => [:destroy]
  end

  map.resources :userlists, :controller => 'admin/userlists',
    :member => {
      :activate => :post,
      :deactivate => :post
    }
  map.resources :contents, :controller => 'admin/static_contents'
  map.resources :usergroups, :controller => 'admin/usergroups'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '*path', :controller =>  'main_application', :action => 'p404'
end
