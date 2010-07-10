--[[############
	talents
#############]]--

--[[	Provides:
*Talentsdisplay
]]--

local _G = getfenv(0)

local activegroup, maintree
local function InspectTalents(inspect)
	local talents = {}
	local numLines, linesNeeded = GameTooltip:NumLines()
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	local guild, guildRankName, guildRankIndex = GetGuildInfo(unit)
	local pvp = UnitIsPVP(unit)
	
	for i=1, GetNumTalentTabs(inspect) do
		local group = GetActiveTalentGroup(inspect)
		if group == 1 then
			activegroup = "|cffddff55<|r"
		elseif group == 2 then
			activegroup = "|cFFdddd55<<|r"
		end
		talents[i] = {
			num = select(3, GetTalentTabInfo(i, inspect, nil, group)),
			name = select(1, GetTalentTabInfo(i, inspect, nil, group)),
		}
	end
	
	for i=1, 3 do
		if talents[i].num == max(talents[i].num) then
			maintree = "|cFFffcc22"..talents[i].name.."|r"
		end
	end
	
	local linetext = ("|cff00ddbb"..talents[1].num.."|r/|cff00ddbb"..talents[2].num.."|r/|cff00ddbb"..talents[3].num.."|r "..maintree.." "..activegroup)
	
	if guild and pvp then
		_G["GameTooltipTextLeft4"]:SetText(linetext)
		_G["GameTooltipTextLeft4"]:Show()
	elseif pvp and not guild then
		_G["GameTooltipTextLeft3"]:SetText(linetext)
		_G["GameTooltipTextLeft3"]:Show()
	else
		GameTooltip:AddLine(linetext)
		GameTooltip:AppendText("")
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent",function(self, event, guid)
	self:UnregisterEvent("INSPECT_TALENT_READY")
	InspectTalents(1)
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit then return end
	
	if UnitIsPlayer(unit) and (UnitLevel(unit) > 9 or UnitLevel(unit) == -1) then
		if CheckInteractDistance(unit,1) and CanInspect(unit) then
		
			f:RegisterEvent("INSPECT_TALENT_READY")
			NotifyInspect(unit)
		end
	end
end)
