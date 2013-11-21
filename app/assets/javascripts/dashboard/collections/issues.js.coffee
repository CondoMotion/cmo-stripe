class Cmo.Collections.Issues extends Backbone.Collection
  url: '/issues'#.json'
  model: Cmo.Models.Issue

  bySite: (siteId) ->
    filtered = @filter( (issue) ->
      +issue.get("site_id") is +siteId
    )
    new Cmo.Collections.Issues(filtered)
