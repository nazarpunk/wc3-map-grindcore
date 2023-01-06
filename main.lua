require 'lua.ujapi.asset.ConvertTypeFix'
require 'lua.ujapi.asset.PlayerMouseMove'
require 'lua.ujapi.asset.HandleCounter'

if false then
    local u = CreateUnit(Player(0), FourCC('Uktl'), 0, 0, 0)
    local x = GetUnitX(u)
    local y = GetUnitY(u)
    SelectUnit(u, true)
    PanCameraToTimed(x, y, 0)

else
    --FogEnable(false)
    --FogMaskEnable(false)
    require 'lua.grindcore.hero_selection'
    require 'lua.grindcore.ability'
end