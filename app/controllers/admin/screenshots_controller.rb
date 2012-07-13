class Admin::ScreenshotsController < AdminApplicationController
  before_filter :require_admin
  before_filter :nested_document

  respond_to :json


  def create
    screenshot = @document.screenshots.new params[:document]  
    respond_with(screenshot) do |format|
      if screenshot.save
        format.json {render :json => {:url => screenshot.screenshot.url.to_json, :id => screenshot.id}}
      else
        format.any {render :nothing => true}
      end
    end    
  end

  def destroy
    ids = params[:ids].split(',')
    @document.screenshots.where(:id => ids).destroy_all
    respond_with(nil) do |format|
      format.js {render :json => {:ids => ids}}
      format.any {render :nothing => true}
    end    
  end  

protected

  def nested_document
    @document = Document.find_by_id(params[:document_id])    
  end

end
