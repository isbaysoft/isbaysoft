class ApplicationController < ActionController::Base
  include(CustomApplicationErrors)
  helper :all
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user, :redirect_back_or_default
  before_filter :set_locale
  before_filter :initialize_flash_types
  before_filter :mailer_set_url_options
  before_filter :user_setup


  def default_url_options(options={})
#    logger.debug "default_url_options is passed options: #{options.inspect}\n"
#    { :locale => I18n.locale }
#    
# => Localization changed his mind to do. Possible to do this in the future.
  end
  
private

  def set_locale
    I18n.locale = current_locale
  end

  def current_locale
    'ru'
  end

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def initialize_flash_types
    [:back, :confirm, :error, :info, :warn].each {|type| flash[type] = []}
  end

  def redirect_to_and_notice(redirect_url, notice)
    store_location
    flash[:notice] = notice
    redirect_to redirect_url
    return false
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def user_setup
    # Find the current user
    User.current = current_user_session && current_user_session.record
  end

  def current_user
    return @current_user if defined?(@current_user) and @current_user.access
    @current_user = current_user_session && current_user_session.record
  end

  def require_admin
    redirect_to_and_notice home_url, "Доступ запрещен" unless current_user and current_user.allow('Administrator')
  end

  def require_user
    redirect_to_and_notice new_user_session_path, "You must be logged in to access this page" unless current_user
  end

  def require_no_user
    redirect_to_and_notice home_url, "You must be logged out to access this page" if current_user
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

protected

  def create_and_redirect(create_object, options = 
      { :redirect => url_for(:action => 'index'),
        :render => 'new',
        :flash_notice => 'Добавление ...',
        :flash_error => 'Ошибка ...'
      })
    if create_object.save
      flash[:notice] = options[:flash_notice]
      if params[:task].present? and params[:task] == 'post'
        redirect_to url_for( :action => 'edit', :id => create_object.id )
      else
        flash[:edited] = create_object.id
        redirect_to options[:redirect]
      end
    else
      flash[:error] = options[:flash_error]
      render :action => options[:render]
    end
  end
  
  def local_request?
    Rails.env.development? or Rails.env.test
  end

  def rescue_action_in_public(exception)
    case exception 
    when ::ActionController::RoutingError 
      render 'errors/404', :status => "404"
    when DownloadDenied then render 'errors/access_denied'
    when DownloadFileNotFound then render 'errors/filenotfound'
    when ::ActiveRecord::StatementInvalid  then render 'errors/databaseerror', :locals => {:mes => exception.message }
    else
      render 'errors/unknown', :locals => {:mes => exception.message }
    end # if Rails.env.production?
  end

  SEND_FILE_METHOD = :default

  def download_to(params)
    file = Filelist.find(params[:filelist_id])
    raise DownloadFileNotFound if file.nil?
    raise DownloadDenied unless file.downloadable?(current_user)
    path = file.f.path
    raise DownloadFileNotFound unless File.exist?(path)
    send_file_options = { :type => file.f_content_type }
    case SEND_FILE_METHOD
      when :apache then send_file_options[:x_sendfile] = true
      when :nginx then head(:x_accel_redirect => path.gsub(Rails.root, ''), :content_type => send_file_options[:type]) and return
    end
    send_file(path, send_file_options)
  end
  
end
