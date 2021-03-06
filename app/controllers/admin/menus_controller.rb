class Admin::MenusController < AdminApplicationController
  before_filter :require_admin
  before_filter :find_menu, :only => [:edit,:update,:reordering, :save_sorting]

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
        redirect_to admin_menus_url
      else
        flash[:error] = t(:error_destroy_section)
        render :action => 'index'
      end
    end
  end

  def reordering
    @menu.reordering
    redirect_to admin_menu_menu_items_url(@menu)
  end

  def save_sorting
    order_values = params[:orders]
    ids = params[:ids]
    ids.each_index do |i|
      menuitem = MenuItem.find_by_id(ids[i])
      menuitem.update_attribute('sort_no', order_values[i]) unless menuitem.nil?
    end if ids.is_a?(Array) && (order_values.length == ids.length) && (order_values.all?{|v| is_numeric?(v)}) && (ids.all?{|v| is_numeric?(v)})
    redirect_to admin_menu_menu_items_url(@menu)
  end

  def publish
    if params.has_key?(:ids)
      Menu.update_all(["published = ?",true], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_publish_documents)
    end
    redirect_to admin_menus_url
  end

  def unpublish
    if params.has_key?(:ids)
      Menu.update_all(["published = ?",false], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_unpublish_documents)
    end
    redirect_to admin_menus_url
  end

protected

  def is_numeric?(object)
    true if Float(object) rescue false
  end

  def find_menu
    @menu = Menu.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
