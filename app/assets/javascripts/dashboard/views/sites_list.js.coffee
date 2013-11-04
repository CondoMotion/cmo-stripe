class Cmo.Views.SitesList extends Backbone.View

  template: JST['sites/list']

  events:
    'click .siteLink': 'clickSiteLink'

  initialize: ->
    @listenTo(@collection, 'reset change', @render)
    @listenTo(Cmo.state, 'reset change', @highlightSite)
#    @listenTo(Cmo.ev, 'setSiteId', @setSiteId)
    @render()
    
  render: ->
    $(@el).html(@template(sites: @collection))
    @highlightSite()
    this

  clickSiteLink: (event) ->
    event.preventDefault()
    siteId = $(event.target).attr("data-id")
    # trigger an event on our global event aggregator, since we're also
    # a listener to this event, the local 'setSiteId' will get called too.
    Cmo.ev.trigger("setSiteId", siteId)

  highlightSite: ->
    id = Cmo.state.get('siteId')
    @$("a").removeClass('active')
    @$("a[data-id='#{id}']").addClass('active')

