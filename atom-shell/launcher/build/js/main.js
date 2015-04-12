(function() {
  'use strict';
  var BrowserWindow, Menu, app, mainWindow;

  app = require('app');

  BrowserWindow = require('browser-window');

  Menu = require('menu');

  require('crash-reporter').start();

  mainWindow = null;

  app.on('ready', function() {
    var atomScreen, globalShortcut, menu, size, template;
    globalShortcut = require('global-shortcut');
    mainWindow = new BrowserWindow({
      width: 600,
      height: 150,
      show: false,
      frame: false,
      x: 200,
      y: 100
    });
    atomScreen = require('screen');
    size = atomScreen.getPrimaryDisplay().workAreaSize;
    console.log(size);
    mainWindow.loadUrl('file://' + __dirname + '/../html/index.html');
    mainWindow.on('blur', function() {
      return mainWindow.hide();
    });
    globalShortcut.register('Ctrl+Space', function() {
      if (mainWindow.isVisible()) {
        return mainWindow.hide();
      } else {
        return mainWindow.show();
      }
    });
    mainWindow.openDevTools();
    template = [
      {
        label: 'Atom Shell',
        submenu: [
          {
            accelerator: 'Esc',
            click: function() {
              return mainWindow.hide();
            }
          }
        ]
      }
    ];
    menu = Menu.buildFromTemplate(template);
    return mainWindow.setMenu(menu);
  });

}).call(this);
