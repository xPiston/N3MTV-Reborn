--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

client_scripts {


  'weeds/weed_common.lua',
  'weeds/weed_client.lua',

  'meth/meth_client.lua',

  'transform/transform_client.lua',

  'client_base.lua',
  -- 'organe/organe_client.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',

  'server_base.lua',
  
  'weeds/weed_common.lua',
  'weeds/weed_server.lua',

  'transform/transform_server.lua',

  -- 'organe/organe_server.lua',
}

dependencies{
  'vdk_inventory',
  'gc_utils'
} 