--[[Info]]--

-- require "resources/mysql-async/lib/MySQL"
-- require "resources/mysql-async/lib/EssentialModeApi"

--[[Register]]--

RegisterServerEvent("dmv:success")
RegisterServerEvent("dmv:successCompleted")
RegisterServerEvent("dmv:LicenseStatus")
RegisterServerEvent("dmv:ttcharge")
RegisterServerEvent("dmv:dtcharge")
RegisterServerEvent("dmv:removePoints")
RegisterServerEvent("dmv:removeLicence")
--[[DMV TheoryTest]]--

AddEventHandler("dmv:success", function()
		local source = source
	TriggerEvent("es:getPlayerFromId", source, function(player)
		MySQL.Sync.execute("UPDATE users SET DmvTest='Passed' WHERE identifier = @username", { ['@username'] = player.getIdentifier()})
	end)
end)

AddEventHandler("dmv:successCompleted", function()
	local source = source
	TriggerEvent("es:getPlayerFromId", source, function(player)
		MySQL.Sync.execute("UPDATE users SET DmvTest='Completed' WHERE identifier = @username", { ['@username'] = player.getIdentifier()})
	end)
end)

AddEventHandler("dmv:ttcharge", function()
	local source = source
  TriggerEvent('es:getPlayerFromId', source, function(user)
		local ttest = 800  
    user.removeMoney(ttest)    
	end)
end)

AddEventHandler("dmv:dtcharge", function()
	local source = source
  TriggerEvent('es:getPlayerFromId', source, function(user)
		local dtest = 1700 	
    user.removeMoney(dtest)    
	end)
end)

--[[ ***** SPAWN CHECK ***** ]]

function getPoints(identifier)
	return MySQL.Sync.fetchScalar("SELECT points FROM user_license WHERE identifier=@idendentifier",{['@idendentifier'] = identifier})
end

AddEventHandler("dmv:LicenseStatus", function()
		local source = source
		local identifier = GetPlayerIdentifiers(source)[1]
    --TriggerEvent("es:getPlayerFromId", source, function(player)
				local LicStatus = MySQL.Sync.fetchScalar("SELECT users.DmvTest FROM users WHERE identifier = @username",{['@username'] = identifier})
        TriggerClientEvent('dmv:CheckLicStatus',source, LicStatus)
    --end)
end)

AddEventHandler("dmv:removePoints", function(pointsRemove, player, source)
	TriggerEvent("es:getPlayerFromId", player, function(him)
		local points = getPoints(him.getIdentifier())
		local result = points - pointsRemove
		if tonumber(result) >= 0 then
			MySQL.Sync.fetchScalar("UPDATE user_license SET points=@points WHERE identifier=@identifier", {['@points'] = result, ['@identifier'] = him.getIdentifier()})
			TriggerClientEvent('chatMessage', player, 'GOUVERNMENT', {255, 0, 0}, "vous avez perdu " .. pointsRemove .." sur votre permis")
			TriggerClientEvent('chatMessage', source, 'GOUVERNMENT', {255, 0, 0}, "vous avez retiré " .. pointsRemove .." à " .. GetPlayerName(player))
		--	TriggerClientEvent('gcl:notify', him, '~o~vous avez retiré ' .. result .. ' point(s) a ' .. player.nom)
		else
			MySQL.Sync.fetchScalar("UPDATE users SET DmvTest='Required' WHERE identifier=@identifier", {['@identifier'] = him.getIdentifier()})
			MySQL.Sync.fetchScalar("DELETE FROM user_license WHERE identifier=@identifier", {['@identifier'] = him.getIdentifier()})
			TriggerClientEvent('chatMessage', player, 'PREFECTURE', {255, 0, 0}, "Vous n'avez plus point sur votre permis, votre permis est retiré ")
			TriggerClientEvent('chatMessage', source, 'PREFECTURE', {255, 0, 0}, GetPlayerName(player) .. " n'a plus de point, son permis est enlevé")
			TriggerClientEvent('dmv:reloadLicense', player)
		end
	end)
end)

AddEventHandler("dmv:removeLicence", function(player, source)
	TriggerEvent("es:getPlayerFromId", player, function(him)
		MySQL.Sync.fetchScalar("UPDATE users SET DmvTest = 'Required' WHERE identifier=@identifier", {['@identifier'] = him.getIdentifier()})
		MySQL.Sync.fetchScalar("DELETE FROM user_license WHERE identifier=@identifier", {['@identifier'] = him.getIdentifier()})
		TriggerClientEvent('chatMessage', player, 'PREFECTURE', {255, 0, 0}, "votre permis a été retiré")
		TriggerClientEvent('chatMessage', source, 'PREFECTURE', {255, 0, 0}, "vous avez retiré le permis de " .. GetPlayerName(player))
		TriggerClientEvent('dmv:reloadLicense', player)
	end)
end)