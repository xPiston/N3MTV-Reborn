-- Created by IntelliJ IDEA.
-- User: Djyss
-- Date: 06/06/2017
-- Time: 14:46
-- To change this template use File | Settings | File Templates.
--
ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/static/js/manifest.js',
    'ui/static/js/vendor.js',
    'ui/static/js/app.js',
    'ui/menu.js',
    'ui/static/css/reset.css',
    'ui/static/css/menu.css',
    'ui/static/css/app.css',
    'ui/static/img/popup-menu-arrows.png',
    'ui/static/img/popup-menu-arrows-r-l.png',
    'ui/static/img/xygrid.png',
    'ui/static/img/429.png',
    'ui/static/img/engine.png',
    'ui/static/img/kit.png',
    'ui/static/img/paid.png',
    'ui/static/img/paint.png',

}

server_script '@mysql-async/lib/MySQL.lua'
client_script 'client.lua'
server_script 'server.lua'

export 'GetBlacklistedList'
export 'GetBalancedList'
export 'GetBalancedCatList'
