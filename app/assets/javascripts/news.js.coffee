# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.chosen').chosen()

  myCustomTemplates = 
    'font-styles': (locale) ->
      "<li class='dropdown'>" +
        "<a class='btn dropdown-toggle' data-toggle='dropdown' href='#'>" +
        "<i class='icon-font'></i>&nbsp;<span class='current-font'>" + locale.font_styles.normal + "</span>&nbsp;<b class='caret'></b>" +
        "</a>" +
        "<ul class='dropdown-menu'>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='div'>" + locale.font_styles.normal + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h1'>" + locale.font_styles.h1 + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h2'>" + locale.font_styles.h2 + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h3'>" + locale.font_styles.h3 + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h4'>" + locale.font_styles.h4 + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h5'>" + locale.font_styles.h5 + "</a></li>" +
          "<li><a data-wysihtml5-command='formatBlock' data-wysihtml5-command-value='h6'>" + locale.font_styles.h6 + "</a></li>" +
        "</ul>" +
      "</li>"

    emphasis: (locale) ->
      "<li>" +
        "<div class='btn-group'>" +
          "<a class='btn' data-wysihtml5-command='bold' title='CTRL+B'><i class='icon-bold'></i></a>" +
          "<a class='btn' data-wysihtml5-command='italic' title='CTRL+I'><i class='icon-italic'></i></a>" +
          "<a class='btn' data-wysihtml5-command='underline' title='CTRL+U'><i class='icon-underline'></i></a>" +
        "</div>" +
      "</li>"

    lists: (locale) ->
      "<li>" +
        "<div class='btn-group'>" +
          "<a class='btn' data-wysihtml5-command='insertUnorderedList' title='" + locale.lists.unordered + "'><i class='icon-list-ul'></i></a>" +
          "<a class='btn' data-wysihtml5-command='insertOrderedList' title='" + locale.lists.ordered + "'><i class='icon-list-ol'></i></a>" +
          "<a class='btn' data-wysihtml5-command='Indent' title='" + locale.lists.indent + "'><i class='icon-indent-right'></i></a>" +
          "<a class='btn' data-wysihtml5-command='Outdent' title='" + locale.lists.outdent + "'><i class='icon-indent-left'></i></a>" +
        "</div>" +
      "</li>"

    link: (locale) ->
      "<li>" +
        "<div class='bootstrap-wysihtml5-insert-link-modal modal hide fade'>" +
          "<div class='modal-header'>" +
            "<a class='close' data-dismiss='modal'>&times;</a>" +
            "<h3>" + locale.link.insert + "</h3>" +
          "</div>" +
          "<div class='modal-body'>" +
            "<input value='http://' class='bootstrap-wysihtml5-insert-link-url input-xlarge'>" +
          "</div>" +
          "<div class='modal-footer'>" +
            "<a href='#' class='btn' data-dismiss='modal'>" + locale.link.cancel + "</a>" +
            "<a href='#' class='btn btn-success' data-dismiss='modal'>" + locale.link.insert + "</a>" +
          "</div>" +
        "</div>" +
        "<a class='btn' data-wysihtml5-command='createLink' title='" + locale.link.insert + "'><i class='icon-link'></i></a>" +
      "</li>"

    html: (locale) ->
      "<li>" +
        "<div class='btn-group'>" +
          "<a class='btn' data-wysihtml5-action='change_view' title='" + locale.html.edit + "'>HTML</a>" +
        "</div>" +
      "</li>"

  $('.wysiwyg').wysihtml5
    "html": true
    customTemplates: myCustomTemplates



