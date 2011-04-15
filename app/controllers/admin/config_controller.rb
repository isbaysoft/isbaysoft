class Admin::ConfigController < AdminApplicationController
  before_filter :require_admin
  
  def load_configs
    @controlleralias = I18n.t(:controller_configs_name)
    super
  end

  def index
#    hack for toolbar_action for exit
    redirect_to administrator_url
  end

  def show
    load_cfg
  end

  def update
    if params[:options]
      Cfg.save_config(params[:options])
      flash[:notice] = 'Конфигурация обновленна...'
    end
    
    params[:notify].each_pair { |key, value| Memo.write(key, value) } if params[:notify].present?
    
    load_cfg
    redirect_to config_url
  end

  protected

  def load_cfg
    @cfg = Cfg.all
  end

end