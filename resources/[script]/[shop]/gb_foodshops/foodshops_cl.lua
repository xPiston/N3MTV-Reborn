local twentyfourseven_shops = {
	{ ['x'] = 1961.1140136719, ['y'] = 3741.4494628906, ['z'] = 32.34375 },
	{ ['x'] = 1392.4129638672, ['y'] = 3604.47265625, ['z'] = 34.980926513672 },
	{ ['x'] = 546.98962402344, ['y'] = 2670.3176269531, ['z'] = 42.156539916992 },
	{ ['x'] = 2556.2534179688, ['y'] = 382.876953125, ['z'] = 108.62294769287 },
	{ ['x'] = -1821.9542236328, ['y'] = 792.40191650391, ['z'] = 138.13920593262 },
	{ ['x'] = 128.1410369873, ['y'] = -1286.1120605469, ['z'] = 29.281036376953 },
	{ ['x'] = -1223.6690673828, ['y'] = -906.67517089844, ['z'] = 12.326356887817 },
	{ ['x'] = -708.19256591797, ['y'] = -914.65264892578, ['z'] = 19.215591430664 },
	{ ['x'] = 26.419162750244, ['y'] = -1347.5804443359, ['z'] = 29.497024536133 },
	{ ['x'] = 1163.31, ['y'] = -323.152, ['z'] = 69.2051 },
	{ ['x'] = 1729.24, ['y'] = 6415.23, ['z'] = 35.0372 },
	{ ['x'] = 1698.56, ['y'] = 4924.24, ['z'] = 42.063 },
	{ ['x'] = -3242.78, ['y'] = 1001.47, ['z'] = 12.8307 },
	{ ['x'] = -560.155, ['y'] = 286.698, ['z'] = 82.1764 },
	{ ['x'] = 374.228, ['y'] = 326.747, ['z'] = 103.566 },
}



RegisterNetEvent("food:getFood")
RegisterNetEvent("food:selection")
RegisterNetEvent("gabs:enviepipi")

function Chat(t)
	TriggerEvent("chatMessage", 'Shop', { 0, 255, 255}, "" .. tostring(t))
end

Citizen.CreateThread(function()
	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("FOOD")
		EndTextCommandSetBlipName(blip)
	end
end)


AddEventHandler("food:selection", function(data)
	local item = data.itemid
	local price = data.price
	if (exports.vdk_inventory:notFull() == true) then
		TriggerServerEvent('food:testprix',item,price)
	else
		Chat("INVENTAIRE PLEIN")
	end
end)

AddEventHandler("food:getFood", function(item)
	TriggerEvent('player:receiveItem',item,1)
end)

AddEventHandler("gabs:enviepipi", function()
	--Citizen.Trace("PIPIPIPI")
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
		TriggerServerEvent('gabs:pipi')
	else
		DisplayHelpText("Et si tu descendais du vehicule ca serai pas mieux ?")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
					DisplayHelpText("Appuyer sur ~INPUT_CONTEXT~ pour ouvrir/fermer le shop")
					if(IsControlJustReleased(1, 51))then
				        Menu.initMenu()
						Menu.isOpen = not Menu.isOpen
					end
					if Menu.isOpen then
						Menu.draw()
						Menu.keyControl()
					end
				end
			end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end