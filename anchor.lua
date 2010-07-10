--[[###########
	anchor
############]]--

--[[	Provides:
*Anchor settings
]]--

--[[==========
	Anchor
==========]]--
local addon, ns = ...
local config = ns.config.anchor
if not config then return end

local moAnchor = false --mouseoveranchor? true/false

if config.mouse and config.mouse.enabled then
	GameTooltip:HookScript("OnUpdate", function(self, elpased)
		if self:GetAnchorType() == "ANCHOR_CURSOR" then
			return 
		end
		local x, y = GetCursorPosition()
		local effScale = self:GetEffectiveScale()
		self:ClearAllPoints()
		self:SetPoint(config.mouse.anchor, UIParent, "BOTTOMLEFT", (x / effScale + config.mouse.offsetX), (y / effScale + config.mouse.offsetY))
	end)
end

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	if not config.mouse or not config.mouse.enabled then
		tooltip:SetOwner(parent,"ANCHOR_NONE")
		tooltip:SetPoint(unpack(config.fixed))
	end
	tooltip:SetScale(1)
	tooltip.default = 1
end)
