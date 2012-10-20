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

  # setInterval ->
  #   ($ "#shuffle").click()
  # , 300

