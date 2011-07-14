class DownloadsController < MainApplicationController

  def index
    @products = Document.published.getlist.getrows :per_page => 20, :page => params[:page]
  end

end
