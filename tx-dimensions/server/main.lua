ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

whitelistRoles = {
    "939970008245760079",
}

WorldTracker = {};
RegisterNetEvent('elite-mundos:GetWorld')
AddEventHandler('elite-mundos:GetWorld', function(src, cb)
    local ids = ExtractIdentifiers(src);
    if (WorldTracker[ids.license] ~= nil) then 
        cb(WorldTracker[ids.license]);
    end
    cb("Normal");
end)

RegisterNetEvent('elite-mundos:GetWorldBucketID')
AddEventHandler('elite-mundos:GetWorldBucketID', function(src, cb)
    local ids = ExtractIdentifiers(src);
    if (WorldTracker[ids.license] ~= nil) then 
        cb(Config.Worlds[WorldTracker[ids.license]][1]);
    end
    cb(1);
end)

ExtractIdentifiers = function(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end  
    return identifiers
end

AddEventHandler('playerDropped', function (reason) 
    local src = source;
    local ids = ExtractIdentifiers(src);
    WorldTracker[ids.license] = nil;
    local ids = ExtractIdentifiers(src);
end)

RegisterNetEvent('elite-mundos:wt_dc')
AddEventHandler('elite-mundos:wt_dc', function()
    local src = source;
    local ids = ExtractIdentifiers(src);
    if WorldTracker[ids.license] ~= nil then
        local worldName = WorldTracker[ids.license]; 
        SetPlayerRoutingBucket(src, Config.Worlds[worldName][1]);
    end
end)

RegisterNetEvent('elite-mundos:el-sw')
AddEventHandler('elite-mundos:el-sw', function(worldName)
    local src = source;
    if Config.Worlds[worldName] ~= nil then 
        local permission = Config.Worlds[worldName][3];
        local ids = ExtractIdentifiers(src);
        if not permission then 
            SetPlayerRoutingBucket(src, Config.Worlds[worldName][1]);
            WorldTracker[ids.license] = worldName;
            return;
        end
        if IsPlayerAceAllowed(src, permission) then 
            SetPlayerRoutingBucket(src, Config.Worlds[worldName][1]);
            WorldTracker[ids.license] = worldName;
        end
    end
end)

RegisterNetEvent('elite-mundos:el-sw-luis')
AddEventHandler('elite-mundos:el-sw-luis', function(worldName)
    local src = source;
    local ids = ExtractIdentifiers(src);
    if not permission then 
        SetPlayerRoutingBucket(src, worldName);
        WorldTracker[ids.license] = worldName;
        return;
    end
end)

RegisterNetEvent('elite-mundos:wlGangwars')
AddEventHandler("elite-mundos:wlGangwars", function(name, setCallback)
    local src = source
    local passAuth = false

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        usersRoles = exports.discord_perms:GetRoles(src)
        local function has_value(table, val)
            if table then
                for index, value in ipairs(table) do
                    if value == val then
                        return true
                    end
                end
            end
            return false
        end
        for index, valueReq in ipairs(whitelistRoles) do 
            if has_value(usersRoles, valueReq) then
                passAuth = true
            end
            if next(whitelistRoles,index) == nil then
                if passAuth == true then
                    TriggerClientEvent('elite-mundos:WlTrue',src)
                else
                    TriggerClientEvent('elite-mundos:WlFalse',src)
                end
            end
        end
    end
end)

RegisterServerEvent('elite-mundos:darItem')
AddEventHandler('elite-mundos:darItem', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('pistol', '1')
	xPlayer.addInventoryItem('appistol', '1')
end)