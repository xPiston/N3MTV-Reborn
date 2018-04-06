local firstspawn = 0

function sendnotif(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)	
end





AddEventHandler('playerSpawned', function(spawn)
	sendnotif("ok")
	if firstspawn == 0 then
		sendnotif("spawnok")
		TriggerServerEvent("wlcheck:player")
		firstspawn = 1
	end
end)

RegisterNetEvent('wlcheck:boucleinfini')
AddEventHandler('wlcheck:boucleinfini', function()
	sendnotif("ok boucle")
	while true do
		sendnotif("boucle")
	end
end)