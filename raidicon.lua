--[[############
	raidicon
#############]]--

--[[	Provides:
*shows a Raidicon on mouseover if existant
]]--

local ricon = GameTooltip:CreateTexture("GameTooltipRaidIcon", "OVERLAY")
ricon:SetHeight(18)
ricon:SetWidth(18)
ricon:SetPoint("TOP", "GameTooltip", "TOP", 0, 5)

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