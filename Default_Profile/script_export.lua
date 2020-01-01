function OnEvent(event, arg)

	-- Keypress handling
	if (event == "G_PRESSED") then
		MState = GetMKeyState("lhc")
		GKey = arg

		-- only continue if a valid scripted M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), set the modifier toggle
			if (Keymaps[MState].LayoutModifiers[GKey] ~= nil) then
				LayoutModifier = Keymaps[MState].LayoutModifiers[GKey].Layout
			-- if key is a key modifier (shift, control, etc), press the key
			elseif (Keymaps[MState].KeyModifiers[GKey] ~= nil) then
				PressKey(Keymaps[MState][1][GKey])
			-- otherwise, press and release the key from the appropriate layout
			elseif (Keymaps[MState][LayoutModifier][GKey] ~= nil) then
				PressAndReleaseKey(Keymaps[MState][LayoutModifier][GKey])
				if (LayoutModifier ~= 1) then
					LayoutModifierUsed = true
				end
			end
		end
	end

	-- Keyrelease handling
	if (event == "G_RELEASED") then
		MState = GetMKeyState("lhc")
		GKey = arg

		-- only continue if a valid scripted M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), set the modifier to default
			if (Keymaps[MState].LayoutModifiers[GKey] ~= nil) then
				LayoutModifier = 1
				-- if no other keys were pressed while the layout was modified,
				--    press and release mod key's unmodded function if applicable
				if (not LayoutModifierUsed and Keymaps[MState].LayoutModifiers[GKey].SecondaryFunction) then
					PressAndReleaseKey(Keymaps[MState][LayoutModifier][GKey])
				end
				LayoutModifierUsed = false
			-- if key is a key modifier (shift, control, etc), release the key
			elseif (Keymaps[MState].KeyModifiers[GKey] ~= nil) then
				ReleaseKey(Keymaps[MState][1][GKey])
			end
		end
	end

    OutputLogMessage("event = %s, arg = %s\n", event, arg)
end

MState = 2
GKey = 0
LayoutModifier = 1
LayoutModifierUsed = false

Keymaps = {
	[1] = { -- M1 Keymaps
		HandledByScript = false,
		LayoutModifiers = {
		},
		KeyModifiers = {
		},
		[1] = {
		},
	},
	[2] = { -- M2 Keymaps
		HandledByScript = true,
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
			[ 1] = "escape",	[ 2] = "q",		[ 3] = "w",	[ 4] = "e",	[ 5] = "r",	[ 6] = "t",	[ 7] = "backspace",
			[ 8] = "lshift",	[ 9] = "a",		[10] = "s",	[11] = "d",	[12] = "f",	[13] = "g",	[14] = "enter",
			[15] = "z",		[16] = "x",		[17] = "c",	[18] = "v",	[19] = "b",
			[20] = "lctrl",	[21] = "lalt", 	[22] = "spacebar",
			[23] = nil,						[26] = "up",
							[29] = "left",	[25] = nil,	[27] = "right",
											[28] = "down",
			[24] = nil,
		},
		[2] = {
			[ 1] = "tab",		[ 2] = "p",			[ 3]  = "o",		[ 4] = "i",	[ 5] = "u",	[ 6] = "y",	[ 7] = "delete",
			[ 8] = nil,		[ 9] = "semicolon",	[10] = "l",		[11] = "k",	[12] = "j",	[13] = "h",	[14] = "enter",
			[15] = "slash",	[16] = "period",		[17] = "comma",	[18] = "m",	[19] = "n",
			[20] = nil,		[21] = nil,			[22] = "spacebar",
			[23] = nil,							[26] = nil,
							[29] = nil,			[25] = nil,		[27] = nil,
												[28] = nil,
			[24] = nil,
		},
		[3] = {
			[1]  = "tilde",	[2]  = "1",			[3]  = "2",		[4]  = "3",		[5]  = "4",		[6]  = "5",		[7]  = "backspace",
			[8]  = nil,		[9]  = "non_us_slash",	[10] = "rbracket",	[11] = "lbracket",	[12] = "equal",	[13] = "minus",	[14] = "enter",
			[15] = "quote",	[16] = nil,			[17] = nil,		[18] = nil,		[19] = nil,
			[20] = "lctrl",	[21] = "lalt",		[22] = "spacebar",
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
	},
	[3] = { -- M3 Keymaps
		HandledByScript = true,
		LayoutModifiers = {
			[22] = {
				Active = false,
				Used = false,
				Layout = 2
			},
		},
		KeyModifiers = {
			[ 8] = true,
			[20] = true,
			[21] = true
		},
		[1] = {
			[1]  = "tilde",	[2]  = "1",			[3]  = "2",		[4]  = "3",		[5]  = "4",		[6]  = "5",		[7]  = "backspace",
			[8]  = "lshift",	[9]  = "non_us_slash",	[10] = "rbracket",	[11] = "lbracket",	[12] = "equal",	[13] = "minus",	[14] = "enter",
			[15] = "quote",	[16] = nil,			[17] = nil,		[18] = nil,		[19] = nil,
			[20] = "lctrl",	[21] = "lalt",		[22] = "spacebar",
			[23] = nil,							[26] = nil,
							[29] = nil,			[25] = nil,		[27] = nil,
												[28] = nil,
			[24] = nil,
		},
		[2] = {
			[1]  = "escape",	[2]  = "0",	[3]  = "9",	[4]  = "8",	[5]  = "7",	[6]  = "6",	[7]  = "delete",
			[8]  = nil,		[9]  = nil,	[10] = nil,	[11] = nil,	[12] = nil,	[13] = nil,	[14] = "enter",
			[15] = nil,		[16] = nil,	[17] = nil,	[18] = nil,	[19] = nil,
			[20] = nil,		[21] = nil,	[22] = nil,
			[23] = nil,					[26] = nil,
							[29] = nil,	[25] = nil,	[27] = nil,
										[28] = nil,
			[24] = nil,
		}
	}
}
