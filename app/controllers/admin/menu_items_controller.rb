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
    create_and_redirect(@menu_item)
  end

  def edit
  end

  def update
<<<<<<< HEAD
<<<<<<< .mine    update_attributes_and_redirect(@menu_item,params[:menu_item])
=======    @menu_item.access_level = params[:menu_item][:access_level]
=======
    @menu_item.access_level = params[:menu_item][:access_level]
    @menu_item.published = params[:menu_item][:published]
>>>>>>> 4a3fc6fcef99f2799c229356803556ba66c083fe
    update_attributes_and_redirect(@menu_item,params[:menu_item])
>>>>>>> .theirs  end

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

protected

  def find_menu
    @menu = Menu.find(params[:menu_id])
    @controlleralias += " - #{@menu.title}"

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
