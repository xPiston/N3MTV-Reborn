-- resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/style.css',
	'html/script.js',
	'html/carteV3_h.png',
	'html/carteV3_f.png',
	'html/permis_f.png',
	'html/permis_h.png',
	'html/cursor.png'
}

client_script {
	"client.lua"
}
server_script '@mysql-async/lib/MySQL.lua'
server_script "server.lua"

