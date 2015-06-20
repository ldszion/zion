# users.show
ready = ->
  $('#user-profile-header .dimmable.image').dimmer({
    on: 'hover'
  })

$(document).ready ready
$(document).on 'page:load', ready