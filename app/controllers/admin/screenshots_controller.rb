class Admin::ScreenshotsController < AdminApplicationController
  before_filter :require_admin

  def destroy
    confirm_operation do
      document = Document.get(params[:document_id]).first
      if document && document.screenshots.destroy(params[:id])
        flash[:notice] = t(:notice_destroy_screenshot)
      else
        flash[:error] = t(:error_destroy_document_file)
      end
      redirect_to edit_document_url params[:document_id], :tab => 'screenshots'
    end
  end


end
