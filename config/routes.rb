Isbaysoft::Application.routes.draw do
  root :to => 'main#index'

  match 'login' => 'user_sessions#new', :as => :login, :via => 'get'  
  match 'login' => 'user_sessions#create', :as => :login, :via => 'post'  
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
  match 'administrator' => 'admin/administrator#index', :as => :administrator
  match 'registration' => 'users#new', :as => :registration
  match 'file/:document_id/:file_id' => 'main#download', :as => :productfile
  match 'smsdostup' => 'admin/smsdostup#billing', :as => :smsdostup
  match 'downloads' => 'downloads#index', :as => :downloads
  match 'dialog/:dialog_name' => 'dialogs#show_dialog', :as => :dialog
  

  resources :show

# admin section
  namespace :admin do
    resources :usergroups
    resources :userlists do
      member do
        post :deactivate
        post :activate
      end
    end
    resource :config
    resources :static_contents, :as => 'contents'
    resources :menus do
      member do
        post :reordering
        post :save_sorting
        post :publish 
        post :unpublish
      end
      resources :menu_items, :name_prefix => nil do
          member do
            post :publish
            post :unpublish
          end
      end
    end 
    resources :menu_items
    resources :sections
    resources :categories
    resources :filelists do
      member do
        get :download
      end
    end
    resources :documents do
      member do
        post :publish
        post :unpublish
      end
      resource :logo, :only => [:create]
      resources :screenshots, :only => [:create, :destroy]

      resources :file, :only => [:destroy]
      resources :document_files
    end
  end
# end admin section block

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

  match '/:controller(/:action(/:id))'
  match '*path' => 'main_application#p404'
end
