$(document).on "page:load ready", ->
  $('#fecha_min').datepicker({ dateFormat: 'dd/mm/yy' })
  $('#fecha_max').datepicker({ dateFormat: 'dd/mm/yy' })

$(document).on "page:load ready", ->
    $("#clean").click ->
      $(".form-control").val ""
