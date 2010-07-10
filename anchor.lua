--[[###########
	anchor
############]]--

--[[	Provides:
*Anchor settings
]]--

--[[==========
	Anchor
==========]]--
local moAnchor = false --mouseoveranchor? true/false

if moAnchor then
	GameTooltip:HookScript("OnUpdate", function(self, elpased)
		if self:GetAnchorType() == "ANCHOR_CURSOR" then
			return 
		end
		local x, y = GetCursorPosition()
		local effScale = self:GetEffectiveScale()
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", (x / effScale + 25), (y / effScale + -25))
	end)
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	if not moAnchor then
		tooltip:SetOwner(parent,"ANCHOR_NONE")
		tooltip:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -13, 43)
	end
	tooltip:SetScale(1)
	tooltip.default = 1
end)