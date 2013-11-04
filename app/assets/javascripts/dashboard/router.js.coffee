class Cmo.Router extends Backbone.Router
  routes:
    ''                : 'index'
    'site/:id'        : 'site'
    'site/:id/issues' : 'siteIssues'
  index: ->
    Cmo.ev.trigger("setSiteId", 0)
    Cmo.ev.trigger('setFilter', 'activity')
    
  site: (id) ->
    Cmo.ev.trigger("setSiteId", id)
    Cmo.ev.trigger('setFilter', 'activity')
    
  siteIssues: (id) ->
    Cmo.ev.trigger('setSiteId', id)
    Cmo.ev.trigger('setFilter', 'issues')