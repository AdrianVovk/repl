ReplView = require './repl-view'
{CompositeDisposable} = require 'atom'

module.exports = Repl =
  replView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @replView = new ReplView(state.replViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @replView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'repl:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @replView.destroy()

  serialize: ->
    replViewState: @replView.serialize()

  toggle: ->
    console.log 'Repl was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
