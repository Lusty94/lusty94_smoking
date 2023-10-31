local QBCore = exports['qb-core']:GetCoreObject()
local ShopType = Config.CoreSettings.Shop.Type
local TargetType = Config.CoreSettings.Target.Type


--blips
CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.useblip then
            v.blip = AddBlipForCoord(v['coords'].x, v['coords'].y, v['coords'].z)
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


--prop for cig packet
local packetprop = GetHashKey('v_res_tt_cigs01')
RequestModel(packetprop)
while not HasModelLoaded(packetprop) do
    Wait(0)
    RequestModel(packetprop)
end

--open pack of cigs
RegisterNetEvent('lusty94_smoking:client:RedwoodPack', function()
    local prop = CreateObject(packetprop, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.03, 2.0, 68.0, -32.0, true, true, false, false, 1, true)
    QBCore.Functions.Progressbar("open_pack", "Opening Cigarette Pack", Config.CoreSettings.ProgressBar.OpenPack, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Opened Pack of Cigarettes!", "success", Config.CoreSettings.Notify.SuccessLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Pack Opened!', ' Opened Pack of Cigarettes!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('success', 'Opened Pack of Cigarettes!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Pack Opened!', 'Opened Pack of Cigarettes!', 'success', Config.CoreSettings.Notify.SuccessLength)
        end        
        TriggerServerEvent('lusty94_smoking:server:OpenRedwoodPack')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', 'Cancelled!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
        end
    end)
end)
RegisterNetEvent('lusty94_smoking:client:DebonairePack', function()
    local prop = CreateObject(packetprop, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.03, 2.0, 68.0, -32.0, true, true, false, false, 1, true)
    QBCore.Functions.Progressbar("open_pack", "Opening Cigarette Pack", Config.CoreSettings.ProgressBar.OpenPack, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Opened Pack of Cigarettes!", "success", Config.CoreSettings.Notify.SuccessLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Pack Opened!', ' Opened Pack of Cigarettes!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('success', 'Opened Pack of Cigarettes!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Pack Opened!', 'Opened Pack of Cigarettes!', 'success', Config.CoreSettings.Notify.SuccessLength)
        end        
        TriggerServerEvent('lusty94_smoking:server:OpenDebonairePack')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', 'Cancelled!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
        end
    end)
end)
RegisterNetEvent('lusty94_smoking:client:69BrandPack', function()
    local prop = CreateObject(packetprop, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.03, 2.0, 68.0, -32.0, true, true, false, false, 1, true)
    QBCore.Functions.Progressbar("open_pack", "Opening Cigarette Pack", Config.CoreSettings.ProgressBar.OpenPack, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Opened Pack of Cigarettes!", "success", Config.CoreSettings.Notify.SuccessLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Pack Opened!', ' Opened Pack of Cigarettes!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('success', 'Opened Pack of Cigarettes!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Pack Opened!', 'Opened Pack of Cigarettes!', 'success', Config.CoreSettings.Notify.SuccessLength)
        end        
        TriggerServerEvent('lusty94_smoking:server:Open69BrandPack')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', 'Cancelled!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
        end
    end)
end)
RegisterNetEvent('lusty94_smoking:client:YukonPack', function()
    local prop = CreateObject(packetprop, GetEntityCoords(PlayerPedId()), true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.03, 2.0, 68.0, -32.0, true, true, false, false, 1, true)
    QBCore.Functions.Progressbar("open_pack", "Opening Cigarette Pack", Config.CoreSettings.ProgressBar.OpenPack, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "amb@prop_human_parking_meter@female@base",
        anim = "base_female",
        flags = 49,
    }, {}, {}, function() -- Done
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Opened Pack of Cigarettes!", "success", Config.CoreSettings.Notify.SuccessLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Pack Opened!', ' Opened Pack of Cigarettes!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('success', 'Opened Pack of Cigarettes!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Pack Opened!', 'Opened Pack of Cigarettes!', 'success', Config.CoreSettings.Notify.SuccessLength)
        end        
        TriggerServerEvent('lusty94_smoking:server:OpenYukonPack')
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
        DeleteEntity(prop)
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', 'Cancelled!')
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
        end
    end)
end)



--prop for cig
local cigprop = GetHashKey('prop_cs_ciggy_01')
RequestModel(cigprop)
while not HasModelLoaded(cigprop) do
    Wait(0)
    RequestModel(cigprop)
end

