require 'lua.grindcore.ability.wight_hand_of_death'

PlayerMouse = {}

EVENT_PLAYER_MOUSE_MOVE = ConvertPlayerEvent(307) ---@type playerevent

local trig = CreateTrigger()
for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1 do
    local p = Player(0)
    PlayerMouse[i] = { 0, 0, 0 }
    TriggerRegisterPlayerEvent(trig, p, EVENT_PLAYER_MOUSE_MOVE)
end

TriggerAddAction(trig, function()
    PlayerMouse[GetPlayerId(GetTriggerPlayer())] = {
        GetTriggerPlayerMouseWorldX(),
        GetTriggerPlayerMouseWorldY(),
        GetTriggerPlayerMouseWorldZ()
    };
end)

