module Admin::MenuItemsHelper

	def target_types_names
		{0 => I18n.t(:text_target_self),1 => I18n.t(:text_target_blank)}
	end

  def targets_for_select(value)
    options_for_select(target_types_names.invert,value)
  end

  def target_name(target)
  	target_types_names[target]
  end
end