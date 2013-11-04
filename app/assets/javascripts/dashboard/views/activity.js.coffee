class Cmo.Views.Activity extends Backbone.View

  template: JST['activity']

  initialize: ->
    @listenTo(Cmo.state, 'reset change', @render)
    @render()
    
  render: ->
    console.log('activity render')
    id = Cmo.state.get('siteId')
    if id > 0
      label = "site #{id}"
    else
      label = "all sites"


    $(@el).html(@template(siteLabel: label))
    this
