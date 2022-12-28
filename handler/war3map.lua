local gameUi = GetOriginFrame(ORIGIN_FRAME_GAME_UI, 0)
local menu = CreateFrame('LoadingPlayerSlot', gameUi, 0, 0)
SetFrameSize(menu, .16, .03)
SetFrameRelativePoint(menu, ConvertFramePointType(7), gameUi, ConvertFramePointType(7), 0, 0.16)
--SetFrameRelativePoint(menu, FRAMEPOINT_BOTTOM, gameUI, FRAMEPOINT_BOTTOM, 0, 0.16)

local left = GetFrameByName('LoadingPlayerSlotName', 0)
local right = GetFrameByName('LoadingPlayerSlotRace', 0)
--SetFrameVisible(GetFrameByName('LoadingPlayerSlotReadyHighlight', 0), true)

local seconds = 0
local period = .25

TimerStart(CreateTimer(), period, true, function()
    seconds = seconds + period;
    SetFrameText(left, tostring(GetHandleCount()))
    SetFrameText(right, tostring(math.floor(seconds)))
end)
