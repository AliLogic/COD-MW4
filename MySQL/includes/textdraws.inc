CreateServerTextdraws()
{
	// Global
	tdAnnounce = TextDrawCreate(TEXTDRAW_POSITION_CENTERLR, 50.0, " ");
	TextDrawAlignment(tdAnnounce, TEXTDRAW_DIRECTION_CENTER);
	TextDrawBackgroundColor(tdAnnounce, COLOR_BLACK);
	TextDrawFont(tdAnnounce, TEXTDRAW_FONT_NORMAL);
	TextDrawLetterSize(tdAnnounce, 0.5, 1.5);
	TextDrawColor(tdAnnounce, COLOR_SERVER);
	TextDrawSetOutline(tdAnnounce, 0);
	TextDrawSetProportional(tdAnnounce, 1);
	TextDrawSetShadow(tdAnnounce, 1);
	TextDrawSetSelectable(tdAnnounce, 0);

	logo1 = TextDrawCreate(5.0,422.0,"~w~CALL OF DUTY");
	TextDrawAlignment(logo1,0);
	TextDrawBackgroundColor(logo1, 0x00000035);
	TextDrawFont(logo1,3);
	TextDrawLetterSize(logo1,0.499999,1.6);
	TextDrawColor(logo1, INVALID_VALUE);
	TextDrawSetOutline(logo1,1);
	TextDrawSetProportional(logo1,1);
	TextDrawSetShadow(logo1,1);
	
	logo2 = TextDrawCreate(23.0,432.0,"~b~ADVANCED ~r~WARFARE");
	TextDrawAlignment(logo2,0);
	TextDrawBackgroundColor(logo2, 0x00000035);
	TextDrawFont(logo2,3);
	TextDrawLetterSize(logo2,0.399999,1.300000);
	TextDrawColor(logo2, INVALID_VALUE);
	TextDrawSetOutline(logo2,1);
	TextDrawSetProportional(logo2,1);
	TextDrawSetShadow(logo2,1);

	mbox = TextDrawCreate(683.0, 365.0, "~n~~n~~n~~n~~n~~n~");
	TextDrawBackgroundColor( mbox, 255);
	TextDrawFont(mbox, 1);
	TextDrawLetterSize(mbox, 0.969999, 1.6);
	TextDrawColor(mbox, -1347440726);
	TextDrawSetOutline(mbox, 0);
	TextDrawSetProportional(mbox, 1);
	TextDrawSetShadow(mbox, 1);
	TextDrawUseBox(mbox, 1);
	TextDrawBoxColor(mbox, 0x066);
	TextDrawTextSize(mbox, 470.0, 99.0);
	TextDrawShowForAll(mbox);

	Web = TextDrawCreate(501.0,8.0,"~w~" SERVER_URL "");
	TextDrawAlignment(Web, 0);
	TextDrawBackgroundColor(Web, 0x00000035);
	TextDrawFont(Web,3);
	TextDrawLetterSize(Web,0.3,1.0);
	TextDrawColor(Web,INVALID_VALUE);
	TextDrawSetOutline(Web,1);
	TextDrawSetProportional(Web,1);
	TextDrawSetShadow(Web,0);

	// Login/Register

	#if (GAMEMODE_DEVELOPMODE == false)
		tdServerName = TextDrawCreate(TEXTDRAW_POSITION_CENTERLR, 50.0, "~w~Call of Duty~n~~b~Advanced ~r~Warfare");
	#else
		tdServerName = TextDrawCreate(TEXTDRAW_POSITION_CENTERLR, 50.0, "~w~Call of Duty~n~~b~Advanced ~r~Warfare (Development)");
	#endif
	TextDrawAlignment(tdServerName, TEXTDRAW_DIRECTION_CENTER);
	TextDrawBackgroundColor(tdServerName, 0x00000035);
	TextDrawFont(tdServerName, TEXTDRAW_FONT_BOLDDIGITAL);
	TextDrawLetterSize(tdServerName, 0.6, 2.4);
	TextDrawColor(tdServerName, INVALID_VALUE);
	TextDrawSetOutline(tdServerName, 1);
	TextDrawSetProportional(tdServerName, 1);
	TextDrawSetShadow(tdServerName, 0);
	TextDrawSetSelectable(tdServerName, 0);

	tdWelcome = TextDrawCreate(TEXTDRAW_POSITION_CENTERLR, 150.0, "~y~Welcome");
	TextDrawAlignment(tdWelcome, TEXTDRAW_DIRECTION_CENTER);
	TextDrawBackgroundColor(tdWelcome, 0x00000035);
	TextDrawFont(tdWelcome, TEXTDRAW_FONT_BOLDDIGITAL);
	TextDrawLetterSize(tdWelcome, 0.5, 2.0);
	TextDrawColor(tdWelcome, INVALID_VALUE);
	TextDrawSetOutline(tdWelcome, 1);
	TextDrawSetProportional(tdWelcome, 1);
	TextDrawSetShadow(tdWelcome, 0);
	TextDrawSetSelectable(tdWelcome, 0);

	// Team Selection

	tdTeamCount0 = TextDrawCreate(TEXTDRAW_POSITION_LEFT, 210.0, "Asia: 0");
	TextDrawBackgroundColor(tdTeamCount0, 0x00000035);
	TextDrawFont(tdTeamCount0, TEXTDRAW_FONT_DIGITAL);
	TextDrawLetterSize(tdTeamCount0, 0.4, 1.6);
	TextDrawColor(tdTeamCount0, gTeams[0][E_TEAM_COLOR]);
	TextDrawSetOutline(tdTeamCount0, 1);
	TextDrawSetProportional(tdTeamCount0, 1);
	TextDrawSetShadow(tdTeamCount0, 1);
	TextDrawSetSelectable(tdTeamCount0, 0);

	tdTeamCount1 = TextDrawCreate(TEXTDRAW_POSITION_LEFT, 230.0, "Australia: 0");
	TextDrawBackgroundColor(tdTeamCount1, 0x00000035);
	TextDrawFont(tdTeamCount1, TEXTDRAW_FONT_DIGITAL);
	TextDrawLetterSize(tdTeamCount1, 0.4, 1.6);
	TextDrawColor(tdTeamCount1, gTeams[1][E_TEAM_COLOR]);
	TextDrawSetOutline(tdTeamCount1, 1);
	TextDrawSetProportional(tdTeamCount1, 1);
	TextDrawSetShadow(tdTeamCount1, 1);
	TextDrawSetSelectable(tdTeamCount1, 0);

	tdTeamCount2 = TextDrawCreate(TEXTDRAW_POSITION_LEFT, 250.0, "Europe: 0");
	TextDrawBackgroundColor(tdTeamCount2, 0x00000035);
	TextDrawFont(tdTeamCount2, TEXTDRAW_FONT_DIGITAL);
	TextDrawLetterSize(tdTeamCount2, 0.4, 1.6);
	TextDrawColor(tdTeamCount2, gTeams[2][E_TEAM_COLOR]);
	TextDrawSetOutline(tdTeamCount2, 1);
	TextDrawSetProportional(tdTeamCount2, 1);
	TextDrawSetShadow(tdTeamCount2, 1);
	TextDrawSetSelectable(tdTeamCount2, 0);

	tdTeamCount3 = TextDrawCreate(TEXTDRAW_POSITION_LEFT, 270.0, "Russia: 0");
	TextDrawBackgroundColor(tdTeamCount3, 0x00000035);
	TextDrawFont(tdTeamCount3, TEXTDRAW_FONT_DIGITAL);
	TextDrawLetterSize(tdTeamCount3, 0.4, 1.6);
	TextDrawColor(tdTeamCount3, gTeams[3][E_TEAM_COLOR]);
	TextDrawSetOutline(tdTeamCount3, 1);
	TextDrawSetProportional(tdTeamCount3, 1);
	TextDrawSetShadow(tdTeamCount3, 1);
	TextDrawSetSelectable(tdTeamCount3, 0);

	tdTeamCount4 = TextDrawCreate(TEXTDRAW_POSITION_LEFT, 290.0, "USA: 0");
	TextDrawBackgroundColor(tdTeamCount4, 0x00000035);
	TextDrawFont(tdTeamCount4, TEXTDRAW_FONT_DIGITAL);
	TextDrawLetterSize(tdTeamCount4, 0.4, 1.6);
	TextDrawColor(tdTeamCount4, gTeams[4][E_TEAM_COLOR]);
	TextDrawSetOutline(tdTeamCount4, 1);
	TextDrawSetProportional(tdTeamCount4, 1);
	TextDrawSetShadow(tdTeamCount4, 1);
	TextDrawSetSelectable(tdTeamCount4, 0);

	// Game

	Message = TextDrawCreate(473.0, 368.0, " ");
	TextDrawBackgroundColor(Message, 0x00000035);
	TextDrawFont(Message, 1);
	TextDrawLetterSize(Message, 0.2, 1.2);
	TextDrawColor(Message, INVALID_VALUE);
	TextDrawSetOutline(Message, 0);
	TextDrawSetProportional(Message, 1);
	TextDrawSetShadow(Message, 1);
	TextDrawShowForAll(Message);

	for (new playerid = 0; playerid < MAX_PLAYERS; playerid ++)
	{
		tdScore[playerid] = TextDrawCreate(482.0, 117.0," ");
		TextDrawAlignment(tdScore[playerid],0);
		TextDrawBackgroundColor(tdScore[playerid], 0x00000035);
		TextDrawFont(tdScore[playerid],2);
		TextDrawLetterSize(tdScore[playerid],0.299999,1.0);
		TextDrawColor(tdScore[playerid], INVALID_VALUE);
		TextDrawSetOutline(tdScore[playerid],1);
		TextDrawSetProportional(tdScore[playerid],1);
		TextDrawSetShadow(tdScore[playerid],1);

		Rank1[playerid] = TextDrawCreate(140.0, 360.0, " ");
		TextDrawAlignment(Rank1[playerid], 0);
		TextDrawBackgroundColor(Rank1[playerid], 0x00000035);
		TextDrawFont(Rank1[playerid],3);
		TextDrawLetterSize(Rank1[playerid],0.3, 1.2);
		TextDrawColor(Rank1[playerid], INVALID_VALUE);
		TextDrawSetOutline(Rank1[playerid],1);
		TextDrawSetProportional(Rank1[playerid],1);
		TextDrawSetShadow(Rank1[playerid],0);

		CountText[playerid] = TextDrawCreate(85.0,291.0,"PROCESSING:~n~~n~25/25");
		TextDrawUseBox(CountText[playerid],1);
		TextDrawBoxColor(CountText[playerid],0x066);
		TextDrawTextSize(CountText[playerid],-70.0,83.0);
		TextDrawAlignment(CountText[playerid],2);
		TextDrawBackgroundColor(CountText[playerid],0x00000035);
		TextDrawFont(CountText[playerid],2);
		TextDrawLetterSize(CountText[playerid],0.199999,1.7);
		TextDrawColor(CountText[playerid],0x008B51B5);
		TextDrawSetProportional(CountText[playerid],1);
		TextDrawSetShadow(CountText[playerid],1);
		//-------
		damage2[playerid] = TextDrawCreate(372.0,390.0," ");
		TextDrawAlignment(damage2[playerid],0);
		TextDrawBackgroundColor(damage2[playerid],0x00000035);
		TextDrawFont(damage2[playerid],2);
		TextDrawLetterSize(damage2[playerid],0.199999,1.1);
		TextDrawColor(damage2[playerid],0xff0000cc);
		TextDrawSetOutline(damage2[playerid],1);
		TextDrawSetProportional(damage2[playerid],1);
		TextDrawSetShadow(damage2[playerid],1);
		//-------
		damage[playerid] = TextDrawCreate(372.0,369.0," ");
		TextDrawAlignment(damage[playerid],0);
		TextDrawBackgroundColor(damage[playerid],0x00000035);
		TextDrawFont(damage[playerid],2);
		TextDrawLetterSize(damage[playerid],0.199999,1.100000);
		TextDrawColor(damage[playerid],0x00ff00ff);
		TextDrawSetOutline(damage[playerid],1);
		TextDrawSetProportional(damage[playerid],1);
		TextDrawSetShadow(damage[playerid],1);
	}
}

