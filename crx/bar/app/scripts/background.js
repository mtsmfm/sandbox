'use strict';

chrome.commands.onCommand.addListener(function() {
  chrome.windows.create({'url': 'index.html', 'type': 'popup', 'width': 500, 'height': 80});
});
