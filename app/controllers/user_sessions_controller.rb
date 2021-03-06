class UserSessionsController < MainController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful! #{params[:user_session]}"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    flash[:notice] = "Logout successful!"
    redirect_to root_url
  end
end
