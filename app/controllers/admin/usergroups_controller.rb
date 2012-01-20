class Admin::UsergroupsController < AdminApplicationController
  before_filter :require_admin
  before_filter :usergroup_find, :only => [:edit, :update]
  
  def load_configs
    @controlleralias = I18n.t(:controller_usergroups_name)
    super
  end

  def index
    @usergroups = Usergroup.getrows page_options
  end

  def new
    @usergroup = Usergroup.new
  end

  def create
    @usergroup = Usergroup.new(params[:usergroup])
    create_and_redirect(@usergroup)
  end

  def edit
  end

  def update
    update_attributes_and_redirect(@usergroup, params[:usergroup])
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if Usergroup.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_usergroup)
        redirect_to admin_usergroups_url
      else
        flash[:error] = t(:error_destroy_usergroup)
        render :action => 'index'
      end
    end
  end

  protected

  def usergroup_find
    @usergroup = Usergroup.find(params[:id])
  end

end
