CmoStripe.NewIssueView = Ember.View.extend
        templateName: 'new_issue'
        tagName: 'form'

        submit: ->
                @get('controller').send('addIssue', @get('newIssueTitle'))
                @set('newIssueTitle', "")
                false
