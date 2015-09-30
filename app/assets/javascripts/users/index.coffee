# users.index
ready = ->
  # $('select[name=profile]').dropdown({
  #     onChange: (text, value, $selectedItem) ->
  #       alert 'teste'
  #   })
  $('select[name=profile]').dropdown()
  $('select[name=profile]').on 'change', (event) ->
    item = $(event.target)
    item.parent().addClass('loading')
    $.post('/users/' + item.attr('data-user-id') + '/change-profile', { profile: item.val() }, (response)->
      console.log response
    ).always ->
      item.parent().removeClass('loading')

$(document).ready ready
$(document).on 'page:load', ready
