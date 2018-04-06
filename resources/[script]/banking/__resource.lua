ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/bank-icon.png',
	'html/logo.png',
	'html/cursor.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js'
}

client_script "client.lua"
server_script '@mysql-async/lib/MySQL.lua'

server_script "server.lua"
