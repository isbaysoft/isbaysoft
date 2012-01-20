class Admin::CategoriesController < AdminApplicationController
  before_filter :require_admin
  before_filter :category_find, :only => [:edit,:update]

  def load_configs
    @controlleralias = I18n.t(:controller_categories_name)
    super
  end

  def index
    @categories = Category.getrows page_options
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    create_and_redirect(@category)
  end

  def edit
  end

  def update
    update_attributes_and_redirect(@category,params[:category])
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Category.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_category)
        redirect_to admin_categories_url
      else
        flash[:error] = t(:error_destroy_category)
        render :action => 'index'
      end
    end    
  end

  protected

  def category_find
     @category = Category.find(params[:id])    
  end

end