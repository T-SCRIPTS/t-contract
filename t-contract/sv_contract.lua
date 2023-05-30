ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('esx_clothes:sellVehicle')
AddEventHandler('esx_clothes:sellVehicle', function(target, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
		MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = plate,
			['@target'] = tPlayer.identifier
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('t-contract:animaatio', _source)
				Wait(22000)
				TriggerClientEvent('t-contract:animaatio', _target)
				Wait(22000)
                                lib.notify(source, {
                                    description = 'Myit ajoneuvo',
                                    position = 'center-right',
                                    icon = 'user-secret',
                                    type = 'error'
                                })
                                lib.notify(source, {
                                    description = 'Ostit ajoneuvon',
                                    position = 'center-right',
                                    icon = 'user-secret',
                                    type = 'inform'
                                })
				xPlayer.removeInventoryItem('trafi', 1)
			end
		end)
	else
                lib.notify(source, {
                    description = 'Ei taida olla oma auto',
                    position = 'center-right',
                    icon = 'user-secret',
                    type = 'error'
                 })
	end
end)

ESX.RegisterUsableItem('trafi', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('t-contract:getVehicle', _source)
end)