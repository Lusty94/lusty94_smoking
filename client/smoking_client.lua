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
    if busy then
        SendNotify("You Are Already Doing Something!", 'error', 2000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:CigPacks', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.OpenPack, 
                    label = 'Opening pack of cigs...', 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = true, move = false, }, 
                    anim = { dict = 'amb@prop_human_parking_meter@female@base', clip = 'base_female', flag = 49, }, 
                    prop = { model = 'v_res_tt_cigs01', bone = 57005, pos = vec3(0.14, 0.01, -0.03), rot = vec3(2.0, 68.0, -32.0),},
                }) then
                    busy = false
                    LockInventory(false)
                    TriggerServerEvent("lusty94_smoking:server:OpenPack", itemName)
                    SendNotify("You opened a pack of cigarettes!", 'success', 2000)
                else 
                    busy = false
                    LockInventory(false)
                    SendNotify("Action Cancelled!", 'success', 2000)
                end
            else
                SendNotify("You dont have any cigarette packets to open!", 'error', 2500)
            end
        end)
    end
end)

--smoke cig
RegisterNetEvent('lusty94_smoking:client:SmokeCig', function()
    local playerPed = PlayerPedId()
    if busy then
        SendNotify("You Are Already Doing Something!", 'error', 2000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:Cigs', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.SmokeCig, 
                    label = 'Smoking cigarette...', 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = true, move = false, }, 
                    anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c', flag = 49, }, 
                    prop = { model = 'prop_cs_ciggy_01', bone = 28422, pos = vec3(0.0, 0.0, 0.0), rot = vec3(0.0, 0.0, 0.0),},
                }) then
                    TriggerServerEvent('lusty94_smoking:server:SmokeCig')
                    SendNotify("You smoked a cig!", 'success', 2000)
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
                    SendNotify("Action Cancelled!", 'success', 2000)
                end
            else
                SendNotify("You cant smoke without a cigarette or a lighter!", 'error', 2500)
            end
        end)
    end
end)


--smoke vape
RegisterNetEvent('lusty94_smoking:client:SmokeVape', function()
    local playerPed = PlayerPedId()
    if busy then
        SendNotify("You Are Already Doing Something!", 'error', 2000)
    else
        QBCore.Functions.TriggerCallback('lusty94_smoking:get:Vape', function(HasItems)  
            if HasItems then
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.SmokeVape, 
                    label = 'Smoking vape...', 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = true, move = false, }, 
                    anim = { dict = 'amb@world_human_smoking@male@male_b@base', clip = 'base', flag = 49, }, 
                    prop = { model = 'ba_prop_battle_vape_01', bone = 28422, pos = vec3(-0.029, 0.007, -0.005), rot = vec3(91.0, 270.0, -360.0),},
                }) then
                    TriggerServerEvent('lusty94_smoking:server:SmokeVape')
                    SendNotify("You smoked a vape!", 'success', 2000)
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
                    SendNotify("Action Cancelled!", 'success', 2000)
                end
            else
                SendNotify("You cant vape without juice or a vape!", 'error', 2500)
            end
        end)
    end
end)



--open smoking shop
RegisterNetEvent("lusty94_smoking:client:openShop", function()
    if InvType == 'qb'then
		TriggerServerEvent('lusty94_smoking:server:openShop')
	elseif InvType == 'ox' then
		exports.ox_inventory:openInventory('shop', { type = 'smokingShop' })
	end
end)




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
                            event = v.Event, 
                            icon = v.Icon, 
                            label = v.Label, 
                            job = v.Job, 
                            item = v.Item, 
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
                            item = v.Item, 
                            groups = v.Job, 
                            event = v.Event, 
                            label = v.Label, 
                            icon = v.Icon, 
                            distance = v.Distance, 
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
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox
        --this is the old method below
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end


--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        busy = false
        LockInventory(false)
        for k, v in pairs(Config.InteractionLocations) do if TargetType == 'qb' then exports['qb-target']:RemoveZone(v.Name) elseif TargetType == 'ox' then exports.ox_target:removeZone(v.Name) end end
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Smoking V2.0.1 Stopped Successfully ^5--<^3!^5>--^7')
	end
end)