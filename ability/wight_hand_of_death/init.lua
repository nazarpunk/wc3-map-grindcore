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
    local ux, uy = GetUnitX(u), GetUnitY(u)
    local p = GetOwningPlayer(u)
    local pid = GetPlayerId(p)
    local t = PlayerMouseWorld[pid]
    local ex, ey = t[1], t[2];
    local e = AddSpecialEffect('Units\\Wight\\HandOfDeath.mdx', ex, ey)

    local a = math.atan(ey - uy, ex - ux)
    SetSpecialEffectYaw(e, a * bj_RADTODEG)

    DestroyEffect(e)
end)