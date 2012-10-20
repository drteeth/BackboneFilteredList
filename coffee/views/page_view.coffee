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