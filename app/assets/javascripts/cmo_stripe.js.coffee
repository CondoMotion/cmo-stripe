window.CmoStripe =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  
  init: ->
    @appState = new CmoStripe.Models.State

    @ev = new CmoStripe.Views.Events

    new CmoStripe.Routers.Dashboard
    Backbone.history.start()

$(document).ready ->
  CmoStripe.init()

  