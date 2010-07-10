--[[###########
	Colors
############]]--

--[[	Provides:
*ClassColored/FactionBarColored Names, border
*Itemqualitycolor
*Support for ManyItemTooltips
]]--

local addon, ns = ...
local config = ns.config.colors
if not config then return end

-- Color the names in Class/reactionColor
local Real_GameTooltip_UnitColor = GameTooltip_UnitColor
function GameTooltip_UnitColor(unit)
	if UnitIsPlayer(unit) then 
		local color = RAID_CLASS_COLORS[select(2,UnitClass(unit))]
		return color.r, color.g, color.b
	elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or not UnitIsConnected(unit) or UnitIsDead(unit) then
		local color = {r = 0.6, g = 0.6, b = 0.6}
		return color.r, color.g, color.b
	elseif not isPlayerOrPet then
		local color = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
		return color.r, color.g, color.b
	else
		return Real_GameTooltip_UnitColor(unit)
	end
end

-- Backdrop
local backdrop = config.backdrop

-- Colors the Tooltipborder based on ItemQuality
local function Qcolor(self)
	local _, link = self:GetItem()
	local quality = link and select(3, GetItemInfo(link))
	if quality then
		local r, g, b = GetItemQualityColor(quality)
		self:SetBackdropBorderColor(r, g, b)
	else
		local unit = select(2, GameTooltip:GetUnit())
		if not unit then return end
		local color
		if UnitIsPlayer(unit) then
			color = RAID_CLASS_COLORS[select(2,UnitClass(unit))] or config.border
		else
			color = FACTION_BAR_COLORS[UnitReaction(unit, "player")] or config.border
		end
		self:SetBackdropBorderColor(color.r, color.g, color.b)
	end
	self:SetBackdropColor(0, 0, 0)
end

-- ManyItemTooltips support
local loaded = LoadAddOn("ManyItemTooltips")
if loaded then
	MIT:AddHook("ProTip2", "OnShow", function(self) 
		self:SetBackdrop(backdrop)
	end)
	MIT:AddHook("ProTip", "OnShow", Qcolor)
end

-- modifies our tooltips of choice
local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	ShoppingTooltip3,
}

for i=1, #tooltips do
	--hookScript(tooltips[i], "OnShow", Qcolor)
	tooltips[i]:SetScript("OnShow", Qcolor)
	tooltips[i]:SetBackdrop(backdrop)
end
tooltips = nil
