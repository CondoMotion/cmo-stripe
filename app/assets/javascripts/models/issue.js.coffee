CmoStripe.Issue = DS.Model.extend
        title: DS.attr 'string'
        site: DS.belongsTo('CmoStripe.Site')
        