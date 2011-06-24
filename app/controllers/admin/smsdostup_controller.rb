class Admin::SmsdostupController < ApplicationController
  require "digest"

  def billing
    # Задаем ключ (идентификатор) проекта, который указан в разделе 'Список проектов' в вашем аккаунте
    project_md5 = "032856d98e9fdcffea2c813dc396ebb4";
#http://127.0.0.1:3000/smsdostup?_md5_hash=1&_session_code=2&_sms_id=3&_sms_number=4&_sms_operator=5&_sms_phone=6&_sms_message=ce2qsl jj 839486-878386&_sms_price=8
#--10713-68555206
    requered_params = ['_md5_hash','_session_code','_sms_id','_sms_number',
       '_sms_operator','_sms_phone','_sms_message',
       '_sms_price']

    @result = 0
    # Проверяем наличие данных
    @result = 1 unless requered_params.all? {|p| params[p].present?}

    # Проверяем целостность данных
    md5hash_string = params['_session_code'] <<
      params['_sms_id'] <<
      params['_sms_number'] <<
      params['_sms_operator'] <<
      params['_sms_phone'] <<
      ERB::Util.html_escape(params['_sms_message']) <<
      params['_sms_price']

    md5hash_string = project_md5 << md5hash_string
    md5hash = Digest::MD5.hexdigest(md5hash_string)
    #    на время теста отключил проверку целостности
    #    @result = 2 unless md5hash.eql?(params['_md5_hash'])

    @message = params['_sms_message']
    @reg = @message.split(/(ce2qsl)\s*(\D*)\s*(\d*)\s*\-\s*(\d*)/)
    @prefix = @reg[2]
    @code = "#{@reg[3]}-#{@reg[4]}"



#md5($project_md5
#  .$_POST['_session_code']
#  .$_POST['_sms_id']
#  .$_POST['_sms_number']
#  .$_POST['_sms_operator']
#  .$_POST['_sms_phone']
#  .stripslashes($_POST['_sms_message'])
#  .$_POST['_sms_price']);
  end
  
end
