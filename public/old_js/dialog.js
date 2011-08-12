var dialog = {
  hide: function() {
    new Effect.DropOut('dialog', {duration: 0.3});
    new Effect.Fade('overlay', {duration: 0.3});
    document.body.setStyle({overflow : 'visible'});
  },
  show: function() {
    document.body.setStyle({overflow : 'hidden'});
    new Effect.Appear('overlay', {duration: 0.2});
    new Effect.Appear('dialog', {duration: 0.2});
  },
  select: function(selected_values) {
    for (var key in selected_values) {
        if ($(key))
            $(key).value = selected_values[key];
        
    }
    this.hide();
  }
}