--smoke cig
RegisterNetEvent('lusty94_smoking:client:SmokeCig', function()
    QBCore.Functions.TriggerCallback('lusty94_smoking:get:Cigs', function(HasItems)  
        if HasItems then
            local prop = CreateObject(cigprop, GetEntityCoords(PlayerPedId()), true, true, true)
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true) 
            QBCore.Functions.Progressbar("smoke_cig", "Smoking A Cigarette", Config.CoreSettings.ProgressBar.SmokeCig, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_aa_smoke@male@idle_a",
                anim = "idle_c",
                flags = 49,
            }, {}, {}, function() -- Done
                ClearPedTasks(PlayerPedId())
                DeleteEntity(prop)
                if Config.CoreSettings.Notify.Type == 'qb' then
                    QBCore.Functions.Notify("You Lit A Cigarette!", "success", Config.CoreSettings.Notify.SuccessLength)
                elseif Config.CoreSettings.Notify.Type == 'okok' then
                    exports['okokNotify']:Alert('Cigarette Lit!', ' You Lit A Cigarette!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
                elseif Config.CoreSettings.Notify.Type == 'mythic' then
                    exports['mythic_notify']:DoHudText('success', 'You Lit A Cigarette!')
                elseif Config.CoreSettings.Notify.Type == 'boii' then
                    exports['boii_ui']:notify('Cigarette Lit!', 'You Lit A Cigarette!', 'success', Config.CoreSettings.Notify.SuccessLength)
                end        
                TriggerServerEvent('lusty94_smoking:server:SmokeCig')
                    if Config.CoreSettings.Effects.RemoveHealth then
                        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - Config.CoreSettings.Effects.HealthAmount)
                    end
                    if Config.CoreSettings.Effects.AddArmour then
                        AddArmourToPed(PlayerPedId(), Config.CoreSettings.Effects.ArmourAmount)
                    end
                    if Config.CoreSettings.Effects.RemoveStress then
                        TriggerServerEvent(Config.CoreSettings.EventNames.HudStatus, Config.CoreSettings.Effects.RemoveStressAmount)
                    end
            end, function() -- Cancel
                ClearPedTasks(PlayerPedId())
                DeleteEntity(prop)
                if Config.CoreSettings.Notify.Type == 'qb' then
                    QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
                elseif Config.CoreSettings.Notify.Type == 'okok' then
                    exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
                elseif Config.CoreSettings.Notify.Type == 'mythic' then
                    exports['mythic_notify']:DoHudText('error', 'Cancelled!')
                elseif Config.CoreSettings.Notify.Type == 'boii' then
                    exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
                end
            end)
        else
            if Config.CoreSettings.Notify.Type == 'qb' then
                QBCore.Functions.Notify("You Cant Smoke Without A Lighter!", "error", Config.CoreSettings.Notify.ErrorLength)
            elseif Config.CoreSettings.Notify.Type == 'okok' then
                exports['okokNotify']:Alert('Missing Items','You Cant Smoke Without A Lighter!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.Sound) 
            elseif Config.CoreSettings.Notify.Type == 'mythic' then
                exports['mythic_notify']:DoHudText('error', 'You Cant Smoke Without A Lighter!')
            elseif Config.CoreSettings.Notify.Type == 'boii' then
                exports['boii_ui']:notify('Missing Items', 'You Cant Smoke Without A Lighter!', 'error', Config.CoreSettings.Notify.ErrorLength)
            end
        end
    end)
end)






--prop for vape
local vapeprop = GetHashKey('ba_prop_battle_vape_01')
RequestModel(vapeprop)
while not HasModelLoaded(vapeprop) do
    Wait(0)
    RequestModel(vapeprop)
end


