# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#signup_password").focus ->
    $("#signup_password_help").slideDown("fast")

  $("#signup_password").blur ->
    $("#signup_password_help").slideUp("fast")