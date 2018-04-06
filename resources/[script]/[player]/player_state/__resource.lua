resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'ui/index.html'
files {
	'ui/index.html',
	'ui/pdown.ttf'
}

server_script '@mysql-async/lib/MySQL.lua'
client_script "client.lua"
server_script "server.lua"

export 'checkneeds'
export 'updateneeds'
export 'customupdateneeds'
export 'setneeds'
export 'addcalories'
export 'removecalories'
export 'addwater'
export 'removewater'
export 'addneeds'
export 'removeneeds'