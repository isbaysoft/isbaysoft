module Admin::UsergroupsHelper
  def usergroup_for_select
    Usergroup.all.collect {|p| [p.name, p.id]}
  end
end
