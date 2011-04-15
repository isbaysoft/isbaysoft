module Admin::SectionsHelper
  def sections_for_select
    Section.all.collect { |s| [s.name,s.id] }    
  end
end
