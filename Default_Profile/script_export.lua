function OnEvent(event, arg)

	-- M2 onehandedKeyboard Handling
	if (GetMKeyState("lhc")==2) then

		-- Keypress handling
		if (event == "G_PRESSED") then
			if (arg == 22) then
				M2Modifier1 = true
			elseif (M2KeyModifiersMap[arg] ~= nil) then
				PressKey(M2KeyModifiersMap[arg])
			elseif (M2Modifier1) then
				PressAndReleaseKey(M2GMap1[arg])
				M2KeyPressed = true
			else
				PressAndReleaseKey(M2GMap0[arg])
			end
		end

		-- Keyrelease handling
		if (event == "G_RELEASED") then
			if (arg == 22) then
				M2Modifier1 = false
				if (not M2KeyPressed) then
					PressAndReleaseKey(M2GMap0[arg])
				end
				M2KeyPressed = false
			elseif (M2KeyModifiersMap[arg] ~= nil) then
				ReleaseKey(M2KeyModifiersMap[arg])
			end
		end

	end

	-- M3 onehandedKeyboard Handling
	if (GetMKeyState("lhc")==3) then

		-- Keypress handling
		if (event == "G_PRESSED") then
			if (arg == 22) then
				M3Modifier1 = true
			elseif (M3KeyModifiersMap[arg] ~= nil) then
				PressKey(M3KeyModifiersMap[arg])
			elseif (M3Modifier1) then
				PressAndReleaseKey(M3GMap1[arg])
				M3KeyPressed = true
			else
				PressAndReleaseKey(M3GMap0[arg])
			end
		end

		-- Keyrelease handling
		if (event == "G_RELEASED") then
			if (arg == 22) then
				M3Modifier1 = false
				if (not M3KeyPressed) then
					PressAndReleaseKey(M3GMap0[arg])
				end
				M3KeyPressed = false
			elseif (M3KeyModifiersMap[arg] ~= nil) then
				ReleaseKey(M3KeyModifiersMap[arg])
			end
		end

	end

    OutputLogMessage("event = %s, arg = %s\n", event, arg)
end

M2Modifier1 = false;
M2KeyPressed = false;

M3Modifier1 = false;
M3KeyPressed = false;


M2LayoutModifiersMap = {
	[22] = M2Modifier1;
}
M2KeyModifiersMap = {
	[8]  = "lshift";
	[20] = "lctrl";
	[21] = "lalt";
}
M2GMap0 = {
	[1]  = "escape";	[2]  = "q";	[3]  = "w";	[4]  = "e";	[5]  = "r";	[6]  = "t";	[7]  = "backspace";
	[8]  = ""; --key modifier
	[9]  = "a";	[10] = "s";	[11] = "d";	[12] = "f";	[13] = "g";	[14] = "enter";
	[15] = "z";	[16] = "x";	[17] = "c";	[18] = "v";	[19] = "b";
	[20] = ""; --key modifier
	[21] = ""; --key modifier
	[22] = "spacebar"; --key modifier
}

M2GMap1 = {
	[1]  = "tab";	[2]  = "p";	[3]  = "o";	[4]  = "i";	[5]  = "u";	[6]  = "y";	[7]  = "delete";
	[8]  = ""; --key modifier
	[9]  = "semicolon";	[10] = "l";	[11] = "k";	[12] = "j";	[13] = "h";	[14] = "enter";
	[15] = "slash";	[16] = "period";	[17] = "comma";	[18] = "m";	[19] = "n";
	[20] = ""; --key modifier
	[21] = ""; --key modifier
	[22] = ""; --key modifier
}

M3KeyModifiersMap = {
	[8]  = "lshift";
	[20] = "lctrl";
	[21] = "lalt";
}
M3GMap0 = {
	[1]  = "escape";	[2]  = "1";	[3]  = "2";	[4]  = "3";	[5]  = "4";	[6]  = "5";	[7]  = "backspace";
	[8]  = ""; --key modifier
	[9]  = "";	[10] = "";	[11] = "";	[12] = "";	[13] = "";	[14] = "enter";
	[15] = "";	[16] = "";	[17] = "";	[18] = "";	[19] = "";
	[20] = ""; --key modifier
	[21] = ""; --key modifier
	[22] = "spacebar"; --key modifier
}

M3GMap1 = {
	[1]  = "escape";	[2]  = "0";	[3]  = "9";	[4]  = "8";	[5]  = "7";	[6]  = "6";	[7]  = "delete";
	[8]  = ""; --key modifier
	[9]  = "";	[10] = "";	[11] = "";	[12] = "";	[13] = "";	[14] = "enter";
	[15] = "";	[16] = "";	[17] = "";	[18] = "";	[19] = "";
	[20] = ""; --key modifier
	[21] = ""; --key modifier
	[22] = ""; --key modifier
}
