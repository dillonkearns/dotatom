# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
# path = require 'path'
#
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   if path.extname(editor.getPath()) is '.md'
#     editor.setSoftWrapped(true)


# vim-mode-plus configuration
hlsearch = (editor) ->
  atom.commands.dispatch(editor, 'quick-highlight:clear')
  atom.commands.dispatch(editor, 'quick-highlight:toggle')

# custom functions
atom.commands.add 'atom-text-editor', 'dillon:search-current-word', ->
  hlsearch(this)
  atom.commands.dispatch(this, 'vim-mode:search-current-word')


atom.commands.add 'atom-text-editor', 'dillon:reverse-search-current-word', ->
  hlsearch(this)
  atom.commands.dispatch(this, 'vim-mode:reverse-search-current-word')

atom.commands.add 'atom-text-editor', 'dillon:reset-normal-mode', ->
  atom.commands.dispatch(this, 'quick-highlight:clear')
  atom.commands.dispatch(this, 'vim-mode:reset-normal-mode')

atom.commands.add 'atom-text-editor', 'dillon:rename-param-under-cursor', ->
  atom.commands.dispatch(this, 'vim-mode-plus:select-occurrence')
  atom.commands.dispatch(this, 'vim-mode-plus-user:move-to-next-symbol')

atom.commands.add 'atom-text-editor', 'dillon:move-current-line-down', ->
  atom.commands.dispatch(this, 'vim-mode-plus:activate-linewise-visual-mode')
  atom.commands.dispatch(this, 'vim-mode-plus-user:move-selected-text-down')
  atom.commands.dispatch(this, 'vim-mode-plus:activate-normal-mode')

atom.commands.add 'atom-text-editor', 'dillon:move-current-line-up', ->
  atom.commands.dispatch(this, 'vim-mode-plus:activate-linewise-visual-mode')
  atom.commands.dispatch(this, 'vim-mode-plus-user:move-selected-text-up')
  atom.commands.dispatch(this, 'vim-mode-plus:activate-normal-mode')

atom.commands.add 'atom-text-editor', 'dillon:normal-mode-and-save', ->
  atom.commands.dispatch(this, 'vim-mode-plus:reset-normal-mode')
  atom.commands.dispatch(this, 'core:save')

atom.commands.add 'atom-text-editor', 'dillon:elm-quick-fix-and-save', ->
  atom.commands.dispatch(this, 'linter-elm-make:quick-fix')
  atom.commands.dispatch(this, 'core:save')

atom.commands.add 'atom-text-editor', 'dillon:elm-quick-fix-and-save-all', ->
  atom.commands.dispatch(this, 'linter-elm-make:quick-fix-all')
  atom.commands.dispatch(this, 'core:save')

atom.commands.add 'atom-text-editor', 'dillon:undo-and-normal-mode', ->
  atom.commands.dispatch(this, 'vim-mode-plus:activate-normal-mode')
  atom.commands.dispatch(this, 'vim-mode-plus:undo')
  atom.commands.dispatch(this, 'vim-mode-plus:reset-normal-mode')

atom.commands.add 'atom-text-editor', 'dillon:focus-next-pane', ->
  atom.commands.dispatch(this, 'window:focus-next-pane')
  atom.commands.dispatch(this, 'vim-mode-plus:reset-normal-mode')

atom.commands.add 'atom-text-editor', 'dillon:commit-all', ->
  atom.commands.dispatch(this, 'github:stage-all-changes')
  atom.commands.dispatch(this, 'github:toggle-git-tab-focus')
  atom.commands.dispatch(this, 'github:commit')
  atom.commands.dispatch(this, 'github:push')




# atom.commands.add 'atom-text-editor', 'custom:insert-newline-above': ->
#   atom.workspace.getActiveTextEditor()?.insertNewlineAbove()
#
# atom.commands.add 'atom-text-editor', 'custom:insert-newline-below': ->
#   atom.workspace.getActiveTextEditor()?.insertNewlineBelow()


# vim-mode-plus extensions
consumeService = (packageName, providerName, fn) ->
  disposable = atom.packages.onDidActivatePackage (pack) ->
    if pack.name is packageName
      service = pack.mainModule[providerName]()
      fn(service)
      disposable.dispose()

# consumeService 'vim-mode-plus', 'provideVimModePlus', ({Base}) ->
#   # vim-mode-plus add spaces above or below
#   Operator = Base.getClass('Operator')
#   class InsertNewlineBelow extends Operator
#     @commandPrefix: 'vim-mode-plus-user'
#     @registerCommand()
#     requireTarget: false
#     insertionRow: ->
#       @editor.getCursorScreenPosition().row
#     execute: ->
#       @editor.getBuffer().insert([@insertionRow(), Infinity], "\n".repeat(@getCount()))
#
#   class InsertNewlineAbove extends InsertNewlineBelow
#     @registerCommand()
#     insertionRow: ->
#       super() - 1
#
#   class ElmExtractFunction extends Operator
#     @commandPrefix: 'vim-mode-plus-user'
#     @registerCommand()
#     target: null
#     execute: ->
#       # make a selection before putting
#       # @startMutation(@selectTarget.bind(this))
#       # atom.workspace.getActiveTextEditor()?.save()
#       workspace = atom.views.getView(atom.workspace)
#       atom.commands.dispatch(workspace, 'elmjutsu:lift-to-top-level')
