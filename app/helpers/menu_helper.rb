module MenuHelper
  def main_menu
    [
      ['ГЛАВНАЯ',home_url,'kwick1'],
      ['ПРОДУКТЫ',show_categories_url,'kwick2'],
      ['ЗАГРУЗКИ','#','kwick3'],
      ['ПОДДЕРЖКА','#','kwick4'],
      ['ФОРУМ','#','kwick5']
    ]
  end
    
end
