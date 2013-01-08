$(document).delegate('.ui-navbar ul li > a', 'click', function() {
  //un-highlight and highlight only the buttons in the same navbar widget
  $(this).closest('.ui-navbar').find('a').removeClass('ui-btn-active');

  //this bit is the same, you could chain it off of the last call by using two `.end()`s
  $(this).addClass('ui-btn-active');

  //this starts the same but then only selects the sibling `.tab_content` elements to hide rather than all in the DOM
  $('#' + $(this).attr('data-href')).show().siblings('.tab-content').hide();

  return false;
});