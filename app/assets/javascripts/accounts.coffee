# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.ui.checkbox').click ->
    if($(this).hasClass('checked'))
      $('div#profile').addClass('hidden')
    else
      $('div#profile').removeClass('hidden')