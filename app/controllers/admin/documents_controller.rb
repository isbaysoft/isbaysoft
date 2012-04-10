class Admin::DocumentsController < AdminApplicationController
  before_filter :require_admin
  before_filter :set_active_tab, :load_section, :only => [:new, :create, :edit, :update]
  before_filter :document_find, :only => [:edit, :update]
  before_filter :load_categories_at_params, :only => [:create, :update]

  respond_to :json

  def load_configs
    @controlleralias = I18n.t(:controller_documents_name)
    super
  end

  def index
    @documents = Document.getrows page_options
  end

  def new
    @document = Document.new
    @categories = Category.find(:all, :conditions => ['section_id=?',@sections.first.id])
  end
  
  def create
    @document = Document.new(params[:document])
    create_and_redirect(@document)
  end

  def edit
  end

  def show
#    hook, only edit method allowed
    redirect_to edit_document_url params[:id]
  end

  def update
    add_images = params[:added_documentfilelist_ids]
    del_images = params[:deleted_documentfilelist_ids]
    
    if params[:screenshot].present?
      screenshot = Screenshot.new params[:screenshot]
      @document.screenshots << screenshot if screenshot && screenshot.valid? && screenshot.save
    end
    update_attributes_and_redirect(@document,params[:document]) do
      @file = Filelist.new params[:file] if params[:file].present?
      if @file && @file.valid? && @file.save
         @document.filelists << @file
      end
      
      #  Adding images
      add_images.each do |file_id| 
        file = Filelist.get(file_id).first
        @document.filelists << file if file
      end if add_images
      
      #  Deleting images
      @document.document_files.where('id in (?)',del_images).delete_all if del_images
    end # END update_attributes_and_redirect
  end

  def uploadscreenshot
    document = Document.where(:id => params[:id]).first  
    screenshot = Screenshot.new params[:document]
    document.screenshots << screenshot if screenshot && screenshot.valid? && screenshot.save
    
    respond_with(screenshot) do |format|
      format.json {render :json => {:url => screenshot.screenshot.url.to_json, :id => screenshot.id}}
      format.any {render :nothing => true}
    end    
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Document.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_document)
        redirect_to documents_url
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

  def uploadlogo
    document = Document.where(:id => params[:id]).first  
    logo = Logo.new params[:document]
    
    if logo && logo.valid? && logo.save
      document.logos << logo
    end

    respond_with(logo) do |format|
      format.json {render :json => {:url => logo.logo.url.to_json, :id => logo.id}}
      format.any {render :nothing => true}
    end
  end

protected

  def set_active_tab
    @active_tab_name ||= params[:tab]
  end

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
