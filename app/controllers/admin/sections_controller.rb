class Admin::SectionsController < AdminApplicationController
  before_filter :require_admin
  before_filter :section_find, :only => [:update, :edit]

  def load_configs
    @controlleralias = I18n.t(:controller_sections_name)
    super
  end
  
  def index
    @sections = Section.getrows page_options
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(params[:section])
    create_and_redirect(@section)
  end

  def edit
  end
  
  def update
    update_attributes_and_redirect(@section,params[:section])
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Section.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_section)
        redirect_to sections_url
      else
        flash[:error] = t(:error_destroy_section)
        render :action => 'index'
      end
    end
  end

protected

  def section_find
    @section = Section.find(params[:id])
  end
  
end
