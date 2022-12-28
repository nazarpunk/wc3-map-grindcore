local tavern = require 'lua.grindcore.hero_selection.tavern'
local list = require 'lua.grindcore.hero_selection.list'

local keys = { { 'Q', ConvertOsKeyType(0x51) } }

for _, id in pairs(list) do
    local index = 1;

    local name = GetUnitBaseNameById(id)

    SetUnitBaseTipById(id, name .. ' (|cffffcc00' .. keys[index][1] .. '|r)')
    SetUnitBaseHotkeyById(id, keys[index][2])

    --SetUnitBaseUberTipById(id, name .. '|cffffcc00' .. keys[index][1] .. '|r')

    SetUnitBaseGoldCostById(id, 0)

    -- war3mapImported\

end
