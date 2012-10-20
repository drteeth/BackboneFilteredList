class ListView extends Backbone.View
  tagName: 'ul'

  initialize: (options) ->
    @collection.on 'add', @addOne, this
    @collection.on 'reset', @addAll, this
    @collection.on 'remove', @removeOne, this
    @amount = options.amount

  addOne: (item) ->
    if @amount == item.get('amount')
      view = new ItemView(model:item)
      @$el.append(view.render().el)

  addAll: ->
    @collection.each @addOne, this

  removeOne: (item) ->
    # @collection.

  render: ->
    this