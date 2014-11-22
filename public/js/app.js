var hideAllRadios = function() {
  $('.info-buscar').hide();
  $('.info-levar').hide();
  $('.info-conduzir').hide();
};

var ready = function() {
  hideAllRadios();

  $('.remove_fields').click(function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.row').hide();
    event.preventDefault();
  });

  $('.buscar-option').click(function() {
    hideAllRadios();
    $('.info-buscar').show();
  });

  $('.levar-option').click(function() {
    hideAllRadios();
    $('.info-levar').show();
  });

  $('.conduzir-option').click(function() {
    hideAllRadios();
    $('.info-conduzir').show();
  });
};

$(document).ready(ready);
