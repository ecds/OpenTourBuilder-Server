/*
    This javascript acts on jQuery mobiles nav bars to create a standard tab-like control.
    This approach was taken to prevent having multiple pages in the document that have duplicate
    header and footer control. This was necessary because jQuery mobile doesn't provide any
    sort of global header or footer.
*/

$(document).delegate('.tabs .ui-navbar ul li > a', 'click', function() {
  //search the navbar to deactivate the active button
  $(this).closest('.ui-navbar').find('a').removeClass('ui-btn-active');

  //change the active tab
  $(this).addClass('ui-btn-active');

  // hide the sibling tab-content containers
  $('div:jqmData(id="' + $(this).data('href') + '")').show().siblings('.tab-content').hide();

  // custom event trigger in case there are any actions that need to be taken after 
  // a tab is shown
  $('div:jqmData(id="' + $(this).data('href') + '")').trigger('init-tab');
  if($(this).hasClass('ui-btn-active')){
     $('html,body').scrollTop(0);
  }
  return false;
});
