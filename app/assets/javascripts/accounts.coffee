# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
(->
  $ ->
    $('.ui.checkbox').click ->
      if($(this).hasClass('checked'))
        $('div#profile').addClass('hidden')
      else
        $('div#profile').removeClass('hidden')

    $('#user-settings .item').click (e)->
      $this = $(this)
      # remove a classe active de todos os itens do menu
      $('#user-settings .item').removeClass('active')
      # adiciona a classe active ao item clicado
      $this.addClass('active')

      tab = $this.attr('tab')
      # esconde todas as abas
      $("#tabs .absolute-container").transition('fade out', '0ms')
      # mostra apenas a aba selecionada
      $("##{tab}").transition('fade left')
)()
