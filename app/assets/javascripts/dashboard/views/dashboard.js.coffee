class Cmo.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  events:
    'click #activityLink': 'showActivity'  
    'click #issuesLink':   'showIssues'

  initialize: ->
    @listenTo(Cmo.state, 'reset change', @applyFilter)
    @render()
    
    sites = new Cmo.Collections.Sites()
    sites.fetch({reset:true})
    sitesView = new Cmo.Views.SitesList(el: '#sitesList', collection: sites)

    issues = new Cmo.Collections.Issues()
    issues.fetch({reset:true})
    issuesView = new Cmo.Views.IssuesIndex(el: '#issuesPanel', collection: issues)

    activtyView = new Cmo.Views.Activity(el: '#activityPanel')

    console.log('init dashboard')

  render: ->
    $(@el).html(@template())
    @applyFilter()
    this

  showActivity: (event) ->
    event.preventDefault()
    Cmo.ev.trigger('setFilter', 'activity')
    
  showIssues: (event) ->
    event.preventDefault()
    Cmo.ev.trigger('setFilter', 'issues')

  applyFilter: ->
    filter = Cmo.state.get('filter')
    
    # highlight active link
    @$("#filterLinks").find('a').removeClass('active')
    @$("##{filter}Link").addClass('active')
    
    if filter is "issues"
      $('#issuesPanel').show();
      $('#activityPanel').hide();
    else
      $('#issuesPanel').hide();
      $('#activityPanel').show();
