window.Cmo =

  Models: {}
  Collections: {}
  Views: {}


  updateUrl: ->
    siteId = Cmo.state.get('siteId')
    filter = Cmo.state.get('filter')
    url = ""
    if siteId > 0
      url += "site/#{siteId}"
      if filter != "activity"
        url += "/"
    if filter != "activity"
      url += "#{filter}"
    Backbone.history.navigate(url)


  setupEvents: ->
    # cerate an event aggregator
    @ev = _.extend({}, Backbone.Events);

    @ev.on 'some:event', ->
      alert 'event fired'
      
    @ev.on 'setSiteId', (id) ->
      Cmo.state.set('siteId', id)
      Cmo.updateUrl()
      
    @ev.on 'setFilter', (filter) ->
      Cmo.state.set('filter', filter)
      Cmo.updateUrl()

  
  init: ->
    @state = new  Cmo.Models.State
    @setupEvents()

    @dashView = new Cmo.Views.Dashboard({el:"#container"})

    new Cmo.Router
    Backbone.history.start()


$(document).ready ->
  Cmo.init()
