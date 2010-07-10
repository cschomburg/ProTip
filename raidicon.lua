--[[############
	raidicon
#############]]--

--[[	Provides:
*shows a Raidicon on mouseover if existant
]]--

local addon, ns = ...
local config = ns.config.raidIcon
if not config then return end

local ricon = GameTooltip:CreateTexture("GameTooltipRaidIcon", "OVERLAY")
ricon:SetSize(config.width, config.height)
ricon:SetPoint(unpack(config.point))

GameTooltip:HookScript("OnHide", function(self)
	ricon:SetTexture(nil)
end)

GameTooltip:HookScript("OnTooltipSetunit", function(self)
	local _, unit = self:GetUnit()
	if not unit or not UnitExists(unit) then return end
	
	local raidIndex = GetRaidTargetIndex(unit)
	if raidIndex then
		ricon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidIndex)
	end
end)
