registerReady = ->
  $("#avatar_button").click (e) ->
    if $(e.target).is('input[type="file"]') then return else
      $(this).find('input[type="file"]').click()

  $("#person_avatar").change ->
    previewImage this

previewImage = (input) ->
  if input.files && input.files[0]
    reader = new FileReader()
    image = $("#preview_image img")
    image.hide()
    reader.onload = (e) ->
      image.attr 'src', e.target.result
      image.load ->
        image.fadeIn('slow')
    reader.readAsDataURL input.files[0]

$(document).ready registerReady
