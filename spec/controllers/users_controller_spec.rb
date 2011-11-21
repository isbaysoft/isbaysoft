describe UsersController do
	describe 'User registration (action :new)' do
		it 'Should be route - /registration' do
			{ :get => "/registration" }.should route_to(
		      :controller => "users",
		      :action => "new"
			)
		end

		it 'Assigns new @user' do
			user = User.new
			get :new
			assigns(:user).should be_a_new(User)
		end

		it 'Render the registration template' do
			get :new
			response.should render_template('new')
		end
	end

	describe 'User create (action :create)' do
		it 'Should be return error for empty user' do
			post :create
			assigns(:user).errors.should have_at_least(1).items
		end

		it 'Should be error for incorect email' do
			post :create
			assigns(:user).should have_at_least(1).errors_on(:email)
			response.should render_template('users/new')
		end

		it 'Should be error for incorect password' do
			# Check password lenght
			post :create, :user => {:password => '1', :password_confirmation => '1'}
			assigns(:user).should have_at_least(1).errors_on(:password)

			# Check correct confirmation
			post :create, :user => {:password => '1', :password_confirmation => '2'}
			assigns(:user).should have_at_least(1).errors_on(:password)
			response.should render_template('users/new')
		end

		it 'Register a new user' do
			post :create, :user => {:email => 'test@mail.com', :password => '1234567', :password_confirmation => '1234567'}
			assigns(:user).errors.count.should == 0
			response.should redirect_to(login_url)
		end
	end

	describe 'User update (action :update)' do
		it 'User should be invalid' do
			post :update, :user => {:email => 'mail.com', :password => '123', :password_confirmation => '123' }
			assigns(:user).should have_at_least(1).errors_on(:email)
		end

		it 'Update valid User' do
			# user = User.new({:email => 'test2@mail.com', :password => '123456', :password_confirmation => '123456' })
			# post :update, :user => {:email => 'test22@super.com', :password => '123456', :password_confirmation => '123456' }
			# assigns(:user).errors.full_messages.should == ''
			# assigns(:user).should have(:no).errors_on(:password)
		end
	end
end