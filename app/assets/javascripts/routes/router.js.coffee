# allow urls without the '#' eg. /dashboard/issues instead of /dashboard/#issues
CmoStripe.Router.reopen
        location: 'history'
        rootURL: '/dashboard/'
        
CmoStripe.Router.map ->
#        @resource 'issues', path: '/issues'
        @resource 'sites', path: '/sites', ->
                @resource 'site', path: '/:site_id', ->
                        @resource 'issues', path: '/issues'
                        
        @route 'all_issues', path: '/all_issues'
        
#        @resource 'sites', ->
#                @resource 'site', path: '/:site_id', ->
#                        @resource 'issues', path: '/issues'
                                
CmoStripe.IssuesRoute = Ember.Route.extend
        model: -> CmoStripe.Issue.find()

CmoStripe.AllIssuesRoute = Ember.Route.extend
        model: -> CmoStripe.Issue.find()

CmoStripe.SitesRoute = Ember.Route.extend
        model: -> CmoStripe.Site.find()

        