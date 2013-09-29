CmoStripe.EditIssueView = Ember.View.extend
        templateName: 'edit_issue'
        tagName: 'form'
        submit: ->
                @get('controller').send('updateIssue')
                @set('controller.isEditing', false)
                false
        focusOut: ->
                @submit()

