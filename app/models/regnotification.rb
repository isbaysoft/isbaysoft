class Regnotification < ActionMailer::Base
  cattr_accessor :sitename, :admin_email

  self.sitename = Admin::ConfigHelper.sitename or 'site.com'
  self.admin_email = Admin::ConfigHelper.adminemail or 'admin@site.com'

  def event_new_user(user)
    recipients self.admin_email
    from self.sitename
    subject "На сайте зарегистрировался новый пользователь"
    content_type 'text/html'
    body :user => user
  end

  def event_hello(user,type)
    recipients user.email
    from self.sitename
    subject "Регистрация на сайте #{@site_name}"
    content_type 'text/html'
    body :user => user
    case type
    when 'type_auto'
      template 'event_hello_auto'
    else
      template 'event_hello_manual'
    end
  end

  def user_activated(user)
    recipients user.email
    from self.sitename
    subject "Регистрация на сайте #{@site_name}"
    content_type 'text/html'
    body  :header => Memo.get_memo('activate_mail_header'),
          :body => Memo.get_memo('activate_mail_body'),
          :footer => Memo.get_memo('activate_mail_footer')
  end

  def user_deactivated(user)
    recipients user.email
    from self.sitename
    subject "Регистрация на сайте #{@site_name}"
    content_type 'text/html'
    body  :header => Memo.get_memo('deactivate_mail_header'),
          :body => Memo.get_memo('deactivate_mail_body'),
          :footer => Memo.get_memo('deactivate_mail_footer')
  end
  

end
