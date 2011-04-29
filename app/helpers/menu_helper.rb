module MenuHelper
  def main_menu
    [
      ['ГЛАВНАЯ',home_url,'kwick1'],
      ['ПРОДУКТЫ',show_products_url,'kwick2'],
      ['ЗАГРУЗКИ',show_products_url,'kwick3'],
      ['ПОДДЕРЖКА',show_products_url,'kwick4'],
      ['ФОРУМ',show_products_url,'kwick5']
    ]
  end
    
end