--smoke vape
RegisterNetEvent('lusty94_smoking:client:SmokeVape', function()
    QBCore.Functions.TriggerCallback('lusty94_smoking:get:Vape', function(HasItems)  
        if HasItems then
           local prop = CreateObject(vapeprop, GetEntityCoords(PlayerPedId()), true, true, true)
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.0290, 0.0070, -0.0050, 91.0, 270.0, -360.0, true, true, false, false, 1, true)
            QBCore.Functions.Progressbar("smoke_vape", "Smoking A Vape", Config.CoreSettings.ProgressBar.SmokeVape, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@world_human_smoking@male@male_b@base",
                anim = "base",
                flags = 49,
            }, {}, {}, function() -- Done
                ClearPedTasks(PlayerPedId())
                DeleteEntity(prop)
                if Config.CoreSettings.Notify.Type == 'qb' then
                    QBCore.Functions.Notify("You Smoked A Vape!", "success", Config.CoreSettings.Notify.SuccessLength)
                elseif Config.CoreSettings.Notify.Type == 'okok' then
                    exports['okokNotify']:Alert('Vaped!', ' You Smoked A Vape!', Config.CoreSettings.Notify.SuccessLength, 'success', Config.CoreSettings.Notify.UseSound)
                elseif Config.CoreSettings.Notify.Type == 'mythic' then
                    exports['mythic_notify']:DoHudText('success', 'You Smoked A Vape!')
                elseif Config.CoreSettings.Notify.Type == 'boii' then
                    exports['boii_ui']:notify('Vaped!', 'You Smoked A Vape!', 'success', Config.CoreSettings.Notify.SuccessLength)
                end        
                TriggerServerEvent('lusty94_smoking:server:SmokeVape')
                    if Config.CoreSettings.Effects.AddHealth then
                        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + Config.CoreSettings.Effects.VapeHealthAmount)
                    end
                    if Config.CoreSettings.Effects.AddArmour then
                        AddArmourToPed(PlayerPedId(), Config.CoreSettings.Effects.ArmourAmount)
                    end
                    if Config.CoreSettings.Effects.RemoveStress then
                        TriggerServerEvent(Config.CoreSettings.EventNames.HudStatus, Config.CoreSettings.Effects.RemoveStressAmount)
                    end
            end, function() -- Cancel
                ClearPedTasks(PlayerPedId())
                DeleteEntity(prop)
                if Config.CoreSettings.Notify.Type == 'qb' then
                    QBCore.Functions.Notify("Cancelled!", "error", Config.CoreSettings.Notify.ErrorLength)
                elseif Config.CoreSettings.Notify.Type == 'okok' then
                    exports['okokNotify']:Alert('Cancelled!', ' Cancelled!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.UseSound)
                elseif Config.CoreSettings.Notify.Type == 'mythic' then
                    exports['mythic_notify']:DoHudText('error', 'Cancelled!')
                elseif Config.CoreSettings.Notify.Type == 'boii' then
                    exports['boii_ui']:notify('Cancelled!', 'Cancelled!', 'error', Config.CoreSettings.Notify.ErrorLength)
                end
            end)
       else
           if Config.CoreSettings.Notify.Type == 'qb' then
                QBCore.Functions.Notify("You Cant Vape Without Juice!", "error", Config.CoreSettings.Notify.ErrorLength)
            elseif Config.CoreSettings.Notify.Type == 'okok' then
                exports['okokNotify']:Alert('Missing Items','You Cant Vape Without Juice!', Config.CoreSettings.Notify.ErrorLength, 'error', Config.CoreSettings.Notify.Sound) 
            elseif Config.CoreSettings.Notify.Type == 'mythic' then
                exports['mythic_notify']:DoHudText('error', 'You Cant Vape Without Juice!')
            elseif Config.CoreSettings.Notify.Type == 'boii' then
                exports['boii_ui']:notify('Missing Items', 'You Cant Vape Without Juice!', 'error', Config.CoreSettings.Notify.ErrorLength)
            end
        end
    end)
end)



--open smoking shop
RegisterNetEvent("lusty94_smoking:client:openShop", function()
    if ShopType == 'qb'then
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "SmokingShop", Config.InteractionLocations.Store.Items)
	elseif ShopType == 'jim' then
		TriggerServerEvent("jim-shops:ShopOpen", "shop", "SmokingShop", Config.InteractionLocations.Store.Items)
	elseif ShopType == 'ox' then
		print('ShopType is set to "ox" make sure you have added the required snippet from the readme file to ox_inventory/data/shops.lua as the target option is now controlled by ox_inventory')
	end
end)




--target settings
if TargetType == 'qb' then
    exports['qb-target']:AddBoxZone("Store", Config.InteractionLocations.Store.Location.Location, Config.InteractionLocations.Store.Location.Height, Config.InteractionLocations.Store.Location.Width, {
        name = "Store",
        heading = Config.InteractionLocations.Store.Location.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Store.Location.MinZ,
        maxZ = Config.InteractionLocations.Store.Location.MaxZ,
    }, {
        options = {
            {
                
                event = "lusty94_smoking:client:openShop",
                label = Config.InteractionLocations.Store.Location.Label,
                icon = Config.InteractionLocations.Store.Location.Icon,
            }
        },
        distance = 1.5,
    })
elseif TargetType == 'ox'  then
    if ShopType == 'ox' then
        print('ox target disabled for smoking shop boxzone - is now handled via ox_inventory - make sure you have added the required snippet from the readme file!')
    else
        exports.ox_target:addBoxZone({
            coords = Config.InteractionLocations.Store.Location.Location,
            size = Config.InteractionLocations.Store.Location.Size,
            rotation = Config.InteractionLocations.Store.Location.Heading,
            debug = Config.DebugPoly,
            options = {
                {
                    name = 'Store',
                    event = 'lusty94_smoking:client:openShop',
                    label = Config.InteractionLocations.Store.Location.Label,
                    icon = Config.InteractionLocations.Store.Location.Icon,
                }
            }
        })
    end
end




AddEventHandler('onResourceStop', function(resourceName) if resourceName ~= GetCurrentResourceName() then return end
    if (GetCurrentResourceName() ~= resourceName) then        
        return
    end
        exports['qb-target']:RemoveZone("Store")
        print('^5--<^3!^5>-- ^7Lusty94 ^5| ^5--<^3!^5>--^5Smoking V1.2.0 Stopped Successfully^5--<^3!^5>--^7')
end)



