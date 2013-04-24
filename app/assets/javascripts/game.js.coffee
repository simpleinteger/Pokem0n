$(document).ready ->

  $("#toggle_answer").ready ->
    $("#toggle_answer").css("display", "none")

  $("#toggle_button").click ->
    $("#toggle_answer").toggle()
