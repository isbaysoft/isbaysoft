class Admin::DocumentFilesController < AdminApplicationController

  def destroy
    confirm_operation do
      document = Document.get(params[:document_id]).first
      if document.document_files.destroy(params[:id])
        flash[:notice] = t(:notice_destroy_document_file)
      else
        flash[:error] = t(:error_destroy_document_file)
      end
      redirect_to edit_document_url params[:document_id]
    end
  end
  
end
