--[[	From WoWWiki:
This parameter can be any of "HELPFUL", "HARMFUL", "PLAYER", "RAID", "CANCELABLE", "NOT_CANCELABLE". You can also specify several filters separated 
by a | or space character to chain multiple filters together (e.g. "HELPFUL|RAID" or "HELPFUL RAID" == helpful buffs that you can cast on your raid). 
By default UnitAura has "HELPFUL" as an implicit filter - you cannot get back BOTH helpful and harmful at the same time. Neither "HELPFUL" or "HARMFUL" 
have meaning for UnitBuff/UnitDebuff, and will be ignored. 
]]

-- Set the maximum auras shown. Max: 40
local maxauras = 8
-- Set the Size of the buffs
local size = 16
-- Set the x & y coordinates
local x, y = 2, -15
-- Set Filters, the available filters are above
local Filter = ""

local buff = {}
GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	for i=1, maxauras do
		local _, _, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, i, Filter)
		
		if not buff[i] then
			buff[i] = GameTooltip:CreateTexture("GameTooltipBuff", "OVERLAY")
			buff[i]:SetHeight(size)
			buff[i]:SetWidth(size)
		end
		buff[i]:SetTexture(icon)
		
		if i == 1 then
			buff[i]:SetPoint("BOTTOMLEFT", GameTooltip, x, y)
		else
			buff[i]:SetPoint("LEFT", buff[i-1], "RIGHT", 1, 0)
		end
	end
end)

GameTooltip:HookScript("OnHide", function(self)
	for i=1, maxauras do
		if buff[i] then
			buff[i]:SetTexture(nil)
		end
	end
end)