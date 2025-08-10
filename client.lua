local blips = {} -- [serverId] = blip

RegisterNetEvent("crazy_playerblips:syncPlayerblips", function(players)
    if type(players) ~= "table" then return end

    local myServerId = GetPlayerServerId(PlayerId())
    local seen = {}

    for _, p in ipairs(players) do
        local sid = p.id
        if sid and (Config.Settings.seeOwnBlip or sid ~= myServerId) and p.coords then
            local blip = blips[sid]

            local target = GetPlayerFromServerId(sid)
            local ped = (target ~= -1) and GetPlayerPed(target) or 0
            local canUseEntity = (ped ~= 0) and DoesEntityExist(ped)

            if not blip or not DoesBlipExist(blip) then
                if canUseEntity then
                    blip = AddBlipForEntity(ped)
                else
                    blip = AddBlipForCoord(p.coords.x, p.coords.y, p.coords.z)
                end

                SetBlipSprite(blip, 1)
                SetBlipScale(blip, 0.85)
                SetBlipAsShortRange(blip, false)
                SetBlipCategory(blip, 7)
                ShowHeadingIndicatorOnBlip(blip, true)

                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(p.name)
                EndTextCommandSetBlipName(blip)

                blips[sid] = blip
            end

            -- Update Position/Rotation
            if not canUseEntity then
                SetBlipCoords(blip, p.coords.x, p.coords.y, p.coords.z)
                if p.heading then
                    SetBlipRotation(blip, math.floor(p.heading))
                end
            end

            seen[sid] = true
        end
    end

    -- removes playerblips with updateinterval (e.g. leave)
    for sid, blip in pairs(blips) do
        if not seen[sid] then
            if DoesBlipExist(blip) then RemoveBlip(blip) end
            blips[sid] = nil
        end
    end
end)

