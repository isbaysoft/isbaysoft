module CatalogHelper
 
  def documentinfo(document)
    %{<table>
      <tr><th>Имя файла</th>
          <td>#{h(document.filelist.f_file_name)}</td>
      </tr>
      <tr><th>Тип файла</th>
          <td>#{h(document.filelist.f_content_type)}</td>
      </tr>
      <tr><th>Имя файла</th>
          <td>#{h(document.filelist.f_file_name)}</td>
      </tr>
      <tr><th>Размер файла</th>
          <td>#{h(number_to_human_size(document.filelist.f_file_size))}</td>
      </tr>
      <tr><th>Файла загружен</th>
          <td>#{h(document.filelist.f_updated_at.to_formatted_s(:long))}</td>
      </tr>
      <tr><th>Количество загрузок</th>
          <td>#{h(document.hits.to_i)}</td>
      </tr>
    </table>}
  end

end
