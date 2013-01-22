$(document).delegate('.ui-navbar ul li > a', 'click', function() {
  //search the navbar to deactivate the active button
  $(this).closest('.ui-navbar').find('a').removeClass('ui-btn-active');

  //change the active tab
  $(this).addClass('ui-btn-active');

  //hide the siblings
  $('div:jqmData(id="' + $(this).data('href') + '")').show().siblings('.tab-content').hide();

  $('div:jqmData(id="' + $(this).data('href') + '")').trigger('init-tab');

  return false;
});