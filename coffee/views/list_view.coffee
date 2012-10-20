class ListView extends Backbone.View
  tagName: 'ul'

  initialize: (options) ->
    @collection.on 'reset', @setSubCollection, this
    @collection.on 'change', @change, this

    @amount = options.amount
    @subCollection = new Items

    @subCollection.on 'reset', @addAll, this
    @subCollection.on 'add', @addOne, this
    @subCollection.on 'remove', @removeOne, this

  change: (item) ->
    if @amount == item.get "amount"
      _.defer =>
        @addToSubCollection item
    else
      @removeFromSubCollection item

  addOne: (item) ->
    view = new ItemView model:item
    @$el.append(view.render().el)

  removeOne: (item) ->
    item.trigger "remove"

  addAll: ->
    @$el.empty()
    @subCollection.each @addOne, this

  setSubCollection: ->
    @subCollection.reset @collection.sortBy @amount


  removeFromSubCollection: (item) ->
    @subCollection.remove item

  addToSubCollection: (item) ->
    @subCollection.add item


  render: ->
    this
