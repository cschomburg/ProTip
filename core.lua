--[[#########
	Core
##########]]--

--[[	Provides:
*GuildColoring
*Levelcoloring
*Classification formating
*Remove Blizz' PvP tag on the tooltip, as ProTip provides it's own one
]]--

local addon, ns = ...
local config = ns.config.core
if not config then return end

local _G = getfenv(0)

GameTooltip:HookScript("OnTooltipSetunit", function(self)
	local _, unit = self:GetUnit()
	if not unit or not UnitExists(unit) then return end
	
	local name, realm = UnitName(unit)
	local reaction = UnitReaction(unit, "player")
	
	local class, race
	if UnitIsPlayer(unit) then
		race = UnitRace(unit)
		class = UnitClass(unit)
		local status
		if UnitIsAFK(unit) then
			status = CHAT_FLAG_AFK
		elseif UnitIsDND(unit) then
			status = CHAT_FLAG_DND
		elseif not UnitIsConnected(unit) then
			status = config.flagOff
		else
			status = "" 
		end
		if realm then
			name = status..name.."-"..realm
		else
			name = status..name
		end
	end
	
	local creatureType = UnitCreatureType(unit) or ""

	local level = UnitLevel(unit)
	local classif = UnitClassification(unit)
	classif = classif and config.classif[classif] or ""
	if not level or level == -1 then
		level = "|cffff0000??|r "
	else
		local diff = GetQuestDifficultyColor(level)
		level = ("|cff%02x%02x%02x%d|r"):format(diff.r*255, diff.g*255, diff.b*255, level)
	end

	local text
	if UnitIsPlayer(unit) then
		text = level.." "..race.." "..class
	else
		text = level..classif.." "..creatureType
	end
	
	local PvPColor
	if UnitIsFriend("player", unit) then
		PvPcolor = config.colorFriendly
	else
		PvPcolor = config.colorHostile
	end
	
	local numLines = GameTooltip:NumLines()	
	if UnitIsPlayer(unit) and UnitIsPVP(unit) and isInInstance ~= "pvp" and isInInstance ~= "arena" and GetZonePVPInfo() ~= "combat" then
		_G["GameTooltipTextLeft1"]:SetText(PvPcolor..config.flagPvP.." |r"..name)
	else
		_G["GameTooltipTextLeft1"]:SetText(name)
	end
	
	if UnitIsPlayer(unit) and UnitIsPVP(unit) then
		for i=2, numLines do
			if _G["GameTooltipTextLeft"..i]:GetText():find(PVP_ENABLED) then
				_G["GameTooltipTextLeft"..i]:Hide()
				GameTooltip:AppendText("")
			end
		end
	end
	
	for i=1, numLines do
		if _G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL) then
			_G["GameTooltipTextLeft"..i]:SetText(text)
		end
	end

	if UnitIsPlayer(unit) and IsInGuild() then
		local guild, guildRankName, guildRankIndex = GetGuildInfo(unit)
		for i=1, numLines do
			if _G["GameTooltipTextLeft"..i]:GetText():find("^"..GetGuildInfo("player")) then
				_G["GameTooltipTextLeft"..i]:SetText("|cff22eeee"..guild.."|r")
			end
		end
	end
end)