CreatePlayerTextdraws(const playerid)
{
	playerData[playerid][player_TdScreenMessage] = CreatePlayerTextDraw(playerid, TEXTDRAW_POSITION_CENTERLR, 310.0, " ");
	PlayerTextDrawAlignment(playerid, playerData[playerid][player_TdScreenMessage], TEXTDRAW_DIRECTION_CENTER);
	PlayerTextDrawBackgroundColor(playerid, playerData[playerid][player_TdScreenMessage], COLOR_BLACK);
	PlayerTextDrawFont(playerid, playerData[playerid][player_TdScreenMessage], TEXTDRAW_FONT_NORMAL);
	PlayerTextDrawLetterSize(playerid, playerData[playerid][player_TdScreenMessage], 0.3, 1.5);
	PlayerTextDrawColor(playerid, playerData[playerid][player_TdScreenMessage], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, playerData[playerid][player_TdScreenMessage], 0);
	PlayerTextDrawSetProportional(playerid, playerData[playerid][player_TdScreenMessage], 1);
	PlayerTextDrawSetShadow(playerid, playerData[playerid][player_TdScreenMessage], 1);
	PlayerTextDrawSetSelectable(playerid, playerData[playerid][player_TdScreenMessage], 0);
	PlayerTextDrawShow(playerid, playerData[playerid][player_TdScreenMessage]);

	playerData[playerid][pd_TdGMVersion] = CreatePlayerTextDraw(playerid, TEXTDRAW_POSITION_CENTERLR, TEXTDRAW_POSITION_BOTTOM, "~y~" GAMEMODE_NAME " " GAMEMODE_VERSION " - " GAMEMODE_LASTUPDATE "");
	PlayerTextDrawAlignment(playerid, playerData[playerid][pd_TdGMVersion], TEXTDRAW_DIRECTION_CENTER);
	PlayerTextDrawBackgroundColor(playerid, playerData[playerid][pd_TdGMVersion], 0x00000035);
	PlayerTextDrawFont(playerid, playerData[playerid][pd_TdGMVersion], TEXTDRAW_FONT_DIGITAL);
	PlayerTextDrawLetterSize(playerid, playerData[playerid][pd_TdGMVersion], 0.3, 1.2);
	PlayerTextDrawColor(playerid, playerData[playerid][pd_TdGMVersion], INVALID_VALUE);
	PlayerTextDrawSetOutline(playerid, playerData[playerid][pd_TdGMVersion], 1);
	PlayerTextDrawSetProportional(playerid, playerData[playerid][pd_TdGMVersion], 1);
	PlayerTextDrawSetShadow(playerid, playerData[playerid][pd_TdGMVersion], 0);
	PlayerTextDrawSetSelectable(playerid, playerData[playerid][pd_TdGMVersion], 0);
	PlayerTextDrawShow(playerid, playerData[playerid][pd_TdGMVersion]);

	playerData[playerid][pd_TDVehicleName] = CreatePlayerTextDraw(playerid, TEXTDRAW_POSITION_RIGHT, 310.0, " ");
	PlayerTextDrawAlignment(playerid, playerData[playerid][pd_TDVehicleName], TEXTDRAW_DIRECTION_RIGHT);
	PlayerTextDrawBackgroundColor(playerid, playerData[playerid][pd_TDVehicleName], 0x00000035);
	PlayerTextDrawFont(playerid, playerData[playerid][pd_TDVehicleName], TEXTDRAW_FONT_DIGITAL);
	PlayerTextDrawLetterSize(playerid, playerData[playerid][pd_TDVehicleName], 0.4, 1.6);
	PlayerTextDrawColor(playerid, playerData[playerid][pd_TDVehicleName], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, playerData[playerid][pd_TDVehicleName], 1);
	PlayerTextDrawSetProportional(playerid, playerData[playerid][pd_TDVehicleName], 1);
	PlayerTextDrawSetShadow(playerid, playerData[playerid][pd_TDVehicleName], 0);
	PlayerTextDrawSetSelectable(playerid, playerData[playerid][pd_TDVehicleName], 0);

	playerData[playerid][pd_TdTeamSelection] = CreatePlayerTextDraw(playerid, TEXTDRAW_POSITION_CENTERLR, 270.0, " "); // Team name
	PlayerTextDrawAlignment(playerid, playerData[playerid][pd_TdTeamSelection], TEXTDRAW_DIRECTION_CENTER);
	PlayerTextDrawBackgroundColor(playerid, playerData[playerid][pd_TdTeamSelection], 0x00000035);
	PlayerTextDrawFont(playerid, playerData[playerid][pd_TdTeamSelection], TEXTDRAW_FONT_DIGITAL);
	PlayerTextDrawLetterSize(playerid, playerData[playerid][pd_TdTeamSelection], 0.4, 1.6);
	PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_WHITE);
	PlayerTextDrawSetOutline(playerid, playerData[playerid][pd_TdTeamSelection], 1);
	PlayerTextDrawSetProportional(playerid, playerData[playerid][pd_TdTeamSelection], 1);
	PlayerTextDrawSetShadow(playerid, playerData[playerid][pd_TdTeamSelection], 0);
	PlayerTextDrawSetSelectable(playerid, playerData[playerid][pd_TdTeamSelection], 0);
}
