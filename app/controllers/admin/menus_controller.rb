class Admin::MenusController < AdminApplicationController
  before_filter :require_admin
  before_filter :find_menu, :only => [:edit,:update,:reordering]

  def load_configs
    @controlleralias = I18n.t(:controller_menus_name)
    super
  end

  def index
    @menus = Menu.getrows page_options
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new params[:menu]
    @menu.access_level = params[:menu][:access_level]
    @menu.published = params[:menu][:published]
    create_and_redirect(@menu)
  end

  def edit
     
  end

  def update
    @menu.access_level = params[:menu][:access_level]
    @menu.published = params[:menu][:published]
    update_attributes_and_redirect(@menu,params[:menu])
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Menu.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_section)
        redirect_to menus_url
      else
        flash[:error] = t(:error_destroy_section)
        render :action => 'index'
      end
    end
  end

  def reordering
    @menu.reordering
    redirect_to menu_items_url(@menu)
  end

protected

  def find_menu
    @menu = Menu.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
