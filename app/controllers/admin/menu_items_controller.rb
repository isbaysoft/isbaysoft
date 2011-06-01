class Admin::MenuItemsController < AdminApplicationController
  before_filter :require_admin
  before_filter :find_menu
  before_filter :find_menu_item, :only => [:edit, :update, :reordering]
  before_filter :after_load_configs

  def load_configs
    @controlleralias = I18n.t(:controller_menu_item_name)
    super
  end

  def index
    @menu_items = @menu.menu_items.getrows page_options unless @menu.menu_items.nil?
  end

  def new
    @menu_item = @menu.menu_items.new
  end

  def create
    @menu_item = @menu.menu_items.new params[:menu_item]
    @menu_item.access_level = params[:menu_item][:access_level]
    @menu_item.published = params[:menu_item][:published]
    create_and_redirect(@menu_item)
  end

  def edit
#    routes = ActionController::Routing::Routes.recognize_path("/show/1", {:method => :get})
  end

  def update
    @menu_item.access_level = params[:menu_item][:access_level]
    @menu_item.published = params[:menu_item][:published]
    update_attributes_and_redirect(@menu_item,params[:menu_item])
end

  def destroy
    confirm_multiple_operations params[:ids] do
      if MenuItem.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_section)
        redirect_to menu_items_url
      else
        flash[:error] = t(:error_destroy_section)
        render :action => 'index'
      end
    end
  end

  def publish
    if params.has_key?(:ids)
      @menu.menu_items.update_all(["published = ?",true], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_publish_documents)
    end
    redirect_to menu_items_url(@menu)
  end

  def unpublish
    if params.has_key?(:ids)
      @menu.menu_items.update_all(["published = ?",false], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_unpublish_documents)
    end
    redirect_to menu_items_url(@menu)
  end
  
protected

  def find_menu
    @menu = Menu.find(params[:menu_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_menu_item
    unless @menu.menu_items.nil?
      @menu_item = @menu.menu_items.find(params[:id])
    end
    render_404 if @menu_item.nil?
  end

  def after_load_configs
    @controlleralias += " - #{@menu.title}" unless @menu.nil?
  end
end
