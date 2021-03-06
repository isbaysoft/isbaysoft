class Admin::DocumentsController < AdminApplicationController
  before_filter :require_admin
  before_filter :load_section, :only => [:new, :create, :edit, :update]
  before_filter :document_find, 
    :only => [:edit, :update, :upload_screenshots, :delete_screenshots, :upload_logo]
  before_filter :load_categories_at_params, :only => [:create, :update]

  respond_to :json, :js

  def load_configs
    @controlleralias = I18n.t(:controller_documents_name)
    super
  end

  def index
    @documents = Document.getrows page_options
  end

  def show
    #  hook, only edit method allowed
    redirect_to edit_document_url params[:id]
  end

  def new
    @document = Document.new
  end
  
  def create
    @document = Document.new(params[:document])
    create_and_redirect(@document)
  end

  def update    
    update_attributes_and_redirect(@document,params[:document])
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Document.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_document)
        redirect_to admin_documents_url
      else
        flash[:error] = t(:error_destroy_document)
        render :action => 'index'
      end
    end
  end
  
  def get_categories
    @option = Category.find(:all,:conditions => ['section_id=?',params[:id]]).collect { |p| "<option value=#{p.id}>#{p.name}</option>" }
    render :text => @option
  end

  def publish
    if params.has_key?(:ids)
      Document.update_all(["published = ?",true], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_publish_documents)
    end
    redirect_to documents_url
  end

  def unpublish
    if params.has_key?(:ids)
      Document.update_all(["published = ?",false], ["id in (?)",params[:ids]])
      flash[:notice] = t(:notice_unpublish_documents)
    end
    redirect_to documents_url
  end

protected

  def load_section
    @sections = Section.all
  end

  def document_find
    @document = Document.find(params[:id])
  end

  def load_categories_at_params
    @categories = Category.find(:all, :conditions => ['section_id=?',params[:section_id]])
  end
  
end
