class ProductsController < MainApplicationController

  def index
    @products = Document.published.getlist.getrows :per_page => 5, :page => params[:page]
  end

  def show
    @document = Document.find_by_id(params[:id]);
    @document_menu = Menu.permitted.find_by_id(@document.menu_id) unless @document.menu.nil?
    @document_menu_items = MenuItem.permitted.published.items(@document_menu.id) unless @document_menu.nil?
  rescue
    render 'errors/filenotfound'
  end
  
end
