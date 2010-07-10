--[[#############
	healthbar
##############]]--

--[[	Provides:
*Sleek Statusbar
]]--

GameTooltip:HookScript("OnTooltipSetunit", function(self)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("BOTTOMLEFT", 5, 4)
	GameTooltipStatusBar:SetPoint("BOTTOMRIGHT", -5, 4)
	GameTooltipStatusBar:SetStatusBarTexture("Interface\\AddOns\\ProTip\\media\\statusbar")
	GameTooltipStatusBar:SetStatusBarColor(0.3, 0.9, 0.3, 1)
	GameTooltipStatusBar:SetHeight(2)
	
	--Background for our bar
	if not GameTooltipStatusBar.bg then
		local bg = GameTooltipStatusBar:CreateTexture(nil, "BACKGROUND")
		bg:SetAllPoints(GameTooltipStatusBar)
		bg:SetTexture("Interface\\AddOns\\ProTip\\media\\statusbar")
		bg:SetVertexColor(0.4, 0.4, 0.4, 0.4)
	end	
end)