local trig = CreateTrigger()
local id = FourCC('Shod')

for i = 0, bj_MAX_PLAYER_SLOTS - 1, 1
do
    TriggerRegisterPlayerUnitEvent(trig, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, nil)
end
TriggerAddCondition(trig, Condition(function()
    return GetSpellAbilityId() == id
end))
TriggerAddAction(trig, function()
    local u = GetTriggerUnit()
    local p = GetOwningPlayer(u)
    local pid = GetPlayerId(p)

    local m = PlayerMouseWorld[pid];

    DestroyEffect(AddSpecialEffect('Units\\Wight\\HandOfDeath.mdx', m[1], m[2]))
end)