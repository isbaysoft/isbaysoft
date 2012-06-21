class Admin::DocumentFilesController < AdminApplicationController
  before_filter :find_document_filter

  respond_to :js,:json,:html

  def create
    
    file = @document.filelists.create(params[:filelist])
    respond_with(file) do |format|
      format.json {render :json => {
        :url => file.f.url, 
        :size => file.f_file_size,
        :name => file.f_file_name,
        :id => file.id}
      }.to_json
      format.any {render :nothing => true}
    end 
  end

  def destroy
    ids = params[:ids].split(',')
    @document.filelists.where(:id => ids).destroy_all
    respond_with(nil) do |format|
      format.js {render :json => {:ids => ids}}
      format.any {render :nothing => true}
    end    
  end

protected

  def find_document_filter
    @document = Document.find(params[:document_id]) rescue nil
  end
  
end
