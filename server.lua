local activated = {} -- [source] = true/false
local running = false

local function anyActive()
    for _, v in pairs(activated) do
        if v then return true end
    end
    return false
end

local function startThreadIfNeeded()
    if running then return end
    running = true

    CreateThread(function()
        while anyActive() do
            Wait((Config.UpdateInterval) * 1000)

            local Players = {}

            for _, sid in ipairs(GetPlayers()) do
                local id = tonumber(sid) or sid
                local ped = GetPlayerPed(id)
                local coords = GetEntityCoords(ped)

                Players[#Players + 1] = {
                    id = id,
                    name = GetPlayerName(id),
                    coords = { x = coords.x, y = coords.y, z = coords.z },
                    heading = GetEntityHeading(ped)
                }
            end

            for src, state in pairs(activated) do
                if state then
                    TriggerClientEvent("crazy_playerblips:syncPlayerblips", src, Players)
                end
            end
        end
        running = false
    end)
end

lib.addCommand(Config.Command.name, {
    help = Config.Command.help,
    restricted = Config.Command.allowedGroups
}, function(source, args, raw)
    activated[source] = not activated[source]
    if activated[source] then
        startThreadIfNeeded()
        -- notification here if you want a notification if you toggle the blips
    else
        -- notification here if you want a notification if you toggle the blips
    end
end)