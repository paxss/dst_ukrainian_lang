-- In order to load a custom language, you must make a .po file for that language and load it here.

--LoadPOFile("ukrainian.po", "ua")

-- More information on this process can be found here: http://forums.kleientertainment.com/index.php?/topic/10292-creating-a-translation-using-the-po-format/
_G = GLOBAL

mods = _G.rawget(_G, "mods")
if not mods then
	mods = {}
	_G.rawset(_G, "mods", mods)
end
_G.mods = mods

mods.UkrainianLang = {
	modinfo = modinfo,
	StorePath = MODROOT,

	MainPoFile = "ukrainian.po",
	SelectedLanguage = "ua",

	Z_PATRIOT = false
}

if GetModConfigData("Z_PATRIOT") then
	mods.UkrainianLang.Z_PATRIOT = true
else
	mods.UkrainianLang.Z_PATRIOT = false
end

local SelectedLanguage = "ua"

io = _G.io
STRINGS = _G.STRINGS
tonumber = _G.tonumber
tostring = _G.tostring
assert = _G.assert
rawget = _G.rawget
require = _G.require
dumptable = _G.dumptable
deepcopy = _G.deepcopy
TheSim = _G.TheSim
TheNet = _G.TheNet
package = _G.package
rawget = _G.rawget
rawset = _G.rawset

--disabling mode notificaion
_G.getmetatable(TheSim).__index.ShouldWarnModsLoaded = function() 
	return false 
end

local FontNames = {
	DEFAULTFONT = _G.DEFAULTFONT,
	DIALOGFONT = _G.DIALOGFONT,
	TITLEFONT = _G.TITLEFONT,
	UIFONT = _G.UIFONT,
	BUTTONFONT = _G.BUTTONFONT,
	HEADERFONT = _G.HEADERFONT,
	CHATFONT = _G.CHATFONT,
	CHATFONT_OUTLINE = _G.CHATFONT_OUTLINE,
	NUMBERFONT = _G.NUMBERFONT,
	TALKINGFONT = _G.TALKINGFONT,
	SMALLNUMBERFONT = _G.SMALLNUMBERFONT,
	BODYTEXTFONT = _G.BODYTEXTFONT,
	NEWFONT = rawget(_G,"NEWFONT"),
	NEWFONT_SMALL = rawget(_G,"NEWFONT_SMALL"),
	NEWFONT_OUTLINE = rawget(_G,"NEWFONT_OUTLINE"),
	NEWFONT_OUTLINE_SMALL = rawget(_G,"NEWFONT_OUTLINE_SMALL")}

    --preloading fonts and enabling them
