--[[#############
	healthbar
##############]]--

--[[	Provides:
*Sleek Statusbar
]]--

local addon, ns = ...
local config = ns.config.healthbar
if not config then return end

GameTooltip:HookScript("OnTooltipSetunit", function(self)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("BOTTOMLEFT", 5, 4)
	GameTooltipStatusBar:SetPoint("BOTTOMRIGHT", -5, 4)
	GameTooltipStatusBar:SetStatusBarTexture(config.texture)
	GameTooltipStatusBar:SetStatusBarColor(unpack(config.color))
	GameTooltipStatusBar:SetHeight(config.height)
	
	--Background for our bar
	if not GameTooltipStatusBar.bg then
		local bg = GameTooltipStatusBar:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints(GameTooltipStatusBar)
		bg:SetTexture(config.texture)
		bg:SetVertexColor(unpack(config.bgColor))
	end	
end)
