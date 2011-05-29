// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function ColumnOrdering(form, order, direction)
{
    form.sort.value = order;
    form.direction.value = direction;
    form.submit();
}

function setCheckBoxes(obj,check_boxes_name)
{
    var check = document.getElementsByName(check_boxes_name);
    for (var i=0; i<check.length; i++)
        check[i].checked = obj.checked;
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

function submitbutton(pressbutton)
{
    submitform(pressbutton);
}

function submitform(pressbutton)
{
 if (pressbutton)
 {
  document.adminForm.task.value=pressbutton;
 }
 if (typeof document.adminForm.onsubmit == "function")
 {
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

Ajax.Responders.register({onCreate: ShowLoading, onComplete: HideLoading});

function displayTabsButtons() {
    var lis;
    var tabsWidth = 0;
    var i;
    $$('div.tabs').each(function(el) {
        lis = el.down('ul').childElements();
        for (i=0; i<lis.length; i++) {
            if (lis[i].visible()) {
                tabsWidth += lis[i].getWidth() + 6;
            }
        }
        if ((tabsWidth < el.getWidth() - 60) && (lis[0].visible())) {
            el.down('div.tabs-buttons').hide();
        } else {
            el.down('div.tabs-buttons').show();
        }
    });
}

function moveTabRight(el) {
    var lis = Element.up(el, 'div.tabs').down('ul').childElements();
    var tabsWidth = 0;
    var i;
    for (i=0; i<lis.length; i++) {
        if (lis[i].visible()) {
            tabsWidth += lis[i].getWidth() + 6;
        }
    }
    if (tabsWidth < Element.up(el, 'div.tabs').getWidth() - 60) {
        return;
    }
    i=0;
    while (i<lis.length && !lis[i].visible()) {
        i++;
    }
    lis[i].hide();
}

function moveTabLeft(el) {
    var lis = Element.up(el, 'div.tabs').down('ul').childElements();
    var i = 0;
    while (i<lis.length && !lis[i].visible()) {
        i++;
    }
    if (i>0) {
        lis[i-1].show();
    }
}

function showTab(name) {
    var f = $$('div#content .tab-content');
    for(var i=0; i<f.length; i++){
        Element.hide(f[i]);
    }
    var f = $$('div.tabs a');
    for(var i=0; i<f.length; i++){
        Element.removeClassName(f[i], "selected");
    }
    Element.show('tab-content-' + name);
    Element.addClassName('tab-' + name, "selected");
    return false;
}


function showTabV(name) {
    var f = $$('div#content .tabv-content');
    for(var i=0; i<f.length; i++){
        Element.hide(f[i]);
    }
    var f = $$('div.tabsv a');
    for(var i=0; i<f.length; i++){
        Element.removeClassName(f[i], "selected");
    }
    Element.show('tabv-content-' + name);
    Element.addClassName('tabv-' + name, "selected");
    return false;
}
