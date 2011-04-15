module Admin::StaticContentsHelper
  def ss
     StaticContent.static_content_position_names.map { |s| [s,s] }
  end
end
