class Admin::DocumentsController < AdminApplicationController
  before_filter :require_admin
  before_filter :load_section, :only => [:new, :create, :edit, :update]
  before_filter :document_find, :only => [:edit, :update]
  before_filter :load_categories_at_params, :only => [:create, :update]

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

  def update
    @logo = Logo.new params[:logo] if params[:logo].present?
    if @logo && @logo.valid? && @logo.save
      @document.logo.destroy if @document.logo.present?
      @document.logo = @logo
    end
    update_attributes_and_redirect(@document,params[:document]) do
      @file = Filelist.new params[:file] if params[:file].present?
      if @file && @file.valid? && @file.save
         @document.filelists << @file
      end
    end # END update_attributes_and_redirect
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

  def file_add
    @file = Filelist.get(params[:id]).first
    @document = Document.get(params[:document_id]).first
    @document.filelists << @file if @file.present? and @document.present?
    @docfile = @document.document_files.find_by_filelist_id(params[:id])
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
