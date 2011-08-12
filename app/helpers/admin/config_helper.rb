module Admin::ConfigHelper
  
  def cfg_read_value(name)
    Cfg.getvalue(name).to_s
  end

  def self.sitename
    Cfg.read 'sitename', nil
  end
  
  def self.adminemail
    Cfg.read 'adminemail', nil
  end

  def config_tabs
    [{:name => 'options', :partial => 'options', :label => :tab_options},
     {:name => 'notify', :partial => 'notify', :label => :tab_notify}]
  end

  def notify_tabs
    [{:name => 'notify_activation', :partial => 'notify_activation', :label => :tab_notify_activate_user},
     {:name => 'notify_deactivation', :partial => 'notify_deactivation', :label => :tab_notify_deactivate_user}]
  end

  def document_tabs
    [{:name => 'general', :partial => 'general', :label => :tab_general},
     {:name => 'screenshots', :partial => 'screenshots', :label => :tab_screenshots}]
  end

end
