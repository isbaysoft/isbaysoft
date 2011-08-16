class DialogsController < ApplicationController
  before_filter :require_user

  def show_dialog
#   Generate template dialog
    if params[:dialog_name]
      @template_dir = "/dialogs/forms/#{params[:dialog_name]}/show"
    else
      render :none
    end

    category if params[:dialog_name].eql?('category')

    if params[:dialog_name].eql?('fetch_category')
      @categories = Category.getlist.section(params[:id]).order('name')
      @inline_object = 'dialog_category_list'
      @template_dir = 'dialogs/forms/category/categories'
    end

    filelist if params[:dialog_name].eql?('filelist')
    static_content if params[:dialog_name].eql?('static_content')

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

  def category
    @dialog_caption = t(:dialog_category)
    @dialogdata = Section.order('name')
  end
  
end
