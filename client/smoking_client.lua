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


--open cig packs
RegisterNetEvent('lusty94_smoking:client:OpenPack', function(itemName)
    local label = ItemLabel(itemName)
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 5000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:CigPacks', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.OpenPack, 
                    label = 'Opening '..label, 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = false, move = false, combat = false, mouse = false, }, 
                    anim = { 
                        dict = Config.Animations.OpenCigs.AnimDict,
                        clip = Config.Animations.OpenCigs.Anim,
                        flag = Config.Animations.OpenCigs.Flag,
                    }, 
                    prop = { 
                        model = Config.Animations.OpenCigs.Prop,
                        bone = Config.Animations.OpenCigs.Bone,
                        pos = Config.Animations.OpenCigs.Pos,
                        rot = Config.Animations.OpenCigs.Rot,
                    },
                }) then
                    busy = false
                    LockInventory(false)
                    TriggerServerEvent("lusty94_smoking:server:OpenPack", itemName)
                else 
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 5000)
                end
            else
                SendNotify(Config.Language.Notifications.MissingItems, 'error', 5000)
            end
        end)
    end
end)

--smoke cig
RegisterNetEvent('lusty94_smoking:client:SmokeCig', function()
    local playerPed = PlayerPedId()
    local label = ItemLabel('cigs')
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 5000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:Cigs', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.SmokeCig, 
                    label = 'Smoking '..label, 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = false, move = false, combat = false, mouse = false, }, 
                    anim = { 
                        dict = Config.Animations.SmokeCigs.AnimDict,
                        clip = Config.Animations.SmokeCigs.Anim,
                        flag = Config.Animations.SmokeCigs.Flag,
                    }, 
                    prop = { 
                        model = Config.Animations.SmokeCigs.Prop,
                        bone = Config.Animations.SmokeCigs.Bone,
                        pos = Config.Animations.SmokeCigs.Pos,
                        rot = Config.Animations.SmokeCigs.Rot,
                    },
                }) then
                    TriggerServerEvent('lusty94_smoking:server:SmokeCig')
                    if Config.CoreSettings.Effects.RemoveHealth then
                        SetEntityHealth(playerPed, GetEntityHealth(playerPed) - Config.CoreSettings.Effects.HealthAmount)
                    end
                    if Config.CoreSettings.Effects.AddArmour then
                        AddArmourToPed(playerPed, Config.CoreSettings.Effects.ArmourAmount)
                    end
                    if Config.CoreSettings.Effects.RemoveStress then
                        TriggerServerEvent(Config.CoreSettings.EventNames.HudStatus, Config.CoreSettings.Effects.RemoveStressAmount)
                    end
                    busy = false
                    LockInventory(false)
                else 
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 5000)
                end
            else
                SendNotify(Config.Language.Notifications.NoLighter, 'error', 5000)
            end
        end)
    end
end)





--smoke vape
RegisterNetEvent('lusty94_smoking:client:SmokeVape', function()
    local playerPed = PlayerPedId()
    local label = ItemLabel('vape')
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 5000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:Vape', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.SmokeVape, 
                    label = 'Smoking '..label, 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = false, move = false, combat = false, mouse = false, }, 
                    anim = { 
                        dict = Config.Animations.SmokeVape.AnimDict,
                        clip = Config.Animations.SmokeVape.Anim,
                        flag = Config.Animations.SmokeVape.Flag,
                    }, 
                    prop = { 
                        model = Config.Animations.SmokeVape.Prop,
                        bone = Config.Animations.SmokeVape.Bone,
                        pos = Config.Animations.SmokeVape.Pos,
                        rot = Config.Animations.SmokeVape.Rot,
                    },
                }) then
                    TriggerServerEvent('lusty94_smoking:server:SmokeVape')
                    if Config.CoreSettings.Effects.AddHealth then
                        SetEntityHealth(playerPed, GetEntityHealth(playerPed) + Config.CoreSettings.Effects.VapeHealthAmount)
                    end
                    if Config.CoreSettings.Effects.AddArmour then
                        AddArmourToPed(playerPed, Config.CoreSettings.Effects.ArmourAmount)
                    end
                    if Config.CoreSettings.Effects.RemoveStress then
                        TriggerServerEvent(Config.CoreSettings.EventNames.HudStatus, Config.CoreSettings.Effects.RemoveStressAmount)
                    end
                    busy = false
                    LockInventory(false)
                else 
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 5000)
                end
            else
                SendNotify(Config.Language.Notifications.NoJuice, 'error', 5000)
            end
        end)
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

--get the label of an item for progressCircle
function ItemLabel(label)
	if InvType == 'ox' then
		local Items = exports['ox_inventory']:Items()
		return Items[label]['label']
    elseif InvType == 'qb' then
		return QBCore.Shared.Items[label]['label']
	end
end


--target settings
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
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Smoking V2.1.0 Stopped Successfully ^5--<^3!^5>--^7')
	end
end)