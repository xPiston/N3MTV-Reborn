AddEventHandler("es:playerLoaded", function(source)
    local mysource = source
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchScalar('SELECT face FROM skin WHERE identifier = @identifier', { ['@identifier'] = identifier}, function(face)

        if tostring(face) == "NOT" or face == nil then
            print('Face i snull')
            --TriggerClientEvent("face:openface", mysource)
        else
            TriggerClientEvent("face:setFace", mysource, json.decode(face))
        end
    end)
end)

RegisterServerEvent('face:save')
AddEventHandler('face:save',function(data)
    local identifier = GetPlayerIdentifiers(source)[1]
    MySQL.Async.execute('update skin set face = @data WHERE identifier = @identifier', { 
        ['@data'] = json.encode(data),
        ['@identifier'] = identifier
    })
end)
