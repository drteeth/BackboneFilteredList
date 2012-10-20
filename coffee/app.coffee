class Item extends Backbone.Model
  defaults:
    amount: 0

class Items extends Backbone.Collection
  model: Item

class PageView extends Backbone.View

  className: 'page'

  events:
    'click #shuffle' : 'shuffle'

  initialize: (options) ->
    @listViews =
      0: new ListView(amount: 0, collection: @collection)
      1: new ListView(amount: 1, collection: @collection)
      2: new ListView(amount: 2, collection: @collection)

  rnd: (n) ->
    Math.floor(Math.random()*n)

  shuffle: ->
    index = @rnd(@collection.length)
    @collection.at(index).set('amount', @rnd(3))

  render: ->
    @$el.html "<button id=\"shuffle\">shuffle</button></div><div id=\"container\"></div>"
    $el = @$el.find('#container')
    _.each @listViews, (view) ->
      $el.append view.render().el
    this

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

class ItemView extends Backbone.View
  tagName: 'li'

  initialize: (options) ->
    @model.on 'change:amount', @update, this

  update: (item) ->
    @$el.find('.amount').html item.get('amount')

  render: ->
    @$el.html "#{@model.get('title')} (<span class=\"amount\">#{@model.get('amount')}</span>)"
    this

$ ->
  # create some items
  items = _([1..20]).map (i) ->
      title: "Item #{i}"
      amount: i % 3

  collection = new Items()
  page = new PageView(collection: collection)
  $('body').html page.render().el

  # add the items
  collection.reset(items)
