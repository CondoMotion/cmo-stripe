# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".delete_post").bind "ajax:success", ->
    $(this).closest(".document_post").fadeOut()

  $(".permissions-toggle").on "click", ->
    $(this).toggleClass("active")