class Cmo.Views.IssuesIndex extends Backbone.View

  template: JST['issues/index']

  events:
    'submit #newIssue'  : 'createIssue'
    'click .deleteIssue': 'deleteIssue'

  initialize: ->
    @listenTo(@collection, 'reset change remove', @render)
    @listenTo(Cmo.state,   'reset change', @render)
    @render()
    
  render: ->
    console.log('rendering sites')
    siteId = Cmo.state.get('siteId')
    if siteId > 0
      issuesSet = @collection.bySite(siteId)
    else
      issuesSet = @collection
    $(@el).html(@template(issues: issuesSet))
    this

  createIssue: (event) ->
    event.preventDefault()
    siteId = Cmo.state.get('siteId')
    title = $('#newIssueTitle').val()
    details = $('#newIssueDetails').val()
    @collection.create({title: title, details: details, site_id: siteId})
    $('#issueModal').modal('hide')


  deleteIssue: (event) ->
    event.preventDefault()
    issueId = $(event.target).attr("data-id")
    @collection.get(issueId).destroy()

