class Item extends Backbone.Model
  defaults:
    amount: 0

class Items extends Backbone.Collection
  model: Item

class PageView extends Backbone.View

  initialize: (options) ->
    @listViews =
      0: new ListView(collection: @collection)
      1: new ListView(collection: @collection)
      2: new ListView(collection: @collection)

  render: ->
    $el = @$el
    $el.html "<h2>Lists!</h2>"
    _.each @listViews, (view) ->
      $el.append view.render().el
    this

class ListView extends Backbone.View
  tagName: 'ul'

  initialize: (options) ->
    @collection.on 'add', @addOne, this
    @collection.on 'reset', @addAll, this
    @collection.on 'remove', @removeOne, this

  addOne: (item) ->
    view = new ItemView(model:item)
    @$el.append(view.render().el)

  addAll: ->
    @collection.each @addOne, this

  render: ->
    this

class ItemView extends Backbone.View
  tagName: 'li'

  render: ->
    @$el.html "#{@model.get('title')} (#{@model.get('amount')})"
    this

$ ->
  # create some items
  items = _([1..20]).map (i) ->
      title: "Title #{i}"
      amount: i % 3

  collection = new Items()
  page = new PageView(collection: collection)
  $('body').html page.render().el
  collection.reset(items)
