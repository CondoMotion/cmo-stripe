# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".delete_post").bind "ajax:success", ->
    $(this).closest(".news_post").fadeOut()
    if $(".news_post").length == 1
      $("#posts").html("<div class='center no-content'><i class='icon-bullhorn'></i><h5>There are no news posts for the selected property</h5></div>")