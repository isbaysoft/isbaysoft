module Admin::RuleHelper
  def rules_for_select
    Rule.for_current_user(current_user.rule_id).collect { |s| [s.name,s.access_level] }
  end
  
end
