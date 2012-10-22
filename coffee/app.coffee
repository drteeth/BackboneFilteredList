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

  rnd = (n) ->
    Math.floor(Math.random()*n)

  shuffle = ->
    index = rnd(collection.length)
    item = collection.at(index)
    item.set('amount', rnd(3)) if item

  removeAnItem = ->
    index = rnd(collection.length)
    item = collection.at(index)
    collection.remove(item)

  addAnItem = ->
    i = collection.length + 1
    collection.add new Item(title: "Item #{i}", amount: i % 3)

  # shake things up
  setInterval(shuffle, 100)
  setInterval(removeAnItem, 300)
  setInterval(addAnItem, 200)