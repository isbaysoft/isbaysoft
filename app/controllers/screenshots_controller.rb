class ScreenshotsController < MainApplicationController

  def index
    @document = Document.get(params[:product_id]).published.approved.first

#    http://www.smsdostup.ru/billing-tarifs.xml?pid=7248&md5=032856d98e9fdcffea2c813dc396ebb4



  end

end
