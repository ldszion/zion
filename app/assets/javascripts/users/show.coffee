# users.show
ready = ->
  $('#user-profile .segment .dimmable.image').dimmer({
    on: 'hover'
  })

$(document).ready ready
$(document).on 'page:load', ready