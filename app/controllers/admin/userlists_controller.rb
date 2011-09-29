# coding: utf-8
class Admin::UserlistsController < AdminApplicationController
  before_filter :require_admin
  before_filter :userlist_find, :only => [:update, :edit, :deactivate, :activate]
  before_filter :allow_edit, :only => [:edit, :update, :destroy, :deactivate, :activate]

  def load_configs
    @controlleralias = I18n.t(:controller_userlists_name)
    super
  end

  def index
    @users = User.getrows page_options
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    @user[:access_level] = params[:access_level]
    create_and_redirect(@user)
  end

  def edit
  end

  def update    
    update_attributes_and_redirect(@user,params[:user]) do |obj|
      Regnotification.deliver_event_hello(@user, Cfg.read('user_reg_type','type_manual'))
        obj.access_level = params[:access_level]
        obj.save
    end
  end
  
  def destroy
    confirm_multiple_operations params[:ids] do
      if User.allowobjects(current_user,session[current_session_ids]).destroy_all
        flash[:notice] = t(:notice_destroy_user)
        redirect_to userlists_url
      else
        flash[:error] = t(:error_destroy_user)
        render :action => 'index'
      end
    end
  end

  def activate
    ids = ad_check_ids
    flash[:notice] = t(:notice_select_user_activated)
    User.allowobjects(current_user,ids).deactivated.map {|a| a.activate}
    ad_redirect
  end

  def deactivate
    ids = ad_check_ids
    flash[:notice] = t(:notice_select_user_deactivated)
    User.allowobjects(current_user,ids).activated.map {|a| a.deactivate}
    ad_redirect
  end

  # Check IDs for activate and deactivate actions
  def ad_check_ids
    if (params[:ids].blank? && params[:id].present?)
      ids = params[:id]
    else
      ids = params[:ids]
    end
    ids
  end

protected

  # Action activate and deactivate using multiply redirect 
  def ad_redirect
    if params[:ids].present?
      redirect_to userlists_url
    else
      redirect_to edit_userlist_url(params[:id])
    end
  end

  def userlist_find
    @user = User.find_by_id(params[:id]) unless params[:id].eql?(0)
  rescue ActiveRecord::RecordNotFound
    redirect_to userlists_url unless @user
  end

  def allow_edit
    if @user and @user.access_level > current_user.access_level
      flash[:notice] = 'Редактировать запрещенно. Ваши права ниже по рейтингу.'
      redirect_to userlists_url
    end
  end

end
