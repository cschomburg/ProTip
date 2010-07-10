local function hide(self)
	if UnitAffectingCombat('player') then
		GameTooltip:Hide()
	end
end

local addon = CreateFrame("Frame", nil, UIParent)  
  
addon:RegisterEvent("PLAYER_REGEN_ENABLED")  
addon:RegisterEvent("PLAYER_REGEN_DISABLED")  
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
  
addon:SetScript("OnEvent", function()  
	hooksecurefunc(GameTooltip, "SetAction", hide)
	hooksecurefunc(GameTooltip, "SetPetAction", hide)
	hooksecurefunc(GameTooltip, "SetShapeshift", hide)
end)