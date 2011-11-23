describe UserSessionsController do
	it 'action :new' do
		get :new
		assigns(:user_session).should_not be_nil
		assigns(:user_session).new_record?.should be_true
	end

	it 'action :create' do
		activate_authlogic
		UserSession.create Factory.build(:user)


		# post :create, :user_session => {:login => "andrew@mail.com", :password => "111111",  :remember_me => 0}
		# assigns(:user_session).errors.full_messages.should == '1'		

		# assigns(:user_session).should_not be_nil
		# assigns(:user_session).errors.should have(:no).items
	end
end