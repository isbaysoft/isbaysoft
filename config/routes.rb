Isbaysoft::Application.routes.draw do
  root :to => 'main#index'

  match 'login' => 'user_sessions#new', :as => :login
  match 'administrator' => 'admin/administrator#index', :as => :administrator
  match 'registration' => 'users#new', :as => :registration
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'file/:document_id/:file_id' => 'main#download', :as => :productfile
  match 'smsdostup' => 'admin/smsdostup#billing', :as => :smsdostup
  match 'downloads' => 'downloads#index', :as => :downloads
  match 'dialog/:dialog_name' => 'dialogs#show_dialog', :as => :dialog
  

# admin section
  resources :show
  resource :config, :controller => 'admin/config'
  resources :static_contents, 
    :controller => 'admin/static_contents',
    :as => 'contents'

  resources :menus, :controller => 'admin/menus' do
    member do
      post :reordering
      post :save_sorting
      post :publish 
      post :unpublish
    end
    resources :menu_items, :name_prefix => nil, :controller => 'admin/menu_items' do
        member do
          post :publish
          post :unpublish
        end
    end
  end 

  resources :menu_items, :controller => 'admin/menu_items'
  resources :sections, :controller => 'admin/sections'
  resources :categories, :controller => 'admin/categories'
  resources :filelists, :controller => 'admin/filelists' do
    member do
      get :download
    end
  end
  resources :documents, :controller => 'admin/documents' do
    member do
      post :publish
      post :unpublish
    end
    resources :file, :only => [:destroy]
    resources :screenshots, :only => [:destroy, :show]
  end
  
# end admin section vlock

  resources :products do
    resources :screenshots
  end

  resources :tickets
  resource :user_session
  resources :users do
    member do
      get :activate
    end
  end

  resources :userlists do
    member do
      post :deactivate
      post :activate
    end
  end

  resources :usergroups

  match '/:controller(/:action(/:id))'
  match '*path' => 'main_application#p404'
end
