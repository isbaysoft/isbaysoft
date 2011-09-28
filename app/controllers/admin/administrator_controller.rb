class Admin::AdministratorController < AdminApplicationController

  def index
    # url = 'http://www.smsdostup.ru/billing-tarifs.xml?pid=4905&md5=032856d98e9fdcffea2c813dc396ebb4'
    # xml = Net::HTTP.get_response(URI.parse(url)).body
    # doc = REXML::Document.new(xml)
    # @names = REXML::XPath.match( doc, "/tarifs/item/number")

    @documents_count = Document.count
    @files_count = Filelist.count
    @sum_files_size = Filelist.sum('f_file_size')
    @published_docuemnt_count = Document.published.count
    @approved_document_count = Document.approved.count
    @users_cout = User.count

    @popular_documents = Document.popular 10
    @last_documents = Document.all(:limit => 10, :order => 'id desc')
    @last_files = Filelist.all(:limit => 10, :order => 'id desc')

#    attention
    @files_without_document_count = Filelist.files_without_document.count
    @show_attention = @files_without_document_count != 0
  end

  def raw
#     for drag-drop upload.
#     in fufure
    name = "tmp_image.png"
    data = request.raw_post
    r = request.headers
    @file_content = File.open("#{Rails.root.to_s}/tmp/#{name}", "wb") do |f|
      f.write(data)
    end
    @file_content = File.open("#{Rails.root.to_s}/tmp/__#{name}", "wb") do |f|
      f.write(r)
    end

    file = Filelist.new(:f => File.new("#{Rails.root.to_s}/tmp/#{name}"))
    file.save
    File.unlink("#{Rails.root.to_s}/tmp/#{name}")
    File.unlink("#{Rails.root.to_s}/tmp/__#{name}")
    render :text => 'success'
  end

end
