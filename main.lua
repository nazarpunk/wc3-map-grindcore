require 'ujapi.asset.ConvertTypeFix'
require 'ujapi.asset.PlayerMouseMove'
require 'ujapi.asset.HandleCounter'

if false then
    local u = CreateUnit(Player(0), FourCC('Uktl'), 0, 0, 0)
    local x = GetUnitX(u)
    local y = GetUnitY(u)
    SelectUnit(u, true)
    PanCameraToTimed(x, y, 0)

else
    --FogEnable(false)
    --FogMaskEnable(false)
    require 'lua.grindcore.ability'
    require 'lua.grindcore.hero_selection'
end