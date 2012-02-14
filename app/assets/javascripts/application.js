jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $(".remote").submitWithAjax();
  $(".popup").colorbox({innerWidth:640, innerHeight:480, initialWidth:640, initialHeight:480, onLoad: function() {
      $('#cboxClose').remove();
    }});
})


//=require tinymce

function showtab(tab_group,tab_selected)
{
    $('.'+tab_group+'-content').each(function() {
        $(this).hide();
    })
    $('div.'+tab_group+' a').each(function() {
        $(this).removeClass('selected');
    })
    $('#'+tab_group+'-' + tab_selected).addClass('selected');
    $('#'+tab_group+'-content-' + tab_selected).show();
}

// TODO:  prototype -> jQuery

function ColumnOrdering(form, order, direction)
{
    form.sort.value = order;
    form.direction.value = direction;
    form.submit();
}

function setCheckBoxes(obj,check_boxes_name)
{
    $("input:checkbox[name='"+check_boxes_name+"']").attr("checked",obj.checked);
}

function CheckedCheckBoxes(check_boxes_name)
{
    var check = document.getElementsByName(check_boxes_name);
    for (var i=0; i<check.length; i++)
        check[i].checked = true;

}

function submitaction(actionname)
{
      document.adminForm.action = actionname;
      document.adminForm._method.value = 'POST';
      submitbutton();
}

function submitbutton(pressbutton) {
    submitform(pressbutton);
}

function submitform(pressbutton) {
  if (pressbutton) {
    document.adminForm.task.value=pressbutton;
  }
  if (typeof document.adminForm.onsubmit == "function") {
    document.adminForm.onsubmit();
  }
   document.adminForm.submit();
}

function ShowLoading() {
    Element.show("loading")
};

function HideLoading() {
    Element.hide("loading")
};

//Ajax.Responders.register({onCreate: ShowLoading, onComplete: HideLoading});
