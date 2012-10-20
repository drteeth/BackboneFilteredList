class Items extends Backbone.Collection
  model: Item

  sortBy: (a) ->
    _(@models).filter (i) ->
      a == i.get "amount"
