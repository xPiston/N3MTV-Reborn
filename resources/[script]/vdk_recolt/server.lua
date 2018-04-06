RegisterServerEvent("jobs:getJobs")
nbPolice = 0
local jobs = {}

AddEventHandler("jobs:getJobs", function ()
	local mysource = source
	jobs = {}
	MySQL.Async.fetchAll("SELECT price, i1.`id` AS raw_id, i1.`libelle` AS raw_item, i2.`id` AS treat_id, i2.`libelle` AS treat_item, p1.x AS fx, p1.y AS fy, p1.z AS fz, p2.x AS tx, p2.y AS ty, p2.z AS tz, p3.x AS sx, p3.y AS sy, p3.z AS sz FROM recolt LEFT JOIN items i1 ON recolt.`raw_id`=i1.id LEFT JOIN items i2 ON recolt.`treated_id`=i2.id LEFT JOIN coordinates p1 ON recolt.`field_id`=p1.id LEFT JOIN coordinates p2 ON recolt.`treatment_id`=p2.id LEFT JOIN coordinates p3 ON recolt.`seller_id`=p3.id", nil,
		function(result)
			if (result) then
				jobs = result
			end
			TriggerClientEvent("cli:getJobs", mysource, jobs)
		end)
end)

RegisterServerEvent('recolt:stestcop')
AddEventHandler('recolt:stestcop', function()
	getPoliceInService( function(nbPolicier)
		nbPolice = nbPolicier
	end)
	TriggerClientEvent('recolt:getcop',-1,nbPolice)
end)

function getPoliceInService(cb)
	TriggerEvent('es:getPlayers', function(players)
		local nbPolicier = 0
		for i,p in pairs(players) do
			local test = p.getSessionVar('policeInService')
			--print(test)
			if test == true then
				nbPolicier = nbPolicier + 1
			end
		end
		cb(nbPolicier)
	end)
end
