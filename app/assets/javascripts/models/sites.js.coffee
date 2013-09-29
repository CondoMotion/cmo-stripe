CmoStripe.Site = DS.Model.extend
        name: DS.attr('string')
        issues: DS.hasMany('CmoStripe.Site')
        
