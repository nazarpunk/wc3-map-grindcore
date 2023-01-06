require 'lua.grindcore.ability.wight_hand_of_death'

local trig = CreateTrigger()
for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1 do
    TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_HERO_SKILL, nil)
end

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