function ApplyLocalizedFonts()
	--font names
	local LocalizedFontList = {["talkingfont"] = true,
							   ["stint-ucr50"] = true,
							   ["stint-ucr20"] = true,
							   ["opensans50"] = true,
							   ["belisaplumilla50"] = true,
							   ["belisaplumilla100"] = true,
							   ["buttonfont"] = true,
							   ["hammerhead50"] = true,
							   ["bellefair50"] = true,
							   ["bellefair_outline50"] = true,
							   ["spirequal"] = rawget(_G,"NEWFONT") and true or nil,
							   ["spirequal_small"] = rawget(_G,"NEWFONT_SMALL") and true or nil,
							   ["spirequal_outline"] = rawget(_G,"NEWFONT_OUTLINE") and true or nil,
							   ["spirequal_outline_small"] = rawget(_G,"NEWFONT_OUTLINE_SMALL") and true or nil}

    --UPLOAD STAGE: unload the fonts if they have been loaded
	--restoring original font variables
	_G.DEFAULTFONT = FontNames.DEFAULTFONT
	_G.DIALOGFONT = FontNames.DIALOGFONT
	_G.TITLEFONT = FontNames.TITLEFONT
	_G.UIFONT = FontNames.UIFONT
	_G.BUTTONFONT = FontNames.BUTTONFONT
	_G.HEADERFONT = FontNames.HEADERFONT
	_G.CHATFONT = FontNames.CHATFONT
	_G.CHATFONT_OUTLINE = FontNames.CHATFONT_OUTLINE
	_G.NUMBERFONT = FontNames.NUMBERFONT
	_G.TALKINGFONT = FontNames.TALKINGFONT
	_G.SMALLNUMBERFONT = FontNames.SMALLNUMBERFONT
	_G.BODYTEXTFONT = FontNames.BODYTEXTFONT
	if rawget(_G,"NEWFONT") then
		_G.NEWFONT = FontNames.NEWFONT
	end
	if rawget(_G,"NEWFONT_SMALL") then
		_G.NEWFONT_SMALL = FontNames.NEWFONT_SMALL
	end
	if rawget(_G,"NEWFONT_OUTLINE") then
		_G.NEWFONT_OUTLINE = FontNames.NEWFONT_OUTLINE
	end
	if rawget(_G,"NEWFONT_OUTLINE_SMALL") then
		_G.NEWFONT_OUTLINE_SMALL = FontNames.NEWFONT_OUTLINE_SMALL
	end

	--unloading localized fonts if they have been loaded before
	for FontName in pairs(LocalizedFontList) do
		TheSim:UnloadFont(SelectedLanguage.."_"..FontName)
	end
	TheSim:UnloadPrefabs({SelectedLanguage.."_fonts_"..modname}) --unload common prefab of localized fonts


	--LOADING STAGE: loading fonts again

	--asset list
	local LocalizedFontAssets = {}
	for FontName in pairs(LocalizedFontList) do 
		table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/"..FontName.."__"..SelectedLanguage..".zip"))
	end

	--creating prefab, then loading it
	local LocalizedFontsPrefab = _G.Prefab("common/"..SelectedLanguage.."_fonts_"..modname, nil, LocalizedFontAssets)
	_G.RegisterPrefabs(LocalizedFontsPrefab)
	TheSim:LoadPrefabs({SelectedLanguage.."_fonts_"..modname})

	--forming a list of aliases associated with files
	for FontName in pairs(LocalizedFontList) do
		TheSim:LoadFont(MODROOT.."fonts/"..FontName.."__"..SelectedLanguage..".zip", SelectedLanguage.."_"..FontName)
	end

	--table of fallbacks for the subsequent connection of fonts with additional fonts
	local fallbacks = {}
	for _, v in pairs(_G.FONTS) do
		local FontName = v.filename:sub(7, -5)
		if LocalizedFontList[FontName] then
			fallbacks[FontName] = {v.alias, _G.unpack(type(v.fallback) == "table" and v.fallback or {})}
		end
	end
	--linking localized characters to new fonts
	for FontName in pairs(LocalizedFontList) do
		TheSim:SetupFontFallbacks(SelectedLanguage.."_"..FontName, fallbacks[FontName])
	end

	--enter our aliases into the global font variables
	_G.DEFAULTFONT = SelectedLanguage.."_opensans50"
	_G.DIALOGFONT = SelectedLanguage.."_opensans50"
	_G.TITLEFONT = SelectedLanguage.."_belisaplumilla100"
	_G.UIFONT = SelectedLanguage.."_belisaplumilla50"
	_G.BUTTONFONT = SelectedLanguage.."_buttonfont"
	_G.HEADERFONT = SelectedLanguage.."_hammerhead50"
	_G.CHATFONT = SelectedLanguage.."_bellefair50"
	_G.CHATFONT_OUTLINE = SelectedLanguage.."_bellefair_outline50"
	_G.NUMBERFONT = SelectedLanguage.."_stint-ucr50"
	_G.TALKINGFONT = SelectedLanguage.."_talkingfont"
	_G.SMALLNUMBERFONT = SelectedLanguage.."_stint-ucr20"
	_G.BODYTEXTFONT = SelectedLanguage.."_stint-ucr50"
	if rawget(_G,"NEWFONT") then
		_G.NEWFONT = SelectedLanguage.."_spirequal"
	end
	if rawget(_G,"NEWFONT_SMALL") then
		_G.NEWFONT_SMALL = SelectedLanguage.."_spirequal_small"
	end
	if rawget(_G,"NEWFONT_OUTLINE") then
		_G.NEWFONT_OUTLINE = SelectedLanguage.."_spirequal_outline"
	end
	if rawget(_G,"NEWFONT_OUTLINE_SMALL") then
		_G.NEWFONT_OUTLINE_SMALL = SelectedLanguage.."_spirequal_outline_small"
	end
end

--insert a function that connects fonts
local OldRegisterPrefabs = _G.ModManager.RegisterPrefabs --replac the function in which you need to load fonts and fix global font constants
local function NewRegisterPrefabs(self)
	OldRegisterPrefabs(self)
	ApplyLocalizedFonts()
	_G.TheFrontEnd.consoletext:SetFont(_G.BODYTEXTFONT) --console font fix
	_G.TheFrontEnd.consoletext:SetRegionSize(900, 404) --console font size fix
end
_G.ModManager.RegisterPrefabs=NewRegisterPrefabs

modimport("scripts/main.lua")