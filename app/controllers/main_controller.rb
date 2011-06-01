class MainController < MainApplicationController
  layout = 'main'
  $contents = ['main','greeting']
  
  before_filter :require_user, :only => []
  before_filter :load_contents, :only => [:index]
  

  def download
    document = Document.getlist.find_by_id(params[:document_id])
    document_file = document.document_files.find_by_id(params[:file_id])
    raise DownloadFileNotFound unless document && document_file
    raise DownloadDenied unless document.downloadable?(current_user)
    #  Counter of hits
    document_file.increment!(:hits)
    download_to({:filelist_id => document_file.filelist_id})
  end
    
  def index
  end

  def documents
    @categories = Category.getlist.section(params[:section_id])
    if (params[:category_id].present? and Category.find_by_id(params[:category_id]).nil?) or (not @categories.present?)
      redirect_to home_url and return
    end
    @documents = Document.getlist.section(params[:section_id]).category(params[:category_id]).paginate :page => params[:page], :per_page => 5
  end

  def product
    @document = Document.find_by_id(params[:id]);
    @document_menu = Menu.permitted.find_by_id(@document.menu_id) unless @document.menu.nil?
    @document_menu_items = @document_menu.menu_items unless @document_menu.nil?
#  rescue
#    render 'errors/filenotfound'
  end

  def products
    @products = Document.published.getlist.getrows :per_page => 5, :page => params[:page]
  end

  def contacts
    
  end
  
  private

  def load_contents
    @contents = StaticContent.getrows 
  end
  
end
