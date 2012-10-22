class PageView extends Backbone.View

  className: 'page'

  initialize: (options) ->
    @collection.on 'reset', @addAll, this
    @collection.on 'remove', @removeOne, this
    @collection.on 'add', @addOne, this
    @collection.on 'change:amount', @moveItem, this
    @views = {}

  moveItem: (item) ->
    $listEl = @parentList(item)
    view = @views[item.cid]
    $listEl.append(view.el)

  parentList: (item) ->
    @$el.find("#list-#{item.get('amount')}")

  removeOne: (item) ->
    delete @views[item.cid]

  addOne: (item) ->
    $list = @$el.find(@parentList(item))
    view = new ItemView(model:item)
    $list.append view.render().el
    @views[item.cid] = view

  addAll: ->
    @collection.each(@addOne, this)

  render: ->
    @$el.html "<div id=\"container\"></div>"
    $el = @$el.find('#container')

    # create the 3 lists
    _.each [0..2], (n) ->
      $el.append "<ul id=\"list-#{n}\"></ul>"
    this

  dispose: ->
    # TODO dispose of all the child views


