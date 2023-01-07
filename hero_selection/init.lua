PlayerHero = {}

require 'lua.grindcore.hero_selection.tavern'

local list = { FourCC('Uktl') }
local udata = {
    { 'Q', OSKEY_Q },
    { 'W', OSKEY_W },
    { 'E', OSKEY_E },
    { 'R', OSKEY_R },
}

local adata = {
    { 'Q', OSKEY_Q, 852135 },
    { 'W', OSKEY_W, 852137 },
    { 'E', OSKEY_E, 852577 },
    { 'R', OSKEY_R, 852579 },
}

---@param name string
---@param primary boolean
local function attr(name, primary)
    return primary and '|cffffcc00' .. name .. '|r' or name
end

for _, id in pairs(list) do
    local index = 1;

    local name = GetUnitBaseNameById(id)

    SetUnitBaseTipById(id, name .. ' (|cffffcc00' .. udata[index][1] .. '|r)')
    SetUnitBaseHotkeyById(id, udata[index][2])

    local ps = GetUnitBasePrimaryStatById(id);

    local ubertip = '|cff808080Характеристики:|r|n'
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
            .. '|n|n|cff808080Cпособности:|r|n'

    local abs = GetUnitBaseStringFieldById(id, UNIT_SF_HERO_ABILITY_LIST)
    print(abs)
    print('---')

    local i = 0;
    for s in abs:gmatch('[^,]+') do
        i = i + 1
        local data = adata[i]
        local aid = FourCC(s)
        print(aid, ' ', s)

        AbilityOrderId[aid] = data[3]

        SetAbilityBaseHotkeyById(aid, data[2])
        --SetAbilityBaseResearchHotkeyById(aid, data[2])

        --[[
        SetAbilityBaseIntegerFieldById(aid, ABILITY_IF_BUTTON_POSITION_NORMAL_X, i - 1)
        SetAbilityBaseIntegerFieldById(aid, ABILITY_IF_BUTTON_POSITION_RESEARCH_X, i - 1)
        SetAbilityBaseIntegerFieldById(aid, ABILITY_IF_BUTTON_POSITION_NORMAL_Y, 2)
        SetAbilityBaseIntegerFieldById(aid, ABILITY_IF_BUTTON_POSITION_RESEARCH_Y, 0)
        --]]

        --local levels = GetAbilityBaseIntegerFieldById(aid, ABILITY_IF_LEVELS)
        --print(aid)
        --for k = 0, k < levels, 1 do
        --SetAbilityBaseIntegerFieldById()
        --end

        --print(s)
        --print(GetAbilityBaseStringFieldById(aid, ABILITY_SF_NAME))
        --print()
    end

    SetUnitBaseUberTipById(id, ubertip)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_GOLD_COST, 0)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_LUMBER_COST, 0)
    SetUnitBaseIntegerFieldById(id, UNIT_IF_FOOD_USED, 0)

end


-- Entire GetWorldBounds
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

    SelectHeroSkill(u, FourCC('Shod'))
    SelectHeroSkill(u, FourCC('A000'))

    SetUnitX(u, 0)
    SetUnitY(u, 0)
    SetUnitFacingInstant(u, 270)

    if (GetLocalPlayer() == p) then
        ClearSelection()
        SelectUnit(u, true)
        PanCameraToTimed(GetUnitX(u), GetUnitY(u), 0)
    end
end)