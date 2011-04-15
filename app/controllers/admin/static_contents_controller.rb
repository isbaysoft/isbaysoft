class Admin::StaticContentsController < AdminApplicationController
  before_filter :require_moderator

  def load_configs
    @controlleralias = 'Статический контент'
    super
  end
  
  def index
    @contents = StaticContent.getrows page_options
  end

  def new
    @content = StaticContent.new
  end

  def create
    @content = StaticContent.new(params[:static_content])
    @content.user_id = current_user.id
    create_and_redirect(@content)
  end

  def edit
    @content = StaticContent.find(params[:id])
  end

  def update
    @content = StaticContent.find(params[:id])
    @content.user_id = current_user.id
    update_attributes_and_redirect @content, params[:static_content]
  end

  def destroy
    confirm_multiple_operations params[:ids] do
      if StaticContent.destroy_all(['id in (?)',session[current_session_ids]])
        flash[:notice] = t(:notice_destroy_content)
        redirect_to contents_url
      else
        flash[:error] = t(:error_destroy_content)
        render :action => 'index'
      end
    end
  end
    
end
