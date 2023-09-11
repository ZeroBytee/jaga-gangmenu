searchPlayer = function(player)
    if Config.inventory == 'ox' then
        exports.ox_inventory:openNearbyInventory()
    elseif Config.inventory == 'qs' or Config.inventory == 'qb' then
        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', GetPlayerServerId(player))
    end
end

exports('searchPlayer', searchPlayer)

