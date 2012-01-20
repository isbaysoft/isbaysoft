var dialog = {
  select: function(selected_values) {
    for (var key in selected_values) {
      $('#'+key).attr('value',selected_values[key])
    }
    this.hide();
  },
  hide: function() {
    $.colorbox.close()
  }
}