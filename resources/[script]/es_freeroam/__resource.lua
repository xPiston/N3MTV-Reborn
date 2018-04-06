
description 'FiveM es_freeroam'


-- Requiring essentialmode
dependency 'essentialmode'

-- General
client_scripts {
  'client.lua',
  'player/map.lua',
  'player/scoreboard.lua',
  'stores/stripclub.lua',
  'stores/vehshop.lua'
}

server_scripts {
  'config.lua',
  'server.lua',
  'player/commands.lua',
  'stores/vehshop_s.lua',
  '@mysql-async/lib/MySQL.lua',
}
