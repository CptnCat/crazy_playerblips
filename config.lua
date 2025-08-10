Config = {}
Config.VersionCheck = true

-- Interval in seconds between blip updates.
-- Lower values refresh more frequently but may impact server performance.
-- For larger servers, consider increasing the value.
Config.UpdateInterval = 3 -- in seconds

Config.Command = {
    name = 'ablips', -- Command name (e.g., /ablips)
    help = 'Toggle player blips on the map', -- Description shown in help
    allowedGroups = { 'group.admin', 'group.mod' }, -- Groups allowed to use the command
}

Config.Settings = {
    seeOwnBlip = false, -- Whether players can see their own blip
}