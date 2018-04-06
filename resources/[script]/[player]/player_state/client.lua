local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 then
		firstspawn = 1
	else
		TriggerServerEvent('player_state:setdefaultneeds')
	end
end)

RegisterNetEvent('player_state:death')
AddEventHandler('player_state:death', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

-- FOOD
RegisterNetEvent('player_state:set')
AddEventHandler('player_state:set', function(state)
	SendNUIMessage({ state = json.encode({food = state.food, water = state.water, needs = state.needs})
	})
end)

-- EMOTES
RegisterNetEvent('player_state:drink')
AddEventHandler('player_state:drink', function()
	ped = GetPlayerPed(-1)
	if ped then
		Citizen.CreateThread(function()
			RequestAnimDict('amb@world_human_drinking_fat@beer@male@idle_a')
		    local pedid = PlayerPedId()
			TaskPlayAnim(pedid, 'amb@world_human_drinking_fat@beer@male@idle_a', 'idle_a', 8.0, -8, -1, 16, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(ped)
		end)
	end
end)

RegisterNetEvent('player_state:eat')
AddEventHandler('player_state:eat', function()
	ped = GetPlayerPed(-1)
	if ped then
		Citizen.CreateThread(function()
			RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
		    local pedid = PlayerPedId()
			TaskPlayAnim(pedid, 'amb@code_human_wander_eating_donut@male@idle_a', 'idle_c', 8.0, -8, -1, 16, 0, 0, 0, 0)
			Citizen.Wait(5000)
			ClearPedTasks(ped)
		end)
	end
end)

RegisterNetEvent('player_state:pee')
AddEventHandler('player_state:pee', function()
	ped = GetPlayerPed(-1)
	local hashSkin = GetHashKey("mp_m_freemode_01")
	if IsPedInAnyVehicle(GetPlayerPed(-1), true) == false then
		if ped then
			if(GetEntityModel(GetPlayerPed(-1)) ~= hashSkin) then
				Citizen.CreateThread(function()
					RequestAnimDict('missfbi3ig_0')
					local pedid = PlayerPedId()
					TaskPlayAnim(pedid, 'missfbi3ig_0', 'shit_loop_trev', 8.0, 8, -1, 0, 0, 0, 0, 0)
					ClearPedTasks(ped)
				end)
			else
				Citizen.CreateThread(function()
					RequestAnimDict('misscarsteal2peeing')
					local pedid = PlayerPedId()
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_intro', 8.0, -8, -1, 0, 0, 0, 0, 0)
					Citizen.Wait(GetAnimDuration('misscarsteal2peeing', 'peeing_intro'))
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_loop', 8.0, -8, -1, 0, 0, 0, 0, 0)
					Citizen.Wait(GetAnimDuration('misscarsteal2peeing', 'peeing_loop'))
					TaskPlayAnim(pedid, 'misscarsteal2peeing', 'peeing_outro', 8.0, -8, -1, 0, 0, 0, 0, 0)
					ClearPedTasks(ped)
				end)
			end
		end
	else
		--TriggerEvent("es_freeroam:notify", "CHAR_MP_STRIPCLUB_PR", 1, "Mairie", false, "ca serai pas mieux en dehors du vehicule?")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPauseMenuActive() then
			SendNUIMessage({ pause = true })
		else
			SendNUIMessage({ pause = false })
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000)
		TriggerServerEvent('player_state:check')
	end
end)