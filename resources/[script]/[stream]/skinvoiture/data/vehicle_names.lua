-- 	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
-- end
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	-- POLICE2
	AddTextEntry('0x9F05F101', 'Police11')
	-- POLICE2
	AddTextEntry('0x9F05F101', 'Police12')
	-- POLICE3
	AddTextEntry('0x71FA16EA', 'Police13')
	-- POLICE4
	AddTextEntry('0x8A63C7B9', 'Police14')
	-- POLICE5
	AddTextEntry('0x9C32EB57', 'Police15')
	
	AddTextEntry('Policebike', 'Policebike')
	
	AddTextEntry('beetle74', 'beetle74')
	-- POLICE6
	AddTextEntry('0xB2FF98F0', 'Police6')
	-- POLICE7
	AddTextEntry('0xC4B53C5B', 'Police7')
	-- POLICE8
	AddTextEntry('0xD0AF544F', 'Police8')
end)
