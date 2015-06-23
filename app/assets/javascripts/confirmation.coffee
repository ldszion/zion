# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# confirmation.coffee
ready = ->
  $('.dimmable.image').dimmer({
    on: 'hover'
  })
  $('.icon.button[data-content]').popup({
    variation: "inverted",
    delay: {
      show: 800,
      hide: 0
    }
  })

$(document).ready ready
$(document).on 'page:load', ready