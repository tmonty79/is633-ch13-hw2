window.Raffler =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Raffler.Routers.Entries
    Backbone.history.start()


class Raffler.Routers.Entries extends Backbone.Router
  routes:
    '': 'index'
    'entries/:id': 'show'
  initialize: ->
    @collection = new Raffler.Collections.Entries()
    @collection.fetch()
  index: ->
    view = new Raffler.Views.EntriesIndex(collection: @collection)
    $('#raffler').html(view.render().el)
  show: (id) ->
    console.log "Entry #{id}"


class Raffler.Views.EntriesIndex extends Backbone.View
  template: _.template($('#item-template').html())
  events:
    'click #add': 'createEntry'
    'click #draw': 'drawWinner'
    'click #reset': 'reset'
    'click li': 'kill'
  initialize: ->
    @collection.on('sync', @render, this)
    @collection.on('add', @render, this)
    @collection.on('destroy', @render, this)
  render: ->
    $(@el).html(@template(entries: @collection.toJSON()))
    this
  createEntry: ->
    @collection.create name: $('#new_entry').val()
    $('#new_entry').focus()
  drawWinner: ->
    @reset()
    winner = @collection.shuffle()[0]
    if winner
      winner.set(winner: true)
      winner.save()
  reset: ->
    @collection.each (entry) ->
      entry.set(winner: false)
      entry.save()
  kill: (ev) ->
    console.log $(ev.target).attr('id')
    item=@collection.find (model) ->
      model.get('id') is $(ev.target).attr('id')
    item.destroy()


#class Raffler.Models.Entry extends Backbone.Model
#  defaults:
#    name: ''
#    winner: false


class Raffler.Collections.Entries extends Backbone.Collection
  #url: 'db/rest-stub.php?'
  model: Raffler.Models.Entry
  localStorage: new Store('montalvo-ch12-hw2')


$(document).ready ->
 Raffler.init()