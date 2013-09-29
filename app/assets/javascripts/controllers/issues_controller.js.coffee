CmoStripe.IssuesController = Ember.ArrayController.extend
        addIssue: (title) ->
                CmoStripe.Issue.createRecord(title: title)
                @get('store').commit()
                