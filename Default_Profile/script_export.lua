function OnEvent(event, arg)

	-- Keypress handling
	if (event == "G_PRESSED") then
		MState = GetMKeyState("lhc")
		GKey = arg

		-- only continue if a valid M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), set the modifier toggle
			if (Keymaps[MState].LayoutModifiers[GKey] ~= nil) then
				LayoutModifier = true
			-- if key is a key modifier (shift, control, etc), press the key
			elseif (Keymaps[MState].KeyModifiers[GKey] == true) then
				PressKey(Keymaps[MState][1][GKey])
			-- if a layout modifier is being pressed, press and release the key from the appropriate layout
			elseif (LayoutModifier) then
				PressAndReleaseKey(Keymaps[MState][2][GKey])
				LayoutModifierUsed = true
			-- if no other weirdness, press and release the key from the base layout
			else
				PressAndReleaseKey(Keymaps[MState][1][GKey])
			end
		end
	end

	-- Keyrelease handling
	if (event == "G_RELEASED") then
		MState = GetMKeyState("lhc")
		GKey = arg

		-- only continue if a valid M-Key state
		if (Keymaps[MState].HandledByScript) then

			-- if key is a layout modifier (mirroring, etc), remove the modifier toggle
			if (Keymaps[MState].LayoutModifiers[GKey] ~= nil) then
				LayoutModifier = false
				-- if no other keys were pressed while the layout was modified,
				--    press and release mod key's unmodded function
				if (not LayoutModifierUsed) then
					PressAndReleaseKey(Keymaps[MState][1][GKey])
				end
				LayoutModifierUsed = false
			-- if key is a key modifier (shift, control, etc), release the key
			elseif (Keymaps[MState].KeyModifiers[GKey] == true) then
				ReleaseKey(Keymaps[MState][1][GKey])
			end
		end
	end

    OutputLogMessage("event = %s, arg = %s\n", event, arg)
end

MState = 2
GKey = 0
LayoutModifier = false
LayoutModifierUsed = false

Keymaps = {
	[1] = { -- M1 Keymaps
		HandledByScript = false,
		LayoutModifiers = {
		},
		KeyModifiers = {
		},
		[1] = {
		}
	},
	[2] = { -- M2 Keymaps
		HandledByScript = true,
		LayoutModifiers = {
			[22] = {
				Active = false,
				Used = false,
				Layout = 2
			}
		},
		KeyModifiers = {
			[ 8] = true;
			[20] = true;
			[21] = true;
		},
		[1] = {
			[ 1] = "escape";	[ 2] = "q";		[ 3] = "w";	[ 4] = "e";	[ 5] = "r";	[ 6] = "t";	[ 7] = "backspace";
			[ 8] = "lshift";	[ 9] = "a";		[10] = "s";	[11] = "d";	[12] = "f";	[13] = "g";	[14] = "enter";
			[15] = "z";		[16] = "x";		[17] = "c";	[18] = "v";	[19] = "b";
			[20] = "lctrl";	[21] = "lalt"; 	[22] = "spacebar";
		},
		[2] = {
			[ 1] = "tab";		[ 2] = "p";			[ 3]  = "o";		[ 4] = "i";	[ 5] = "u";	[ 6] = "y";	[ 7] = "delete";
			[ 8] = "";	[ 9] = "semicolon";	[10] = "l";		[11] = "k";	[12] = "j";	[13] = "h";	[14] = "enter";
			[15] = "slash";	[16] = "period";		[17] = "comma";	[18] = "m";	[19] = "n";
			[20] = "";	[21] = "";		[22] = "spacebar";
		}
	},
	[3] = { -- M3 Keymaps
		HandledByScript = true,
		LayoutModifiers = {
			[22] = {
				Active = false,
				Used = false,
				Layout = 2
			}
		},
		KeyModifiers = {
			[ 8] = true;
			[20] = true;
			[21] = true;
		},
		[1] = {
			[1]  = "tilde";	[2]  = "1";	[3]  = "2";	[4]  = "3";	[5]  = "4";	[6]  = "5";	[7]  = "backspace";
			[8]  = "lshift";	[9]  = "non_us_slash";	[10] = "rbracket";	[11] = "lbracket";	[12] = "equal";	[13] = "minus";	[14] = "enter";
			[15] = "quote";	[16] = "";	[17] = "";	[18] = "";	[19] = "";
			[20] = "lctrl";	[21] = "lalt";	[22] = "spacebar";
		},
		[2] = {
			[1]  = "escape";	[2]  = "0";	[3]  = "9";	[4]  = "8";	[5]  = "7";	[6]  = "6";	[7]  = "delete";
			[8]  = "";	[9]  = "";	[10] = "";	[11] = "";	[12] = "";	[13] = "";	[14] = "enter";
			[15] = "";	[16] = "";	[17] = "";	[18] = "";	[19] = "";
			[20] = "";	[21] = "";	[22] = "";
		}
	}
}
