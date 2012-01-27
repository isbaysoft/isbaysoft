class Admin::ScreenshotsController < AdminApplicationController
  before_filter :require_admin

  def destroy
    confirm_operation do 
      begin
        document = Document.get(params[:document_id]).first
        if document && document.screenshots.destroy(params[:id])
          flash[:notice] = t(:notice_destroy_screenshot)
        else
          flash[:error] = t(:error_destroy_document_file)
        end
      rescue
        flash[:error] = t(:error_destroy_document_file)
      ensure
        redirect_to edit_admin_document_url params[:document_id], :tab => 'screenshots'
      end
    end
  end


end
