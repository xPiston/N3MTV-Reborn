local permission = {
	kick = 1,
	ban = 4
}

-- Adding custom groups called owner, inhereting from superadmin. (It's higher then superadmin). And moderator, higher then user but lower then admin
TriggerEvent("es:addGroup", "owner", "superadmin", function(group) end)
TriggerEvent("es:addGroup", "mod", "user", function(group) end)

-- ACE commands
TriggerEvent("es:addACECommand", "whoami", "", function(source, args, user)
end)

-- Default commands
TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Level: ^*^2 " .. tostring(user.get('permission_level')))
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Group: ^*^2 " .. user.getGroup())
end, {help = "Shows what admin level you are and what group you're in"})

-- Default commands
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent('chatMessage', source, "REPORT", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.permission_level > 0 and k ~= source)then
					TriggerClientEvent('chatMessage', k, "REPORT", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))
				end
			end)
		end
	end)
end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}})

-- Append a message
function appendNewPos(msg)
	local file = io.open('resources/[essential]/es_admin/positions.txt', "a")
	newFile = msg
	file:write(newFile)
	file:flush()
	file:close()
end

-- Do them hashes
function doHashes()
  lines = {}
  for line in io.lines("resources/[essential]/es_admin/input.txt") do
  	lines[#lines + 1] = line
  end

  return lines
end

RegisterServerEvent('es_admin:givePos')
AddEventHandler('es_admin:givePos', function(str)
	appendNewPos(str)
end)

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "admin", function(source, args, user)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kicked: You have been kicked from the server"
				else
					reason = "Kicked: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "admin", function(source, args, user)
	table.remove(args, 1)
	TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. table.concat(args, " "))
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been " .. state .. " by ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state)
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have brought by ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been brought")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have slapped by ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been teleported to by ^2" .. GetPlayerName(source))
					TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Teleported to player ^2" .. GetPlayerName(player) .. "")
				end
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Kill yourself
TriggerEvent('es:addCommand', 'die', function(source, args, user)
	TriggerClientEvent('es_admin:kill', source)
	TriggerClientEvent('chatMessage', source, "", {0,0,0}, "^1^*You killed yourself.")
end, {help = "Suicide"})

-- Killing
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been killed by ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been killed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
		if(GetPlayerName(tonumber(args[2])))then
			local player = tonumber(args[2])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
		end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Crash a user, no idea why this still exists", params = {{name = "userid", help = "The ID of the player"}}})

-- Position
TriggerEvent('es:addGroupCommand', 'pos', "owner", function(source, args, user)
	TriggerClientEvent('es_admin:givePosition', source)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Save position to file"})


-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'setadmin' then
		if #args ~= 2 then
				RconPrint("Usage: setadmin [user-id] [permission-level]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:setPlayerData", tonumber(args[1]), "permission_level", tonumber(args[2]), function(response, success)
			RconPrint(response)

			if(true)then
				print(args[1] .. " " .. args[2])
				TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'rank', tonumber(args[2]), true)
				TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Permission level of ^2" .. GetPlayerName(tonumber(args[1])) .. "^0 has been set to ^2 " .. args[2])
			end
		end)

		CancelEvent()
	elseif commandName == 'setgroup' then
		if #args ~= 2 then
				RconPrint("Usage: setgroup [user-id] [group]\n")
				CancelEvent()
				return
		end

		if(GetPlayerName(tonumber(args[1])) == nil)then
			RconPrint("Player not ingame\n")
			CancelEvent()
			return
		end

		TriggerEvent("es:getAllGroups", function(groups)

			if(groups[args[2]])then
				TriggerEvent("es:setPlayerData", tonumber(args[1]), "group", args[2], function(response, success)
					RconPrint(response)

					if(true)then
						print(args[1] .. " " .. args[2])
						TriggerClientEvent('es:setPlayerDecorator', tonumber(args[1]), 'group', tonumber(args[2]), true)
						TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Group of ^2^*" .. GetPlayerName(tonumber(args[1])) .. "^r^0 has been set to ^2^*" .. args[2])
					end
				end)
			else
				RconPrint("This group does not exist.\n")
			end
		end)

		CancelEvent()
	elseif commandName == 'setmoney' then
			if #args ~= 2 then
					RconPrint("Usage: setmoney [user-id] [money]\n")
					CancelEvent()
					return
			end

			if(GetPlayerName(tonumber(args[1])) == nil)then
				RconPrint("Player not ingame\n")
				CancelEvent()
				return
			end

			TriggerEvent("es:getPlayerFromId", tonumber(args[1]), function(user)
				if(user)then
					user.setMoney(tonumber(args[2]))

					RconPrint("Money set")
					TriggerClientEvent('chatMessage', tonumber(args[1]), "CONSOLE", {0, 0, 0}, "Your money has been set to: ^2^*$" .. tonumber(args[2]))
				end
			end)

			CancelEvent()
		end
end)

-- Logging
AddEventHandler("es:adminCommandRan", function(source, command)

end)
