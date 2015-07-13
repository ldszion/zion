registerReady = ->
  $("#preview_image").click (e) ->
    e.preventDefault()
    if $(e.target).is('.target_file') then return else
      $('.target_file').click()

  $(".target_file").change ->
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
