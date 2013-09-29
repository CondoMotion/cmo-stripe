CmoStripe.Router.map ->
        @route 'issues', path: '/'

CmoStripe.IssuesRoute = Ember.Route.extend
        model: -> CmoStripe.Issue.find()
        