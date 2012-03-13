class DialogsController < ApplicationController
  before_filter :require_user

  def show_dialog
#   Generate template dialog
    if params[:dialog_name]
      @template_dir = "/dialogs/forms/#{params[:dialog_name]}/show"
    else
      render :none
    end

    @dialogdata = dialog_category_data if params[:dialog_name].eql?('category')

    filelist if params[:dialog_name].eql?('filelist')
    static_content if params[:dialog_name].eql?('static_content')

    if params[:dialog_name].eql?('manager_logo')
      document = Document.where(:id => params[:id]).limit(1).first
      @dialogdata = {:feed => document.logos.all, :caption => t(:dialog_caption_logo), :logo_id => params[:logo_id].to_i}
    end

    respond_to do |format|
      format.html { redirect_to root_url}
      format.js
    end

  end

private

  def static_content
    @dialog_caption = t(:dialog_caption_static_content)
    @dialogdata = StaticContent.all
  end

  def filelist
    @dialog_caption = t(:dialog_file)
    if params[:except_document_files]
      ids = Document.get(params[:except_document_files]).first.filelists.map(&:id).to_a
    end
    @dialogdata = Filelist.except(ids).order('f_file_name')
  end

  def dialog_category_data
    dialogdata = {}
    dialogdata[:caption] = t(:dialog_category)
    dialogdata[:feed] = Section.order('name')
    return dialogdata
  end
  
end
