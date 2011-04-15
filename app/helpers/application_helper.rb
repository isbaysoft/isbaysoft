module ApplicationHelper

def show_model_table(collections, headers, options, &proc)
  table_property = ""
  table_property << " class=\"#{options[:class]}\"" if options[:class]
  table_property << " background=\"#{options[:background]}\"" if options[:background]
  table_property << " bgcolor=\"#{options[:bgcolor]}\"" if options[:bgcolor]
  table_property << " border=\"#{options[:border]}\"" if options[:border]
  table_property << " bordercolor=\"#{options[:bordercolor]}\"" if options[:bordercolor]
  table_property << " cellpadding=\"#{options[:cellpadding]}\"" if options[:cellpadding]
  table_property << " cellspacing=\"#{options[:cellspacing]}\"" if options[:cellspacing]
  table_property << " cols=\"#{options[:cols]}\"" if options[:cols]
  table_property << " height=\"#{options[:height]}\"" if options[:height]
  table_property << " id=\"#{options[:id]}\"" if options[:id]
  table_property << " width=\"#{options[:width]}\"" if options[:width]

  html = "<table#{table_property}>\n\t"
  html << "<thead>"
  html << content_tag(:th,options[:numeration]) if options[:numeration] # => numeration
  html << content_tag(:th,check_box("groups", 1, :onclick=>"setCheckBoxes(this,'#{options[:checkbox]}')")) if options[:checkbox] # => global checkbox
  headers.collect { |v| html << content_tag(:th, sortable(collections,v[1],v[0])) }
  html << "</thead>\n\t"
  html << "<tbody>"
  concat(html)
  cnt = 0
  collections.collect {|row| proc.call(row,cnt+=1) }
  html = "</tbody></table>"
  concat(html)
end

def sortable(collections,caption, column, title = nil)
  title ||= caption.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to_function title, "ColumnOrdering(tablepanel_form,'#{column}','#{direction}')", :class => css_class
end

def roundbox3(&block)
  block_content = %{
    <div id="csc"><!--the_box-->
     <span class="tr"></span><!--top_right-->
        #{capture(&block)}
     <span class="bl"></span><!--bottom_left-->
     <span class="br"></span><!--bottom_right-->
    </div><!--csc-->
  }
  concat(block_content)

end

def roundbox(bk_color_class,&block)
  block_content = %{<div class="roundedbox1">
    <b class="r3 #{bk_color_class}"></b><b class="r2 #{bk_color_class}"></b><b class="r1 #{bk_color_class}"></b>
    <div class="inner-box #{bk_color_class}">
        #{capture(&block)}
    </div>
    <b class="r1 #{bk_color_class}"></b><b class="r2 #{bk_color_class}"></b><b class="r3 #{bk_color_class}"></b>
  </div>}
  concat(block_content)
end

def roundbox2(&block)
  block_content = %{
    <div class="xw-tl">
    <div class="xw-tr">
    <div class="xw-tcc"></div></div></div>
    <div class="xw-ml">
    <div class="xw-mr">
    <div class="xw-mc topBlockM">#{capture(&block)}</div></div></div>
    <div class="xw-bl">
    <div class="xw-br">
    <div class="xw-bc">
    <div class="xw-footer"></div></div></div></div>}
  concat(block_content)
end

def header_caption(options)
    icon_class = "toolbar_caption"
    icon_class << " #{options[:icon_class]}" if options[:icon_class]
    html = content_tag(:div,content_tag(:h2,options[:caption]), :class => icon_class) if options[:caption]
    return html
end

def btn(options)
  options[:title] = options[:caption] unless options[:title].present?
  a = content_tag(:span,'',:title => options[:title], :class=>options[:icon_class])+options[:caption]
  html = ""
  html << content_tag(:div, link_to(a, options[:url], :method => (options[:method] or :get)) , :class => 'toolbar_button32') if options[:url]
  html << content_tag(:div, link_to(a,'#',:onclick => options[:onclick]), :class => 'toolbar_button32') if options[:onclick]
  html << content_tag(:div, submit_tag(options[:submit])) if options[:submit]
  return html
end

def link_to_home
  link_to 'Перейти на главную страницу сайта', home_url
end

def tr_cycle_wrong(row)
  row.wrong? ? "disable_bk" : cycle('odd','even')
end

def options_yesno_tag(value = false)
  options_for_select({ "Да" => true, "Нет" => false },value)
end

# Does not change the name - static_content_for
def static_content_for(content_position_name)
  render :partial => 'shared/main/content', :locals=>{:content_for => content_position_name}
end

# Renders tabs and their content
def render_tabs(tabs)
  if tabs.any?
    render :partial => 'shared/admin/tabs', :locals => {:tabs => tabs}
  else
    content_tag 'p', t(:text_no_data), :class => "nodata"
  end
end

# Renders tabs and their content
def render_vertical_tabs(tabs)
  if tabs.any?
    render :partial => 'shared/admin/tabsv', :locals => {:tabs => tabs}
  else
    content_tag 'p', t(:text_no_data), :class => "nodata"
  end
end



end