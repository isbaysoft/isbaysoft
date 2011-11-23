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
			assigns(:user).valid?.should be_false

			# Check correct confirmation
			post :create, :user => {:password => '1', :password_confirmation => '2'}
			assigns(:user).should have_at_least(1).errors_on(:password)
			assigns(:user).valid?.should be_false
			response.should render_template('users/new')
		end

		it 'Register a new user' do
			post :create, :user => Factory.attributes_for(:user)
			assigns(:user).errors.count.should == 0
			assigns(:user).valid?.should be_true
			response.should redirect_to(login_url)
		end
	end

	describe 'User update (action :update)' do
		before(:each) do
			@current_user = Factory.build(:user, :access_level => 100)
			User.stub!(:current).and_return(@current_user)
		end

		it 'Should be error for update' do
			post :update, :user => Factory.attributes_for(:user, :email => 'itiswrongemail')
			assigns(:user).should have_at_least(1).errors_on(:email)
			flash[:notice].should_not be_nil
			response.should render_template('users/edit')
		end

		it 'Shouldn\'t be error for update' do
			post :update, :user => {:email => 'new_email@mail.com'}
			assigns(:current_user).should eq(@current_user)
			assigns(:user).email.should eq(@current_user.email)
			assigns(:user).valid?.should be_true
			flash[:notice].should_not be_nil
			response.should redirect_to(root_url)
		end

		after(:each) do
			@current_user = nil
		end
	end

	describe 'User activation (action :activate)' do
		before(:each) do
			@user = Factory.build(:user, :access_level => 100)
		end

		it 'Shouldn\'t be error for activation' do
			User.stub!(:find_by_id_and_persistence_token).and_return(@user)
			get :activate, :id => 100, :activation_code => '100'
			assigns(:user).access.should be_true
			flash[:notice].should_not be_nil
			response.should redirect_to(login_url)
		end

		it 'Should be error for activation' do
			get :activate, :id => 100, :activation_code => '100'
			assigns(:user).should be_nil
			flash[:notice].should_not be_nil
			response.should redirect_to(root_url)
		end

		after(:each) do
			@user = nil
		end
	end

end