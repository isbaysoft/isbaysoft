module Admin::MenuItemsHelper
  def targets_for_select(value)
    options_for_select(MenuItem::TARGET_TYPES_NAMES.invert ,value)
  end
end
