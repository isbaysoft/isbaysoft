# coding: utf-8
class UserSession < Authlogic::Session::Base
  validate :check_access_user
  find_by_login_method :find_by_email

  private

  def check_access_user
     errors.add(:login, "Ваш аккаунт еще не подтвержден") if attempted_record and not attempted_record.access
  end
end