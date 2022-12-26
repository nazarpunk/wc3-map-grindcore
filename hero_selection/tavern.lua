local g = CreateGroup()

local tavern = {}
local tavs, tava, tavi = FourCC('tavs'), FourCC('tava'), FourCC('tavi')

local hsel = FourCC('hsel')

GroupEnumUnitsOfPlayer(g, Player(PLAYER_NEUTRAL_PASSIVE), Condition(function()
    local u = GetFilterUnit()
    local c = GetUnitTypeId(u)
    if c == tavs then
        tavern[1] = u;
    end
    if c == tava then
        tavern[2] = u;
    end
    if c == tavi then
        tavern[3] = u;
    end
    return false
end))

for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1
do
    local p = Player(i)
    SetPlayerTechMaxAllowed(p, FourCC('HERO'), 1)

    if GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
        for _, u in pairs(tavern) do
            local x, y = GetUnitX(u), GetUnitY(u)
            CreateUnit(p, hsel, x - (180 - i * 12), y - (i * 12), 0)
            UnitShareVision(u, p, false)
        end
    end
end

local timer = CreateTimer();
TimerStart(timer, 0, false, function()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1
    do
        local p = Player(i)
        if GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
            if p == GetLocalPlayer() then
                local t = tavern[3]
                SelectUnit(t, true)
                PanCameraToTimed(GetUnitX(t), GetUnitY(t), 0)
            end
        end
    end
end)
DestroyTimer(timer)

return tavern;