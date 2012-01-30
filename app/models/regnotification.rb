# coding: utf-8
class Regnotification < ActionMailer::Base
  cattr_accessor :sitename, :admin_email

  self.sitename = Admin::ConfigHelper.sitename or 'site.com'
  self.admin_email = Admin::ConfigHelper.adminemail or 'admin@site.com'

  default :from => self.sitename, :content_type => 'text/html'

  def event_new_user(user)
    @user = user
    mail(:to => self.admin_email, :subject => "На сайте зарегистрировался новый пользователь")
  end

  def event_hello(user,type)
    @user = user
    case type
    when 'type_auto'
      mail(:template_name => 'event_hello_auto')
      template 'event_hello_auto'
    else
      mail(:template_name => 'event_hello_manual')
    end
    mail(:to => user.email, :subject => "Регистрация на сайте #{@site_name}")
  end

  def user_activated(user)
    @header = Memo.get_memo('activate_mail_header')
    @body = Memo.get_memo('activate_mail_body')
    @footer = Memo.get_memo('activate_mail_footer')
    mail(:to => user.email, :subject => "Регистрация на сайте #{@site_name}")
  end

  def user_deactivated(user)
    @header = Memo.get_memo('deactivate_mail_header')
    @body = Memo.get_memo('deactivate_mail_body')
    @footer = Memo.get_memo('deactivate_mail_footer')
    mail(:to => user.email, :subject => "Регистрация на сайте #{@site_name}")
  end
  

end
