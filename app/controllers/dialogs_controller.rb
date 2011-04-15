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
    fetch_category if params[:dialog_name].eql?('fetch_category')

    filelist if params[:dialog_name].eql?('filelist')
  end

private

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

  def fetch_category
      @categories = Category.getlist.section(params[:id]).order('name')
      render :template => 'dialogs/forms/category/categories' and return
  end
  
end
