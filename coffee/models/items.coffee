class Items extends Backbone.Collection
  model: Item

  sortBy: (amount) ->
    _(@models).filter (item) ->
      amount == item.get "amount"
