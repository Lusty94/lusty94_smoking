local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local TargetType = Config.CoreSettings.Target.Type
local NotifyType = Config.CoreSettings.Notify.Type
local busy = false

--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_Smoking: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Smoking" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    end
end

--blips
CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.useblip then
            v.blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(v.blip, v.id)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, v.scale)
            SetBlipColour(v.blip, v.colour)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.title)
            EndTextCommandSetBlipName(v.blip)
        end
    end
end)




--use smoking item
function useSmokingItems(itemName)
    local playerPed = PlayerPedId()
    local item = Config.Consumables[itemName]
    if item.returnItem == true then
        TriggerServerEvent('lusty94_smoking:server:returnItems', item.returned, item.amountReturned)
    end
    if item.stress > 0 then
        TriggerServerEvent('hud:server:RelieveStress', item.stress)
    end
    if item.armour > 0 then
        SetPedArmour(playerPed, GetPedArmour(playerPed) + item.armour)
    end
    if item.damageHealth > 0 then
        SetEntityHealth(playerPed, GetEntityHealth(playerPed) - item.damageHealth)
    end
    if itemName == 'vape' then -- if changing vape item name make sure to change it here also
        TriggerServerEvent('lusty94_smoking:server:UseVapeJuice') -- triggers chance to remove vape juice on use
    else
        TriggerServerEvent('lusty94_smoking:server:UseItem', itemName) -- normal item removal
    end
    Wait(500) -- wait timer just to stop the rats that try spam items or remove them from inventory before declaring busy as false and unlocking inventory again
    busy = false
    LockInventory(false)
end

--use smoking item
RegisterNetEvent('lusty94_smoking:client:UseItem', function(itemName)
    local item = Config.Consumables[itemName] 
    if not item then return end
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:server:hasItem', function(hasItem)
            if hasItem then
                busy = true
                LockInventory(true)
                if lib.progressCircle({
                    duration = item.duration * 1000,
                    label = item.label,
                    position = 'bottom',
                    canCancel = true,
                    disable = {
                        move = false,
                        car = false,
                        combat = false,
                    },
                    anim = {
                        dict = item.dict,
                        clip = item.anim,
                        flag = item.flag,
                    },
                    prop = {
                    
                        model = item.prop,
                        bone = item.bone,
                        pos = item.pos,
                        rot = item.rot,
                        
                    },
                }) 
                then
                    useSmokingItems(itemName)
                else
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2500)
                end
            end
        end, itemName)
    end
end)




--open smoking shop
function openSmokingShop()
    if InvType == 'qb'then
		TriggerServerEvent('lusty94_smoking:server:openShop')
	elseif InvType == 'ox' then
		exports.ox_inventory:openInventory('shop', { type = 'smokingShop' })
	end
end


--target shop
CreateThread(function()
    if Config.UseTargetShop then
        for k,v in pairs(Config.InteractionLocations) do
            if TargetType == 'qb' then
                exports['qb-target']:AddBoxZone(v.Name, v.Coords, v.Width, v.Height, 
                    { 
                        name = v.Name, 
                        heading = v.Heading, 
                        debugPoly = Config.DebugPoly, 
                        minZ = v.Coords.z - 1, 
                        maxZ = v.Coords.z + 1, 
                    }, 
                    { options = { 
                        { 
                            type = "client", 
                            icon = v.Icon, 
                            label = v.Label,
                            action = function()
                                if not busy then
                                    openSmokingShop()
                                else
                                    SendNotify(Config.Language.Notifications.Busy, 'error', 5000)
                                end
                            end,
                        }, 
                    }, 
                    distance = v.Distance, 
                })
            elseif TargetType =='ox' then
                exports.ox_target:addBoxZone({
                    coords = v.Coords, 
                    size = v.Size, 
                    rotation = v.Heading, 
                    debug = Config.DebugPoly, 
                    options = { 
                        { 
                            id = v.Name, 
                            label = v.Label, 
                            icon = v.Icon, 
                            distance = v.Distance,
                            onSelect = function()
                                if not busy then
                                    openSmokingShop()
                                else
                                    SendNotify(Config.Language.Notifications.Busy, 'error', 5000)
                                end
                            end, 
                        }, 
                    }, 
                })
            elseif TargetType == 'custom' then
                --insert your own custom target code here
            end
        end
    end
end)


-- function to lock inventory to prevent exploits
function LockInventory(toggle)
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true)
    else 
        LocalPlayer.state:set("inv_busy", false, true)
    end
end


--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        busy = false
        LockInventory(false)
        if Config.UseTargetShop then 
            for k, v in pairs(Config.InteractionLocations) do 
                if TargetType == 'qb' then 
                    exports['qb-target']:RemoveZone(v.Name) 
                elseif TargetType == 'ox' then 
                    exports.ox_target:removeZone(v.Name) 
                end
            end
        end
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Smoking V2.1.1 Stopped Successfully ^5--<^3!^5>--^7')
	end
end)