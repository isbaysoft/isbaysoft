# coding: utf-8
module ApplicationHelper


  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h2>There was a problem creating the #{object.class.name.humanize.downcase}</h2>\n"
        else
          html << "\t\t<h2>There was a problem updating the #{object.class.name.humanize.downcase}</h2>\n"
        end
      else
        html << "<h5>#{message}</h5>"
      end
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html.html_safe
  end

def nodata
  "<p class='nodata'>#{t(:global_no_data)}</p>".html_safe
end

def sortable(caption, column, title = nil)
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
 %{ <div class="xw-tl">
    <div class="xw-tr">
    <div class="xw-tcc"></div></div></div>
    <div class="xw-ml">
    <div class="xw-mr">
    <div class="xw-mc topBlockM">#{capture(&block)}</div></div></div>
    <div class="xw-bl">
    <div class="xw-br">
    <div class="xw-bc">
    <div class="xw-footer"></div></div></div></div>}.html_safe
end

def header_caption(options)
    icon_class = "toolbar_caption"
    icon_class << " #{options[:icon_class]}" if options[:icon_class]
    html = content_tag(:div,content_tag(:h2,options[:caption]), :class => icon_class) if options[:caption]
    return html
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
def render_tabs(*args)
  options = args.extract_options!
  if options.has_key?(:tabs)
    render :partial => 'shared/admin/tabs', :locals => {:tabs => options[:tabs], :form_object => options[:form_object]  }
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

  def btn(options)
    options[:title] = options[:caption] unless options[:title].present?
    a = content_tag(:span,'',:title => options[:title], :class=>options[:icon_class])+options[:caption]
    html = ""
    html << content_tag(:div, link_to(a, options[:url], :method => (options[:method] || :get)) , :class => 'toolbar_button32') if options[:url]
    html << content_tag(:div, link_to(a,'#',:onclick => options[:onclick]), :class => 'toolbar_button32') if options[:onclick]
    html << content_tag(:div, submit_tag(options[:submit])) if options[:submit]
    html.html_safe
  end

end
