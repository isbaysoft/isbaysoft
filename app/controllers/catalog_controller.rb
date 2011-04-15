class CatalogController < MainApplicationController
  layout = 'main'
  $contents = ['main','greeting']
  
  before_filter :require_user, :only => [:show]
  before_filter :load_contents, :only => [:index]
  

  def download
    @document = Document.getlist.find_by_id(params[:id])
    raise DownloadFileNotFound unless @document
    raise DownloadDenied unless @document.downloadable?(current_user)
#    counter of hits
    Document.find_by_id(@document.id).increment!(:hits)
    params[:id] = @document.filelist_id
    download_to(params)
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

  def show
    @document = Document.find_by_id(params[:id]);
    render 'errors/filenotfound' and return unless @document.present?
    @categories = Category.getlist.section(@document.category.section_id)
  end

  def catalog
  
  end

  def contacts
    
  end
  
  private

  def load_contents
    @contents = StaticContent.getrows 
  end
  
end
