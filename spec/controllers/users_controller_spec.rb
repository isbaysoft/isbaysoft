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
		it 'Register a new user' do
			user = User.new
			user
			post :create
			assigns(:user).should be_a_new(User)
			response.should redirect_to(root_url)
		end
	end
end