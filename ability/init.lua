require 'lua.grindcore.ability.wight_hand_of_death'

local trig = CreateTrigger()
for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1 do
    TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_HERO_SKILL, nil)
end

local order = {
    [FourCC('Shod')] = 852529, -- absorb
    [FourCC('A000')] = 852662, -- acidbomb
}

TriggerAddAction(trig, function()
    local u = GetTriggerUnit()
    local aid = GetLearnedSkill()

    local i = 0
    while true do
        local a = GetUnitAbilityByIndex(u, i);
        if a == nil then
            break
        end
        if aid == GetAbilityTypeId(a) and order[aid] ~= nil then
            print('catcha')
            SetAbilityOrderId(a, order[aid])
            break
        end
        i = i + 1
    end
end)
