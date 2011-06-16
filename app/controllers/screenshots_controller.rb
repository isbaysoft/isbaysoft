class ScreenshotsController < MainApplicationController

  def index
    @document = Document.get(params[:product_id]).published.approved.first
  end

end
