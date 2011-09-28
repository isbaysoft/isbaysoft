var Flash = {
  error: function(message) {
    $('flash_errors').innerHTML = '';
    $('flash_errors').innerHTML = "<li>" + message + "</li>";
    new Effect.Appear('flash_errors', {duration: 0.3});
    setTimeout(Flash.fadeError.bind(this), 5000);
  },

  notice: function(message) {
    $('flash_notice').innerHTML = '';
    $('flash_notice').innerHTML = "<li>" + message + "</li>";
    new Effect.Appear('flash_notice', {duration: 0.3});
    setTimeout(Flash.fadeNotice.bind(this), 5000);
  },

  fadeNotice: function() {
    new Effect.Fade('flash_notice', {duration: 0.3});
  },

  fadeError: function() {
    new Effect.Fade('flash_errors', {duration: 0.3});
  }
}