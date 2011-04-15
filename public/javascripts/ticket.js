function hidetabs()
{
    var a = $$('div#ticket_tabs .ticket_box_in');
    for (i=0; i<a.length; i++)
    {
      a[i].setStyle({display: 'none'});
    }
}
function showtab(obj,id_tab)
{
    hidetabs();
    $(id_tab).setStyle({display: 'block'});
    crumbs(obj);
}
function showticket(ticket_body)
{
    var a = $$('.ticket_body');
    for (i=0; i<a.length; i++)
    {
        if ($(a[i]).style.display !== 'none')
            Effect.BlindUp(a[i], { duration: 0.2 });
    }

//    if ($(ticket_body).style.display === 'none')
//      Effect.BlindDown(ticket_body, { duration: 0.2 });
//    else
      Effect.BlindDown(ticket_body, { duration: 0.2 });
}

function crumbs(obj)
{
    $('crumbs').innerHTML = $(obj).innerHTML;
}

function ttt(txt)
{
    alert(txt);
}