ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('t-contract:getVehicle')
AddEventHandler('t-contract:getVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local closestPlayer, playerDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and playerDistance <= 3.0 then
		local vehicle = ESX.Game.GetClosestVehicle(coords)
		local vehiclecoords = GetEntityCoords(vehicle)
		local vehDistance = GetDistanceBetweenCoords(coords, vehiclecoords, true)
		if DoesEntityExist(vehicle) and (vehDistance <= 3) then
			local vehProps = ESX.Game.GetVehicleProperties(vehicle)
                        lib.notify(source, {
                            description = 'Kaupat aloitettu!',
                            position = 'center-right',
                            icon = 'user-secret',
                            type = 'success'
                       })
			TriggerServerEvent('esx_clothes:sellVehicle', GetPlayerServerId(closestPlayer), vehProps.plate)
		else
                        lib.notify(source, {
                            description = 'Ei pelaajia lähettyvillä!',
                            position = 'center-right',
                            icon = 'user-secret',
                            type = 'error'
                       })
		end
	else
                lib.notify(source, {
                    description = 'Ei pelaajia lähettyvillä!',
                    position = 'center-right',
                    icon = 'user-secret',
                    type = 'error'
                  })
	end
	
end)

RegisterNetEvent('t-contract:animaatio')
AddEventHandler('t-contract:animaatio', function(player)
	loadAnimDict('anim@amb@nightclub@peds@')
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, false)
	Citizen.Wait(20000)
	ClearPedTasks(PlayerPedId())
end)


function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end