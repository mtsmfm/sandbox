var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.
var Menu = require('menu');

// Report crashes to our server.
require('crash-reporter').start();

var mainWindow = null;

app.on('ready', function() {
  var globalShortcut = require('global-shortcut');

  mainWindow = new BrowserWindow({
    width: 300, height: 100, show: false, 'always-on-top': true, 'skip-taskbar': false,
    frame: false
  });
  mainWindow.loadUrl('file://' + __dirname + '/index.html');

  mainWindow.on('blur', function() {
    mainWindow.hide();
  });

  globalShortcut.register('Ctrl+Space', function() {
    mainWindow.show();
  });

  var template = [{
    label: 'Atom Shell',
    submenu: [{
      accelerator: 'Esc',
      click: function() { mainWindow.hide(); }
    }]
  }];

  menu = Menu.buildFromTemplate(template);
  mainWindow.setMenu(menu);
});
