module Admin::MenusHelper
  def menus_for_select
    Menu.published.map { |m| [m.title, m.id] }
  end
end
