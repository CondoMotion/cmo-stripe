$ ->
  $(".permissions-toggle").on "click", ->
    $(this).toggleClass("active")

  $(".wysihtml5-toolbar .btn").each (index) ->
    $(this).attr('tabindex', '-1')