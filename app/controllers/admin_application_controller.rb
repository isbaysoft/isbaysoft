# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class AdminApplicationController < ApplicationController
  uses_tiny_mce
  layout "admin"
  before_filter :require_user
  before_filter :load_configs
  helper :all # include all helpers, all the time
  helper_method :sort_column, :sort_direction, :caption_at_action, :controller_caption
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :prepare_index, :only => [:index]
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

 protected

  def load_configs
    # Checking parameters
    notdef = I18n.t(:global_errors_not_definitely)
    $sitename = Cfg.getvalue('sitename')
    @cfg_errors = Array.new
    @cfg_errors << ["#{notdef}: #{I18n.t(:global_errors_sitename)}"] unless Cfg.getvalue('sitename')
    @cfg_errors << ["#{notdef}: #{I18n.t(:global_errors_adminemail)}"] unless Cfg.getvalue('adminemail')
    @cfg_errors << ["#{notdef}: #{I18n.t(:global_errors_domain)}"] unless Cfg.getvalue('domain')

#    other settings
    @text_area_default_size_for_description = {:cols => 80, :rows => 12}
    @text_area_default_size_for_description_big = {:cols => 120, :rows => 20}
  end

  def prepare_index
#    TODO Refactoring
    @sort_column = sort_column
    @sort_direction = sort_direction
    @order = "#{@sort_column} #{@sort_direction}" if @sort_column
  end

  def require_moderator
    redirect_to_and_notice administrator_url, I18n.t(:global_access_denied) unless current_user.allow('Moderator')
  end

  def require_admin
    redirect_to_and_notice administrator_url, I18n.t(:global_access_denied) unless current_user.allow('Administrator')
  end

private

  def current_session_ids
    "#{self.controller_name}_ids"    
  end

  def confirm_request?
    "true" if request.delete? && params['confirm'].present? && params['confirm']['confirmed'].eql?('1')
  end

  def confirm_operation &proc
    if confirm_request?
      proc.call if proc
    else
      render :template => "shared/admin/destroy"
    end
  end

  def confirm_multiple_operations ids, &proc
    if confirm_request?
      proc.call if proc
      session[current_session_ids] = nil
    else
      session[current_session_ids] = ids unless session[current_session_ids].present?
      render :template => "shared/admin/destroy"
    end
  end

  def page_options
    cookies["per_page_#{self.controller_name}"] = params[:per_page] if params[:per_page]
    per_page = params[:per_page] || cookies["per_page_#{self.controller_name}"]
    {:order => @order,
     :sort_column => @sort_column,
     :filter => params[:filter],
     :page => params[:page],
     :per_page => per_page
    }
  end

  def caption_at_action
    case self.action_name.downcase
    when 'new','create' then I18n.t(:global_action_add)
    when 'edit','update' then I18n.t(:global_action_edit)
    when 'show' then I18n.t(:global_action_show)
    else I18n.t(:global_action_not_definitely)
    end
  end

  def controller_caption
    @controlleralias  or "(#{I18n.t(:global_controller_alias_not_definitely)})"
  end

  def update_attributes_and_redirect(update_object,
      update_hash,
      update_redirect = url_for(:action => 'index'), &proc)
    if update_object.update_attributes(update_hash)
      proc.call(update_object) if proc
      flash[:notice] = I18n.t(:global_updating)
      if params[:task].present? and params[:task] == 'post'
        render :action => 'edit'
      else
        flash[:edited] = params[:id]
        redirect_to update_redirect
      end
    else
      render :action => 'edit'
    end    
  end

  def sort_column
    if params[:sort]
      cookies["sort_column_#{self.controller_name}"] = params[:sort]
      column = params[:sort]
    else
      column = cookies["sort_column_#{self.controller_name}"] || nil
    end
    column = nil unless column.present?
    column
  end

  def sort_direction    
    if params[:direction]
      direction = %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      cookies["sort_column_direction_#{self.controller_name}"] = direction
    else
      direction = cookies["sort_column_direction_#{self.controller_name}"] || "asc"
    end
    direction
  end

  def render_404
    render 'errors/404', :status => "404" and return
  end

end
