searchPlayer = function(player)
    if Config.inventory == 'ox' then
        exports.ox_inventory:openNearbyInventory()
    elseif Config.inventory == 'qs' or Config.inventory == 'qb' then
        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', GetPlayerServerId(player))
    end
end

exports('searchPlayer', searchPlayer)


RegisterNetEvent('jaga-gangmenu:inVoertuigSteken')
AddEventHandler('jaga-gangmenu:inVoertuigSteken', function()

    --get the player
    local player = QBCore.Functions.GetPlayerData()
    
    --get the vehicle entity
    local veh = getClosestVehicleFromPedPos(PlayerPedId(), 4, 3)

    -- check's if vehicle exist
    if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
        --get the network ID of the vehicle && triggers the event if network ID is found
        local vehicleNetId = NetworkGetNetworkIdFromEntity(veh)
        local netId = VehToNet(vehicle)

        -- send's the repairVehicle event, if the networkNetId is found. 
        if vehicleNetId then
            
            --get the vehicle entity
            local seats = GetVehicleMaxNumberOfPassengers(veh)
            local seatToPutIn = -1  -- Start with an invalid seat index
        
            for i = -1, seats - 1 do
                if IsVehicleSeatFree(veh, i) then
                    seatToPutIn = i  -- Set the seat index to the first available seat
                    break
                end
            end
            local myPed = PlayerPedId()
            local newIgnoreList = {myPed}
            local coords = GetEntityCoords(myPed)
            
            local targetPlayerId, distance = QBCore.Functions.GetClosestPlayer()
            local targetId = -10 -- -10 omdat een id nooit -10 kan zijn, en zo kunnen we zien of er iemand gevonden is in de buurt
            --targetId = GetPlayerServerId(PlayerId()) --REMOVE AFTER TESTING
            if targetPlayerId ~= -1 and distance < 3 then
                targetId = GetPlayerServerId(targetPlayerId)
                print(GetPlayerServerId(targetPlayerId))
            end
            print("Player ID: " .. targetId .. ", ped: " .. GetPlayerPed(targetId) .. " My ped: "..PlayerPedId().. " veh: " ..netId) -- Add this line for debugging
            if targetId ~= -10 then
                print("in auto server event")
                TriggerServerEvent('jaga-gangmenu:server:PutPlayerInVehicle', targetId, netId, seatToPutIn)
                --TaskWarpPedIntoVehicle(PlayerPedId(), veh, seatToPutIn+1)
            else 
                print("no player near you!")
            end
        end
    end
end)

RegisterNetEvent('jaga-gangmenu:client:inVoertuigGestoken')
AddEventHandler('jaga-gangmenu:client:inVoertuigGestoken', function(playerId, netId, seat)

    local vehicle = NetToVeh(netId)
    TaskWarpPedIntoVehicle(GetPlayerPed(playerId), vehicle, seat)

end)
