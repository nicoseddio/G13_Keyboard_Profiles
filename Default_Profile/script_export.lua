-- MirrorBoard script
--	Script_Version = {"1.01", "github.com/nikorokia/g13"}
-- 	Written by Nikorokia (Nico Seddio)

-- DESCRIPTION:
--	I wanted a multipurpose G13 profile that let me quickly switch
--	to a single-handed mirroring keyboard.
--	M1: typical WASD kayboard layout
--
-- DEV NOTES:
--
--	The "lhc" (G13) Layout:
--	|		M1    M2    M3    [MR]
-- 	|	G1	G2	G3	G4	G5	G6	G7
--	|	G8	G9	G10	G11	G12	G13	G14
--	|		G15	G16	G17	G18	G19
--	|			G20	G21	G22		/	G26	  \
--	|						G23	G29	G25	G27
--	|							\	G28	  /
--	|						G24
--
--	According to API Docs, possible events (args) are:
--		"PROFILE_ACTIVATED", "PROFILE_DEACTIVATED" (nil)
--		"G_PRESSED", "G_RELEASED" (1 = G1, 18 = G18, etc.)
--		"M_PRESSED", "M_RELEASED" (1 = M1, 2 = M2, 3 = M3)
--		“MOUSE_BUTTON_PRESSED”, “MOUSE_BUTTON_RELEASED”
--			(2=Mouse Button 2, 3=Mouse Button 3, 4=Mouse Button 4, etc.)
--			NOTE: Left Mouse Button (1) is not reported by default.
--				Uncomment next line to override:
--				EnablePrimaryMouseButtonEvents(true);

-- Globals

MState = 1
LayoutModifier = 1
LayoutModifierUsed = false
DefaultLCDTimeout = 7000 --milliseconds

function OnEvent(event, arg)
	--primary method, must be implemented

	-- keep script aware of M-key changes
	if (event == "M_PRESSED") then
		MState = arg
		OutputLCDMessage(Keymaps[MState].KeymapTitleText[1], DefaultLCDTimeout)
		OutputLCDMessage(Keymaps[MState].KeymapTitleText[2], DefaultLCDTimeout)
	end
	

	-- Keypress handling
	if (event == "G_PRESSED") then

		-- only continue if a valid scripted M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), set the modifier toggle
			if (Keymaps[MState].LayoutModifiers[arg] ~= nil) then
				LayoutModifier = Keymaps[MState].LayoutModifiers[arg].Layout
			-- if key is a key modifier (shift, control, etc), press the key
			elseif (Keymaps[MState].KeyModifiers[arg] ~= nil) then
				PressKey(Keymaps[MState][1][arg])
			-- otherwise, press and release the key from the appropriate layout
			elseif (Keymaps[MState][LayoutModifier][arg] ~= nil) then
				PressAndReleaseKey(Keymaps[MState][LayoutModifier][arg])
				if (LayoutModifier ~= 1) then
					LayoutModifierUsed = true
				end
			end

		end
	end

	-- Keyrelease handling
	if (event == "G_RELEASED") then

		-- only continue if a valid scripted M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), set the modifier to default
			if (Keymaps[MState].LayoutModifiers[arg] ~= nil) then
				LayoutModifier = 1
				-- if no other keys were pressed while the layout was modified,
				--    press and release mod key's unmodded function if applicable
				if (not LayoutModifierUsed and Keymaps[MState].LayoutModifiers[arg].SecondaryFunction) then
					PressAndReleaseKey(Keymaps[MState][LayoutModifier][arg])
				end
				LayoutModifierUsed = false
			-- if key is a key modifier (shift, control, etc), release the key
			elseif (Keymaps[MState].KeyModifiers[arg] ~= nil) then
				ReleaseKey(Keymaps[MState][1][arg])
			end

		end
	end

	if (event == "PROFILE_ACTIVATED") then --fun
		printWelcomeMessage(DefaultLCDTimeout)
		MState = GetMKeyState("lhc")
	end

    OutputLogMessage("event = %s, arg = %s\n", event, arg)
end

