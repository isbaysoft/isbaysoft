module Admin::AdministratorHelper
  def link_to_allow(link_name,link_url,conditions)
    if conditions
      link_to link_name, link_url
    else
      content_tag :a, link_name, :class => 'disable'
    end
  end
end
