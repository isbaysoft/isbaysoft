module Admin::DocumentsHelper
  def document_count
    Document.count
  end
end