Keymaps = {
	[1] = { -- M1 Keymaps
		HandledByScript = false,
		KeymapTitleText = {"M1 Keymap:","WASD Gaming Layout!"},
		LayoutModifiers = {
		},
		KeyModifiers = {
		},
		[1] = {
		},
	},
	[2] = { -- M2 Keymaps
		HandledByScript = true,
		KeymapTitleText = {"M2 Keymap:","Mirroring Keyboard Layout!"},
		LayoutModifiers = {
			[22] = {
				Layout = 2,
				SecondaryFunction = true,
			},
			[23] = {
				Layout = 3,
			},
			[24] = {
				Layout = 4,
			},
		},
		KeyModifiers = {
			[ 8] = true;
			[20] = true;
			[21] = true;
		},
		[1] = {
			[ 1] = "tab",		[ 2] = "q",		[ 3] = "w",		[ 4] = "e",		[ 5] = "r",	[ 6] = "t",	[ 7] = "backspace",
			[ 8] = "lshift",	[ 9] = "a",		[10] = "s",		[11] = "d",		[12] = "f",	[13] = "g",	[14] = "enter",
							[15] = "z",		[16] = "x",		[17] = "c",		[18] = "v",	[19] = "b",
											[20] = "lctrl",	[21] = "lalt", 	[22] = "spacebar",
			[23] = nil,						[26] = "up",
							[29] = "left",	[25] = nil,	[27] = "right",
											[28] = "down",
			[24] = nil,
		},
		[2] = {
			[ 1] = "escape",	[ 2] = "p",			[ 3] = "o",		[ 4] = "i",		[ 5] = "u",	[ 6] = "y",	[ 7] = "delete",
			[ 8] = nil,		[ 9] = "semicolon",	[10] = "l",		[11] = "k",		[12] = "j",	[13] = "h",	[14] = "enter",
							[15] = "slash",		[16] = "period",	[17] = "comma",	[18] = "m",	[19] = "n",
												[20] = nil,		[21] = nil,		[22] = nil,
			[23] = nil,					[26] = nil,
							[29] = nil,	[25] = nil,	[27] = nil,
			[24] = nil,					[28] = nil,
		},
		[3] = {
			[1]  = "tilde",	[2]  = "backslash",	[3]  = "9",		[4]  = "8",		[5]  = "7",		[6]  = "minus",	[7]  = "equal",
			[8]  = nil,		[9]  = "quote",		[10] = "6",		[11] = "5",		[12] = "4",		[13] = "lbracket",	[14] = "rbracket",
							[15] = nil,			[16] = "3",		[17] = "2",		[18] = "1",		[19] = "0",
												[20] = nil,		[21] = nil,		[22] = nil,
			[23] = nil,					[26] = nil,
							[29] = nil,	[25] = nil,	[27] = nil,
			[24] = nil,					[28] = nil,
		},
		[4] = {
			[1]  = nil,	[2]  = nil,	[3]  = nil,	[4]  = nil,	[5]  = nil,	[6] = nil,	[7] = nil,
			[8]  = nil,	[9]  = nil,	[10] = nil,	[11] = nil,	[12] = nil,	[13] = nil,	[14] = nil,
						[15] = nil,	[16] = nil,	[17] = nil,	[18] = nil,	[19] = nil,
									[20] = nil,	[21] = nil,	[22] = nil,
			[23] = nil,				[26] = nil,
						[29] = nil,	[25] = nil,	[27] = nil,
			[24] = nil,				[28] = nil,
		},
	},
	[3] = { -- M3 Keymaps
		HandledByScript = true,
		KeymapTitleText = {"M3 Keymap:","Experimental Layout!"},
		LayoutModifiers = {
			[22] = {
				Layout = 2,
				SecondaryFunction = true,
			},
			[23] = {
				Layout = 3,
			},
			[24] = {
				Layout = 4,
			},
		},
		KeyModifiers = {
			[ 8] = true;
			[20] = true;
			[21] = true;
		},
		[1] = {
			[ 1] = "escape",	[ 2] = "q",		[ 3] = "w",		[ 4] = "e",		[ 5] = "r",	[ 6] = "t",	[ 7] = "backspace",
			[ 8] = "lshift",	[ 9] = "a",		[10] = "s",		[11] = "d",		[12] = "f",	[13] = "g",	[14] = "enter",
							[15] = "z",		[16] = "x",		[17] = "c",		[18] = "v",	[19] = "b",
											[20] = "lctrl",	[21] = "lalt", 	[22] = "spacebar",
			[23] = nil,						[26] = "up",
							[29] = "left",	[25] = nil,	[27] = "right",
											[28] = "down",
			[24] = nil,
		},
		[2] = {
			[ 1] = "tab",		[ 2] = "p",			[ 3] = "o",		[ 4] = "i",		[ 5] = "u",	[ 6] = "y",	[ 7] = "delete",
			[ 8] = nil,		[ 9] = "semicolon",	[10] = "l",		[11] = "k",		[12] = "j",	[13] = "h",	[14] = "enter",
							[15] = "slash",		[16] = "period",	[17] = "comma",	[18] = "m",	[19] = "n",
												[20] = nil,		[21] = nil,		[22] = "spacebar",
			[23] = nil,							[26] = nil,
							[29] = nil,			[25] = nil,		[27] = nil,
												[28] = nil,
			[24] = nil,
		},
		[3] = {
			[1]  = "tilde",	[2]  = "7",			[3]  = "9",		[4]  = "8",		[5]  = "7",		[6]  = "minus",	[7]  = "backspace",
			[8]  = nil,		[9]  = "4",			[10] = "6",		[11] = "5",		[12] = "4",		[13] = "equal",	[14] = "lgui",
							[15] = "quote",		[16] = "3",		[17] = "2",		[18] = "1",		[19] = nil,
												[20] = "lctrl",	[21] = "0",		[22] = "gui",
			[23] = nil,							[26] = nil,
							[29] = nil,			[25] = nil,		[27] = nil,
												[28] = nil,
			[24] = nil,
		},
		[4] = {
			[1]  = "escape",	[2]  = "0",	[3]  = "9",	[4]  = "8",	[5]  = "7",	[6]  = "6",	[7]  = "delete",
			[8]  = nil,		[9]  = nil,	[10] = nil,	[11] = nil,	[12] = nil,	[13] = nil,	[14] = "enter",
			[15] = nil,		[16] = nil,	[17] = nil,	[18] = nil,	[19] = nil,
			[20] = nil,		[21] = nil,	[22] = nil,
			[23] = nil,					[26] = nil,
							[29] = nil,	[25] = nil,	[27] = nil,
										[28] = nil,
			[24] = nil,
		},
	}
}

function checkModifiers ()
	if (IsModifierPressed("alt")) then
		ReleaseKey("lalt")
		ReleaseKey("ralt")
	end
	if (IsModifierPressed("ctrl")) then
		ReleaseKey("lctrl")
		ReleaseKey("rctrl")
	end
	if (IsModifierPressed("shift")) then
		ReleaseKey("lshift")
		ReleaseKey("rshift")
	end
end

function printWelcomeMessage(timeout)
	if (Script_Version ~= nil) then
		OutputLCDMessage("MirrorBoard v" .. Script_Version[1], timeout)
		OutputLCDMessage("  " .. Script_Version[2], timeout)
	else
		OutputLCDMessage("Here we Stand, up in arms", timeout)
		OutputLCDMessage("This is Home, where we are", timeout)
	end
end
