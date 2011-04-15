class MainApplicationController < ApplicationController
  layout "main"
  helper_method :active_link, :document_section_current, :document_category_current

  before_filter :top_downloads
  before_filter :load_sections

  def p404
    render 'errors/404', :status => '404'
  end

  protected

  def load_sections
    @sections = Section.find(:all)
  end

  def top_downloads
    @topdownloads = Document.popular 10
  end

  private

  def document_section_current
    case
      when params[:section_id].present? then params[:section_id]
      when @document then @document.category.section_id
      else 0
    end
  end

  def document_category_current
    case
      when params[:category_id].present? then params[:category_id]
      when @document then @document.category.id
      else 0
    end
  end

  def active_link(condition)
    condition ? 'n bold' : 'n'
  end
  
  def sort_column(def_column = 'name')
    col = params[:sort] if params[:sort].present?
    return col || def_column
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  
end
