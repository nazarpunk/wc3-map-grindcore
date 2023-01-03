PlayerHero = {}

require 'lua.grindcore.hero_selection.tavern'
local list = require 'lua.grindcore.hero_selection.list'

local keys = { { 'Q', ConvertOsKeyType(0x51) } }

HERO_ATTRIBUTE_STR = ConvertHeroAttribute(1)
HERO_ATTRIBUTE_INT = ConvertHeroAttribute(2)
HERO_ATTRIBUTE_AGI = ConvertHeroAttribute(3)

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
            .. '|n'
            .. attr('ЛОВ', ps == HERO_ATTRIBUTE_AGI) .. ': '
            .. '|n'
            .. attr('ИНТ', ps == HERO_ATTRIBUTE_INT) .. ': '

    SetUnitBaseUberTipById(id, ubertip)
    SetUnitBaseGoldCostById(id, 0)

end

-- GetPlayableMapRect

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
    SetHeroLevel(u,10,true)
    SelectHeroSkill( u, FourCC('Shod'))


    if (GetLocalPlayer() == p) then
        ClearSelection()
        SelectUnit(u, true)
        PanCameraToTimed(GetUnitX(u), GetUnitY(u), 0)
    end
end)
