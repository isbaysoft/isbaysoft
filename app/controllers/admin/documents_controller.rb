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
    update_attributes_and_redirect(@document,params[:document]) do
      if params[:file].present?
        @file = Filelist.new params[:file]
        @document.filelists << @file if @file.save
      end
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

  def file_add
    @file = Filelist.get(params[:id]).first
    @document = Document.get(params[:document_id]).first
    @document.filelists << @file if @file.present? and @document.present?
    @docfile = @document.document_files.find_by_filelist_id(params[:id])
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
