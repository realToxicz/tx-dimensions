ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local display = false

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("main", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

RegisterKeyMapping("mundo", "Abrir Menu Para Cambiar De Mundo", "keyboard", "F5")

RegisterCommand("mundo", function(source, args)
    SetDisplay(not display)
end)

RegisterNUICallback("mundo0", function(data)
    SetDisplay(false)
    exports['progressBars']:startUI(5000, "Teletransportandote...")
    Citizen.Wait(5000)
    TriggerServerEvent('elite-mundos:el-sw', "w0");
    Citizen.Wait(50)
    SetEntityCoords(PlayerPedId(), 110.647, -1301.97, 29.7186, 205.968)
    Citizen.Wait(500)
end)

RegisterNUICallback("mundo1", function(data)
    TriggerServerEvent('elite-mundos:wlGangwars')
end)

RegisterNUICallback("mundo2", function(data)
    SetDisplay(false)
    exports['progressBars']:startUI(5000, "Teletransportandote...")
    Citizen.Wait(5000)
    TriggerServerEvent('elite-mundos:el-sw', "w2");
    Citizen.Wait(50)
    SetEntityCoords(PlayerPedId(), 110.647, -1301.97, 29.7186, 205.968)
    Citizen.Wait(500)
    TriggerServerEvent('elite-mundos:darItem')
end)

k = function()
	TriggerServerEvent('getSkin')
	SwitchInPlayer(PlayerPedId())
	SetEntityVisible(PlayerPedId(), true, 0)
	while GetPlayerSwitchState() ~= 12 do
		Wait(1000)
	end
	TriggerEvent('es_admin:freezePlayer', false)
	TriggerEvent('esx:restoreLoadout')
	TriggerEvent('streetlabel:changeLoadStatus', true)
	TriggerEvent('esx_voice:changeLoadStatus', true)
	TriggerEvent('esx_status:setLastStats')
	TriggerEvent('aduty:playerLoaded')
	TriggerServerEvent('esx_rack:loaded')
end

RegisterNetEvent('elite-mundos:WlTrue')
AddEventHandler('elite-mundos:WlTrue', function()
    SetDisplay(false)
    exports['progressBars']:startUI(5000, "Teletransportandote...")
    Citizen.Wait(5000)
    TriggerServerEvent('elite-mundos:el-sw', "w1");
    Citizen.Wait(50)
    SetEntityCoords(PlayerPedId(), 110.647, -1301.97, 29.7186, 205.968)
    Citizen.Wait(500)
end)

RegisterNetEvent('elite-mundos:WlFalse')
AddEventHandler('elite-mundos:WlFalse', function()
    SetDisplay(false)
    Citizen.Wait(50)
    --THERE ADD WHAT YOU WANT IF PLAYER DONT HAVE WL
end)
