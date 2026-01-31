local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EB = E:NewModule("Ebonhold", "AceEvent-3.0")

-- Lua functions
local _G = _G
local hooksecurefunc = hooksecurefunc
local GetTime = GetTime

-- ʕ •ᴥ•ʔ✿ Apply Scale ✿ ʕ •ᴥ•ʔ
function EB:UpdateSkin()
	if not E.private.ebonhold or not E.private.ebonhold.enable then return end

	local frame = _G.ProjectEbonholdPlayerRunFrame
	-- We use the global directly since the user verified it has :SetScale
	if not frame or not frame.SetScale then return end

	local db = E.db.ebonhold
	if not db or not db.scale then return end

	-- ʕ ● ᴥ ●ʔ✿ Forced Scaling ✿ ʕ ● ᴥ ●ʔ
	if not frame.isSettingScale then
		frame.isSettingScale = true
		frame:SetScale(db.scale)
		frame.isSettingScale = nil
	end
end

-- ʕ •ᴥ•ʔ✿ Initialize Skin ✿ ʕ •ᴥ•ʔ
function EB:InitializeSkin()
	local frame = _G.ProjectEbonholdPlayerRunFrame
	
	if frame and frame.SetScale then
		-- Found it! Hook SetScale to ensure the addon doesn't override our value
		if not self.hooked then
			hooksecurefunc(frame, "SetScale", function(f, scale)
				if f.isSettingScale then return end
				local targetScale = (E.db.ebonhold and E.db.ebonhold.scale) or 1
				
				-- ʕ ✖ ᴥ ✖ʔ✿ Anti-Fight Logic ✿ ʕ ✖ ᴥ ✖ʔ
				-- If another addon keeps resetting the scale in the same frame, we stop fighting to prevent a freeze.
				local t = GetTime()
				if f.ehLast == t then
					f.ehCount = (f.ehCount or 0) + 1
				else
					f.ehLast = t
					f.ehCount = 0
				end
				if f.ehCount > 20 then return end

				if scale ~= targetScale then
					f.isSettingScale = true
					f:SetScale(targetScale)
					f.isSettingScale = nil
				end
			end)
			self.hooked = true
		end

		-- Apply initial scale
		self:UpdateSkin()
	end
end

function EB:PLAYER_ENTERING_WORLD()
	self:InitializeSkin()
	-- Try one backup check in 5 seconds for slow loaders, but NO LOOPS.
	E:Delay(5, function() self:InitializeSkin() end)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function EB:Initialize()
	if not E.private.ebonhold or not E.private.ebonhold.enable then return end
	
	-- ʕ ● ᴥ ●ʔ✿ Start the search process via Event ✿ ʕ ● ᴥ ●ʔ
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

E:RegisterModule(EB:GetName(), function() EB:Initialize() end)
