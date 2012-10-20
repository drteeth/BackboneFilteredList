class ListView extends Backbone.View
  tagName: 'ul'

  initialize: (options) ->
    @collection.on 'reset', @setSubCollection, this
    @collection.on 'change', @change, this
    @amount = options.amount
    @subCollection = new Items

    @subCollection.on 'reset', @addAll, this
    # @subCollection.on 'add', @addOne, this
    @subCollection.on 'remove', @removeOne, this

  change: (item) ->
    if @amount != item.get "amount"
      @removeFromSubCollection item
    else
      @addToSubCollection item
    @addAll()

  addOne: (item) ->
    view = new ItemView model:item
    @$el.append(view.render().el)

  addAll: ->
    @$el.empty()
    @subCollection.each @addOne, this

  setSubCollection: ->
    @subCollection.reset @collection.sortBy @amount

  update: (item) ->

  removeFromSubCollection: (item) ->
    @subCollection.remove item

  addToSubCollection: (item) ->
    @subCollection.add item

  removeOne: (item) ->
    console.log 'remove'
    item.trigger "remove"

  render: ->
    this
