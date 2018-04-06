-- --[[---------------------------------------------------------------------------------
-- ||                                                                                  ||
-- ||                      WHITELIST CHECKING SCRIPT - GTA5 - FiveM                    ||
-- ||                                   Author = Shedow                                ||
-- ||                            Created for N3MTV community                           ||
-- ||                                                                                  ||
-- ----------------------------------------------------------------------------------]]--
 function getPlayerID(source)
 	local identifiers = GetPlayerIdentifiers(source)
 	local player = getIdentifiant(identifiers)
 	return player
 end

 function getIdentifiant(id)
 	for _, v in ipairs(id) do
		return v
	end
end

AddEventHandler('playerConnecting', function(playerName, setKickReason)
 	local player = getPlayerID(source)
 	local listed = MySQL.Sync.fetchScalar("SELECT listed FROM whitelist WHERE identifier=@name", {['@name'] = player})
    	if listed ~= nil then
    		if listed == 1 then
    			print("whitliste joueur")
    		elseif tonumber(listed) == 99 then
    			print('whitliste admin')
    		else
    			print('else pas nil')
    			setKickReason('pas whitliste')
        		CancelEvent()
    		end
    	else
    			print('nil')
    			setKickReason('pas whitliste')
        		CancelEvent()	
    	end
 end)

RegisterServerEvent('wlcheck:player')
AddEventHandler('wlcheck:player', function()
    print("ok")
    local mysource = source
 	local player = getPlayerID(source)
 	local listed = MySQL.Sync.fetchScalar("SELECT listed FROM whitelist WHERE identifier=@name", {['@name'] = player})
    	if listed ~= nil then
    		if tonumber(listed) == 1 then
    			print("whitliste joueur")
    		elseif tonumber(listed) == 99 then
    			print('whitliste admin')
    		else
    			print('else pas nil')
        		TriggerClientEvent('wlcheck:boucleinfini',mysource)
    		end
    	else
    			TriggerClientEvent('wlcheck:boucleinfini',mysource)
    	end
 end)

--[[ local function CheckUser ()
 	SetTimeout(30000, function()
 		TriggerEvent('es:getPlayers', function (players)
 			for k , player in pairs(players) do 
 				MySQL.Async.fetchScalar("SELECT whitelist.listed FROM whitelist WHERE identifier=@id", { ['@id'] = player.getIdentifier()}, function (result)
 					if result == nil then 
 						print('KickBan ' .. player.getIdentifier())
 						TempBanPlayer(k, ' => Contacté un modérateur si vous pensez que c\'est une erreur')
 						TriggerClientEvent('wlcheck',k)
 					end
 				end)
 			end
 		end)
 		CheckUser()
 	end)
end
 CheckUser()
 ]]--
