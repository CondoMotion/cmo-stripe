class Cmo.Views.IssuesIndex extends Backbone.View

  template: JST['issues/index']

  initialize: ->
    @listenTo(@collection, 'reset change', @render)
    @listenTo(Cmo.state,   'reset change', @render)
    @render()
    
  render: ->
    siteId = Cmo.state.get('siteId')
    if siteId > 0
      issuesSet = @collection.bySite(siteId)
    else
      issuesSet = @collection
    $(@el).html(@template(issues: issuesSet))
    this
