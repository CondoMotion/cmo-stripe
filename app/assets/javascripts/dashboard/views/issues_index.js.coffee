class Cmo.Views.IssuesIndex extends Backbone.View

  template: JST['issues/index']

  events:
    'submit #issueForm'    : 'submitIssue'
    'click .deleteIssue'   : 'deleteIssue'
    'click .editIssue'     : 'editIssue'
    'click #createIssueBtn': 'createIssue'
    
  initialize: ->
    @listenTo(@collection, 'reset change remove', @render)
    @listenTo(Cmo.state,   'reset change', @render)
    @editingId = null
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
    $('#issueFormTitle').val('')
    $('#issueFormDetails').val('')
    $('#issueModalLabel').text('New Issue')
    $('#issueFormSubmit').val('Create Issue')
    @editingId = null
    
  editIssue: (event) ->
    event.preventDefault()
    issueId = $(event.target).attr("data-id")
    issue = @collection.get(issueId)
    $('#issueFormTitle').val(issue.get('title'))
    $('#issueFormDetails').val(issue.get('details'))
    $('#issueModalLabel').text('Edit Issue')
    $('#issueFormSubmit').val('Save Changes')
    $('#issueModal').modal('show')
    @editingId = issueId
    
  submitIssue: (event) ->
    event.preventDefault()
    siteId = Cmo.state.get('siteId')
    title = $('#issueFormTitle').val()
    details = $('#issueFormDetails').val()
    $('#issueModal').modal('hide')
    if @editingId is null
      @collection.create({title: title, details: details, site_id: siteId})
    else
      issue = @collection.get(@editingId)
      issue.set({title: title, details: details})
      issue.save()
    
  deleteIssue: (event) ->
    event.preventDefault()
    issueId = $(event.target).attr("data-id")
    @collection.get(issueId).destroy()

  