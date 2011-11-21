# coding: utf-8
class UsersController < MainApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :se_singular, :only => [:show, :edit]

  def se_singular
      # TODO: Deprecated method
      # @user = @current_user
  end

  def new
    @user = User.new
  end

  def create    
    @user = User.create(params[:user])
    @user.access_level = 700 #TODO Заменить на значения модели
    if @user.save
      flash[:notice] = "Account registered!"
      Regnotification.event_hello(@user, Cfg.read('user_reg_type','type_manual'))
      Regnotification.event_new_user(@user)
      redirect_to login_url
    else
      render :action => :new
    end
  end

  def update
    if @current_user      
      @user = @current_user # makes our views "cleaner" and more consistent
      if @user.update_attributes(params[:user])
        flash[:notice] = "Account updated!"
        redirect_to account_url
      else
        render :action => :edit
      end
    else
        flash[:notice] = "Incorect user"
    end
  end

  def activate
    @user = User.find_by_id_and_persistence_token(params[:id],params[:activation_code])
    if @user
      @user.access = true
      @user.save
      flash[:notice] = 'Ваш аккаунт активирован'
      redirect_to login_url
    else
      flash[:notice] = 'Ссылка активации не правильная'
      redirect_to login_url
    end
  end
  
end
