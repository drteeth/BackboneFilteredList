class ItemView extends Backbone.View
  tagName: 'li'

  initialize: (options) ->
    console.log "init"
    # @model.on 'change:amount', @update, this
    @model.on 'remove', @getLost, this

  update: (item) ->
    @$el.find('.amount').html item.get('amount')

  render: ->
    @$el.html "#{@model.get('title')} (<span class=\"amount\">#{@model.get('amount')}</span>)"
    this

  getLost: ->
    console.log "getLost", @model
    @model.off null, null, this
