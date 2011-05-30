class StaticContentController < MainApplicationController
  def show
    @content = StaticContent.find_by_id(params[:id])
  rescue
    render_404
  end

end
