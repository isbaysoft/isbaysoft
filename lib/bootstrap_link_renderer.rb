class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer

protected
    
  def page_number(page)
    unless page == current_page
      tag(:li, link(page, page, :rel => rel_value(page)))
    else
      tag(:li, link(page, '#'), :class => 'active')
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page, :class => classname), :class => classname)
    else
      tag(:li, link(text, '#'), :class => classname + ' disabled')
    end
  end

end