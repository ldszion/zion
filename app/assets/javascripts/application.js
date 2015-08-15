// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require plugins/jquery.mask
//= require semantic-ui
//= require_tree .

$(document).ready(function() {
  $('div.dropdown').dropdown();
  $('.ui.checkbox').checkbox();
  $('select.dropdown').dropdown();

  // INPUT MASK FOR PHONE NUMBERS
  var maskBehavior = function (val) {
    return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
  };
  options = {
    onKeyPress: function(val, e, field, options) {
      field.mask(maskBehavior.apply({}, arguments), options);
    }
  };
  $('input.phone').mask(maskBehavior, options);
  $('input.datemask').mask('00/00/0000');
  $('input.timemask').mask('00:00');
  $('input.moneymask').on('keydown change', function(e){
    $(this).mask('000.000.000,00', { reverse: true });
  });
  // END INPUT MASK

  $('.ui.message .close.icon')
    .on('click', function(){
      $(this).closest('.message').transition('fade', function(){
        $(this).remove();
      });
    });
});
