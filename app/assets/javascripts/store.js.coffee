# http://emberjs.com/guides/models/defining-a-store/
DS.RESTAdapter.configure("plurals", property: "properties")

CmoStripe.Store = DS.Store.extend
  revision: 11
  adapter: DS.RESTAdapter.create()



