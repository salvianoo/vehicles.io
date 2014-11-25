var hideAllRadios = function() {
  $('.info-buscar').hide();
  $('.info-levar').hide();
  $('.info-conduzir').hide();
};

var hideAndShowOptions = function() {

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

var dateTimeMask = function() {
  $("#date").mask("99/99/9999");
  $("#hour").mask("99:99");
};

var enableDadosVoo = function() {
  $("#sim_buscar").click(function () {
    $("#cia_area").removeAttr("disabled");
    $("#num_voo").removeAttr("disabled");
  });
};

var disableDadosVoo = function() {
  $("#nao_buscar").click(function () {
    $("#cia_area").attr('disabled', true);
    $("#num_voo").attr('disabled', true);
  });
}

var ready = function() {
  hideAllRadios();

  $('.remove_fields').click(function( event ) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.row').hide();
    event.preventDefault();
  });

  hideAndShowOptions();
  dateTimeMask();
  enableDadosVoo();
  disableDadosVoo();
};

$(document).ready(ready);
