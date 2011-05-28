module Admin::RuleHelper
  def rules_for_select
    Rule.for_current_user(current_user.access_level).collect { |s| [s.name,s.access_level] }
  end
  
end
