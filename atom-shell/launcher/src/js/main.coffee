'use strict'

app = require('app')
# Module to control application life.
BrowserWindow = require('browser-window')
# Module to create native browser window.
Menu = require('menu')
# Report crashes to our server.
require('crash-reporter').start()
mainWindow = null
app.on 'ready', ->
  globalShortcut = require('global-shortcut')
  mainWindow = new BrowserWindow
    width: 600
    height: 150
    show: false
    frame: false
    x: 200
    y: 100

  atomScreen = require('screen')
  size = atomScreen.getPrimaryDisplay().workAreaSize
  console.log size

  mainWindow.loadUrl 'file://' + __dirname + '/../html/index.html'
  mainWindow.on 'blur', ->
    mainWindow.hide()
  globalShortcut.register 'Ctrl+Space', ->
    if mainWindow.isVisible()
      mainWindow.hide()
    else
      mainWindow.show()

  mainWindow.openDevTools()
  template = [ {
    label: 'Atom Shell'
    submenu: [ {
      accelerator: 'Esc'
      click: ->
        mainWindow.hide()
    } ]
  } ]
  menu = Menu.buildFromTemplate(template)
  mainWindow.setMenu menu
