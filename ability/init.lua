require 'lua.grindcore.ability.wight_hand_of_death'

PlayerMouseWorld = {}

EVENT_PLAYER_MOUSE_MOVE = ConvertPlayerEvent(307) ---@type playerevent

local trig = CreateTrigger()
for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1 do
    PlayerMouseWorld[i] = { 0, 0, 0 }
    TriggerRegisterPlayerEvent(trig, Player(i), EVENT_PLAYER_MOUSE_MOVE)
end

TriggerAddAction(trig, function()
    PlayerMouseWorld[GetPlayerId(GetTriggerPlayer())] = {
        GetTriggerPlayerMouseWorldX(),
        GetTriggerPlayerMouseWorldY(),
        GetTriggerPlayerMouseWorldZ()
    };
end)

EVENT_PLAYER_HERO_SKILL = ConvertPlayerUnitEvent(42)

trig = CreateTrigger()
for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1 do
    TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_HERO_SKILL, nil)
end

ABILITY_SF_NAME = ConvertAbilityStringField(FourCC('anam'--[[1634623853--]])) ---@type abilitystringfield

local order = {
    [FourCC('Shod')] = 852529, -- absorb
    [FourCC('A001')] = 852662, -- acidbomb
}

TriggerAddAction(trig, function()
    local u = GetTriggerUnit()
    local aid = GetLearnedSkill()

    for i = 0, 10, 1 do
        local a = GetUnitAbilityByIndex(u, i);
        if (a ~= nil and aid == GetAbilityTypeId(a)) then
            if order[aid] ~= nil then
                SetAbilityOrderId(a, order[aid])
            end
        end
    end
end)
