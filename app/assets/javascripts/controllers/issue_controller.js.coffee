CmoStripe.IssueController = Ember.ObjectController.extend
        isEditing: false
        removeIssue: ->
                issue = @get('model')
                console.log(this)
                issue.deleteRecord()
                @get('store').commit()
        editIssue: ->
                @set('isEditing', true)
        updateIssue: ->
                @get('store').commit()