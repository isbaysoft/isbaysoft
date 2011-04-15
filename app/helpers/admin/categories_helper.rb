module Admin::CategoriesHelper
  def getcategories(section_id)
    Category.find(:all,:conditions => ['section_id=?',section_id])
  end
end
