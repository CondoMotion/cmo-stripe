# allow urls without the '#' eg. /dashboard/issues instead of /dashboard/#issues
CmoStripe.Router.reopen
        location: 'history'
        rootURL: '/dashboard/'
        
CmoStripe.Router.map ->
        @route 'issues', path: '/issues'
        @route 'sites', path: '/sites'

CmoStripe.IssuesRoute = Ember.Route.extend
        model: -> CmoStripe.Issue.find()

CmoStripe.SitesRoute = Ember.Route.extend
        model: -> CmoStripe.Site.find()

        