$(document).on 'page:load ready', ->
  $("tr[data-link]").css cursor: "pointer"
  $("tr[data-link]").click ->
    window.location = $(this).data("link")

jQuery ->
  $('#fecha_min').datepicker()
  $('#fecha_max').datepicker()

jQuery ->
    $("#clean").click ->
      $(".form-control").val ""
