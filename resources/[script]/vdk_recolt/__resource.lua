dependency 'vdk_inventory'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_script {
	'vdkrec.lua'
}