class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

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
      tag(:li, link(text, page, :class => classname), :class => classname + ' disabled')
    else
      tag(:li, text, :class => classname + ' disabled')
    end
  end


#   <div class="pagination">
#   <ul>
#     <li><a href="#">Prev</a></li>
#     <li class="active">
#       <a href="#">1</a>
#     </li>
#     <li><a href="#">2</a></li>
#     <li><a href="#">3</a></li>
#     <li><a href="#">4</a></li>
#     <li><a href="#">Next</a></li>
#   </ul>
# </div>


end