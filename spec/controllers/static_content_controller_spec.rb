describe StaticContentController do
	it 'Show content (action :show)' do
		content = StaticContent.create({:name => 'this is name', :content => 'this is content'})
		get :show, :id => content.id
		assigns(:content).should eq(content)
		response.should render_template('show')
	end
end