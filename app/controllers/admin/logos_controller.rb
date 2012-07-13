class Admin::LogosController < AdminApplicationController

	respond_to :json

	def create
		#  Looking up the document or render nil
		@document = Document.find_by_id(params[:document_id])
		render :nothing => true and return unless @document

		#  Delete old logos if exist
		@document.logo.destroy if @document.logo

		#  Build a new logo
		logo = @document.build_logo params[:document]

		respond_with(logo) do |format|
			format.json do 
				if @document.save
					render :json => {:url => logo.logo.url.to_json, :id => logo.id}
				else
					render :update do |page|
						page.call 'alert', logo.errors.full_messages.join(', ')
					end
				end
			end
			format.any {render :nothing => true}
		end		
	end
 
end
