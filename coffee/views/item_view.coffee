class ItemView extends Backbone.View
  tagName: 'li'

  initialize: (options) ->
    @model.on 'change:amount', @update, this
    @model.on 'remove', @dispose, this

  update: (item) ->
    @$el.find('.amount').html item.get('amount')

  render: ->
    @$el.html "#{@model.get('title')} (<span class=\"amount\">#{@model.get('amount')}</span>)"
    this

  dispose: ->
    @undelegateEvents()
    @model.off null, null, this
    @$el.remove()
    this