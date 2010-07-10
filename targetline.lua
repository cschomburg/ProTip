--[[##############
	targetline
###############]]--

--[[	Provides:
*display of target of mouseovertarget
]]--
local addon, ns = ...
local config = ns.config.targetline
if not config then return end

local tip = CreateFrame("Frame")

-- ClassColors
local function ClassColors(class)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	local _, class = UnitClass(unit.."target")
	local color
	if IsAddOnLoaded("!ClassColors") then
		color = CUSTOM_CLASS_COLORS[class]
	else
		color = RAID_CLASS_COLORS[class]
	end
	return ("|cff%.2x%.2x%.2x"):format(color.r*255,color.g*255,color.b*255)
end

local activetl
local updateTime = 0
tip:SetScript("OnUpdate", function(self, elapsed)
	local _, unit = GameTooltip:GetUnit()
	if not unit then return end

	updateTime = updateTime - elapsed
	if(updateTime > 0) then return end
	updateTime = 0.1

	unit = unit.."target"

	if not UnitExists(unit) then
		_G["GameTooltipTextRight1"]:Hide()
		GameTooltip:AppendText("")
		return
	end

	local text, ureaction
	if UnitIsPlayer(unit) and UnitName(unit) == UnitName("player") then
		text = "|cffffffff[YOU]"
	elseif UnitIsPlayer(unit) then
		text = ClassColors()..UnitName(unit).."|r"
	else
		ureaction = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
		if not ureaction then
			text = UnitName(unit)
		else
			text = ("|cff%02x%02x%02x%s|r"):format(ureaction.r*255, ureaction.g*255, ureaction.b*255, UnitName(unit))
		end
	end	
	
	_G["GameTooltipTextRight1"]:SetText("|cffffffff>>|r"..text)
	if UnitExists(unit) then
		if not activetl then
			_G["GameTooltipTextRight1"]:Show()
			GameTooltip:AppendText("")
			return
		end
	end
end)
