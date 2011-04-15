class Admin::FilelistsController < AdminApplicationController
  before_filter :require_admin
 
  def load_configs
    @controlleralias = I18n.t(:controller_filelists_name)
    super
  end

  def index
    @filelists = Filelist.getrows page_options
  end

  def new
    @filelist = Filelist.new
  end

  def create
    @filelist = Filelist.create(params[:filelist])
    # disable redirect to edit after create
    params[:task] = nil
    create_and_redirect(@filelist)
end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Filelist.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_filelist)
        redirect_to filelists_url
      else
        flash[:error] = t(:error_destroy_filelist)
        render :action => 'index'
      end
    end
  end

  def download
    download_to(params)
  end
  
end
