PlayerHero = {}

require 'lua.grindcore.hero_selection.tavern'
local list = require 'lua.grindcore.hero_selection.list'

local keys = { { 'Q', ConvertOsKeyType(0x51) } }

HERO_ATTRIBUTE_STR = ConvertHeroAttribute(1)
HERO_ATTRIBUTE_INT = ConvertHeroAttribute(2)
HERO_ATTRIBUTE_AGI = ConvertHeroAttribute(3)
UNIT_IF_STRENGTH_BASE = ConvertUnitIntegerField(1969843828)
UNIT_IF_AGILITY_BASE = ConvertUnitIntegerField(1970500722)
UNIT_IF_INTELLIGENCE_BASE = ConvertUnitIntegerField(1969317737)
UNIT_RF_STRENGTH_PER_LEVEL = ConvertUnitRealField(1970500720)
UNIT_RF_AGILITY_PER_LEVEL = ConvertUnitRealField(1969317744)
UNIT_RF_INTELLIGENCE_PER_LEVEL = ConvertUnitRealField(1969843824)
UNIT_IF_GOLD_COST = ConvertUnitIntegerField(1969713004)
UNIT_IF_FOOD_USED = ConvertUnitIntegerField(1969647471)
UNIT_IF_LUMBER_COST = ConvertUnitIntegerField(1970042221)

---@param name string
---@param primary boolean
local function attr(name, primary)
    return primary and '|cffffcc00' .. name .. '|r' or name
end

for _, id in pairs(list) do
    local index = 1;

    local name = GetUnitBaseNameById(id)

    SetUnitBaseTipById(id, name .. ' (|cffffcc00' .. keys[index][1] .. '|r)')
    SetUnitBaseHotkeyById(id, keys[index][2])

    local ps = GetUnitBasePrimaryStatById(id);

    local ubertip = ''
            .. attr('СИЛ', ps == HERO_ATTRIBUTE_STR) .. ': '
            .. GetUnitBaseIntegerFieldById(id, UNIT_IF_STRENGTH_BASE) .. ' + '
            .. ('%.1f'):format(GetUnitBaseRealFieldById(id, UNIT_RF_STRENGTH_PER_LEVEL))
            .. '|n'
            .. attr('ЛОВ', ps == HERO_ATTRIBUTE_AGI) .. ': '
            .. GetUnitBaseIntegerFieldById(id, UNIT_IF_AGILITY_BASE) .. ' + '
            .. ('%.1f'):format(GetUnitBaseRealFieldById(id, UNIT_RF_AGILITY_PER_LEVEL))
            .. '|n'
            .. attr('ИНТ', ps == HERO_ATTRIBUTE_INT) .. ': '
            .. GetUnitBaseIntegerFieldById(id, UNIT_IF_INTELLIGENCE_BASE) .. ' + '
            .. ('%.1f'):format(GetUnitBaseRealFieldById(id, UNIT_RF_INTELLIGENCE_PER_LEVEL))
            .. '|n'

    SetUnitBaseUberTipById(id, ubertip)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_GOLD_COST, 0)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_LUMBER_COST, 0)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_FOOD_USED, 0)


end

local r = CreateRegion()
RegionAddRect(r, GetWorldBounds())

local t = CreateTrigger()
TriggerRegisterEnterRegion(t, r, nil)
TriggerAddAction(t, function()
    local u = GetTriggerUnit()
    local p = GetOwningPlayer(u)
    local pid = GetPlayerId(p)

    if GetPlayerController(p) ~= MAP_CONTROL_USER or not IsUnitType(u, UNIT_TYPE_HERO) or PlayerHero[pid] ~= nil then
        return
    end

    PlayerHero[pid] = u;
    SetHeroLevel(u, 10, true)
    --SelectHeroSkill(u, FourCC('Shod'))

    SetUnitX(u, 0)
    SetUnitY(u, 0)
    SetUnitFacingInstant(u, 270)

    local a = GetUnitAbilityByIndex(u, 0);
    print(Id2String(GetAbilityTypeId(a)))





    if (GetLocalPlayer() == p) then
        ClearSelection()
        SelectUnit(u, true)
        PanCameraToTimed(GetUnitX(u), GetUnitY(u), 0)
    end
end)