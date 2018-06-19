/*
	Name: CoD-AW
	Producer/Developer: Logic_, COD-AW, Jarnu, Yousha
	Link: http://cod-samp.ga/
*/

#include <a_samp>

#include "\includes\configuration.inc"

#include <streamer>
#include <foreach>
#include <sscanf2>
#include <crashdetect>
#include <mapfix>
#include <izcmd>		// I-ZCMD
#include <a_mysql_r39>	// MySQL R39-6
#include <fuckCleo>
#include <dini2>		// Dini 2
//#include <OPA>
#include <attachments> // Aim and Attachment manager
#include <AutoAFK>

#pragma dynamic 145000
#pragma tabsize 0

#define SET_ALPHA(%1,%2) ((%1 & ~0xFF) | (clamp(%2, 0x00, 0xFF)))

#include "\includes\locales\international.inc"
#include "\includes\enumerates.inc"
#include "\includes\variables.inc"
#include "\includes\vehicles.inc"
#include "\includes\objects.inc"
#include "\includes\textdraws.inc"
#include "\includes\utils.inc"
#include "\includes\commands.inc"

public OnGameModeInit()
{
	print("[OnGameModeInit] Initiating De-AMX.");
	AntiDeAMX();

	print("[OnGameModeInit] Checking SERVER_NAME and SERVER_ADDRESS definitions.");
	if (!strlen(SERVER_NAME) || !strlen(SERVER_ADDRESS))
	{
		print("[OnGameModeInit] SERVER_NAME/SERVER_ADDRESS is not defined in 'include/configuration.inc'.");
		return SendRconCommand("exit");
	}

	print("[OnGameModeInit] Initiating MySQL.");
	mysql_log(LOG_ERROR | LOG_WARNING, LOG_TYPE_TEXT);
	gGameConnection = mysql_connect(DATABASE_GAME_HOST, DATABASE_GAME_USERNAME, DATABASE_GAME_NAME, DATABASE_GAME_PASSWORD, DATABASE_GAME_PORT);
	mysql_set_charset(DATABASE_GAME_CHARSET);
	
	print("[OnGameModeInit] Initiating server information.");
	SetGameModeText("COD-AW TDM v4.5.0");
	SendRconCommand("chatlogging 0");
	SendRconCommand("language English/Russian/Others");
	SendRconCommand("mapname Las Venturas Deserts");
	
	print("[OnGameModeInit] Initiating general content.");
	EnableStuntBonusForAll(0);
	ShowNameTags(1);
	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	EnableVehicleFriendlyFire();
	SetNameTagDrawDistance(DRAWDISTANCE_NAMETAG);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	DisableNameTagLOS();
	
	#if (GAMEMODE_CHRISTMASMODE == false)
	SetWeather(WEATHER_SUNNY);
	#else
		new year, month, day;
		getdate(year, month, day);
		if (month == 1)
		{
			SetWeather(WEATHER_SUNNY);
		}
		else
		{
			SetWeather(WEATHER_SNOW);
		}
	#endif
	new gServerHour, gServerMinute, gServerSecond;
	gettime(gServerHour, gServerMinute, gServerSecond);
	SetWorldTime(gServerHour);
	
	print("[OnGameModeInit] Initiating teams.");
	for(new i; i < sizeof gTeams; i++)
	{
		AddPlayerClass(gTeams[i][E_TEAM_SKIN], 1110.1959, 1909.0803, 10.9, 0, 0, 0, 0, 0, 0);
		GangZoneCreate(gTeams[i][E_TEAM_GANGZONE_OFFSET][0], gTeams[i][E_TEAM_GANGZONE_OFFSET][1], gTeams[i][E_TEAM_GANGZONE_OFFSET][2], gTeams[i][E_TEAM_GANGZONE_OFFSET][3]);
	}
	
	/*AddPlayerClass(SKIN_EUROPE, 1110.1959, 1909.0803, 10.9, 5.0, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(SKIN_ASIA, -794.9099, 1610.2480, 29.9, 78.7, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(SKIN_RUSSIA, -136.0029, 1115.9038, 20.9, 3.7, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(SKIN_USA, 245.0012, 1859.0973, 14.9, 74.5, 0, 0, 0, 0, 0, 0);
	AddPlayerClass(SKIN_AUSTRALIA, 405.5110, 2451.0649, 16.9, 0.0, 0, 0, 0, 0, 0, 0);*/
	
	NoJP = 1; // JetPack
	NoSpy = 1; // Spy Disguising
	gHeadshotState = 1;
	HV = 1; // Heavy Vehicles
	
	print("[OnGameModeInit] Initiating map.");
	CreateAllObjects();

	print("[OnGameModeInit] Initiating server textdraws.");
	CreateServerTextdraws();

	print("[OnGameModeInit] Initiating actors.");
	CreateAllActors();
	
	print("[OnGameModeInit] Initiating vehicles.");
	CreateAllVehicles();

	print("[OnGameModeInit] Initiating capture zones.");
	CreateAllCaptureZones();
	
	print("[OnGameModeInit] Initiating timers.");
	SetTimer("RandomMessage", 2 * 60 * 1000, true);
	SetTimer("CountDown", 1000, true);
	SetTimer("scoretimer", 1800000, true);
	SetTimer("stats0", 30000, true);
	SetTimer("stats1", 30000, true);
	SetTimer("HackCheck", 3000, true);
	
	print("[OnGameModeInit] Initiating pickups.");
	puBriefcaseArea51 = CreatePickup(PICKUPICON_BRIEFCASE, 2, 200.6972, 1869.6072, 13.1470, INVALID_VALUE); // Area-51
	puBriefcaseDesertAirport = CreatePickup(PICKUPICON_BRIEFCASE, 2, 423.8678, 2536.4810, 16.1484, INVALID_VALUE); // Desert Airport
	puBriefcaseQuery = CreatePickup(PICKUPICON_BRIEFCASE, 2, 681.6343, 830.9876, -42.9609, INVALID_VALUE); // Query
	RP = CreatePickup(PICKUPICON_BRIEFCASE, 2, -172.5758, 1084.9557, 19.9738, INVALID_VALUE);
	AP = CreatePickup(PICKUPICON_BRIEFCASE, 2, -815.0687, 1559.0491, 27.1172, INVALID_VALUE); // Asia
	EP = CreatePickup(PICKUPICON_BRIEFCASE, 2, 983.9799, 2179.4363, 10.9, INVALID_VALUE); // Europe
	A2P = CreatePickup(PICKUPICON_BRIEFCASE, 2, -1478.3594, 2649.9695, 55.8359, INVALID_VALUE); // Australia
	MP = CreatePickup(PICKUPICON_BRIEFCASE, 2, -258.8968, 2612.0898, 62.8582, INVALID_VALUE); // USA
	NUKE = CreatePickup(1254, 2, 213.98, 1822.96, 6.41);

	print("[OnGameModeInit] Initiating per-player 3D text labels.");
	new i;
	for (i = 0; i < MAX_PLAYERS; i ++)
	{
		t3dRankLabel[i] = Create3DTextLabel(" ", COLOR_WHITE, 30.0, 40.0, 50.0, 40.0, 0);
	}

	print("[OnGameModeInit] Initiating vehicle license plates.");
	new plate[16];
	for (i = 0; i < MAX_VEHICLES; i ++)
	{
		format(plate, sizeof(plate), "{000000}LV-%i", i);
		SetVehicleNumberPlate(i, plate);
		SetVehicleToRespawn(i);
	}

	print("[OnGameModeInit] Updating configuration.");
	UpdateConfig();
	return 1;
}

main()
{
	print(" ");
}

public OnGameModeExit()
{
	print("[OnGameModeExit]Saving all players data.");
	SaveAllPlayersData();
	
	print("[OnGameModeExit] Closing database.");
	mysql_close(gGameConnection);
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	//SendRconCommand("reloadbans");
}

public OnPlayerConnect(playerid)
{
	if (IsPlayerNPC(playerid)) return 1;

	SendDeathMessage(playerid, INVALID_PLAYER_ID, DEATHMESSAGE_CONNECT);

	for (new i = 0; i < sizeof(animations); i ++)
	{
		ApplyAnimation(playerid, animations[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
	}

	ResetPlayerData(playerid);
	TextDrawShowForPlayer(playerid, logo1);
	TextDrawShowForPlayer(playerid, logo2);
	PlayerPlaySound(playerid, SOUND_CAPTURE, 0.0, 0.0, 0.0);
	ShowPlayerLoginTextDraws(playerid);
	CreatePlayerTextdraws(playerid);
	new string[430 + MAX_PLAYER_NAME + MAX_STRING_IP + MAX_STRING_IP], playerName[MAX_PLAYER_NAME];
	format(playerData[playerid][pd_IP], MAX_STRING_IP, "%s", GetPlayerIP(playerid));
	GetPlayerName(playerid, playerName, sizeof(playerName));
	mysql_format(gGameConnection, string, sizeof(string), 
		"SELECT `accounts`.`id`, `closed_accounts`.*, (SELECT `accounts`.`name` FROM `accounts` WHERE `accounts`.`id` = `closed_accounts`.`by_account_id` LIMIT 1) as closed_by \
			FROM `accounts`, `closed_accounts` \
			WHERE (`accounts`.`name` = '%e' OR `accounts`.`ip` = '%s' OR `accounts`.`registration_ip` = '%s') AND (`accounts`.`id` = `closed_accounts`.`account_id`) LIMIT 1;", 
		playerName, playerData[playerid][pd_IP], playerData[playerid][pd_IP]);
	mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_CHECK_BAN, playerid, INVALID_VALUE, playerName, "");
	mysql_format(gGameConnection, string, sizeof(string), "SELECT `name` FROM `accounts` WHERE `name` = '%e';", playerName);
	mysql_tquery(gGameConnection, string, "OnExecuteFinish", "iiiss", THREAD_CHECK_ACCOUNT, playerid, INVALID_VALUE, "", "");
	Attach3DTextLabelToPlayer(t3dRankLabel[playerid], playerid, 0.0, 0.0, 0.5);
	RemoveAllBuildingsForPlayer(playerid);
	format(MessageStrl6, MAX_STRING, MessageStrl5);
	format(MessageStrl5, MAX_STRING, MessageStrl4);
	format(MessageStrl4, MAX_STRING, MessageStrl3);
	format(MessageStrl3, MAX_STRING, MessageStrl2);
	format(MessageStrl2, MAX_STRING, MessageStr);
	format(MessageStr, sizeof(MessageStr),"~g~[JOIN]~w~%s(%d) has ~g~joined ~w~the server.", playerName, playerid);
	format(string, sizeof(string), "%s~n~%s~n~%s~n~%s~n~%s~n~%s", MessageStrl6, MessageStrl5, MessageStrl4, MessageStrl3, MessageStrl2, MessageStr);
	TextDrawSetString(Message, string);
	SetPlayerWorldBounds(playerid, 9999.9, -9999.9, 9999.9, -9999.9);
	TextDrawShowForPlayer(playerid, Web);

	for(new i; i < sizeof gCaptureZones; i++)
	{
		if(gCaptureZones[i][E_CAPTURE_OWNER] == NO_TEAM)
			GangZoneShowForPlayer(playerid, gCaptureZones[i][E_CAPTURE_GANGZONE], COLOR_WHITE);
		else
			GangZoneShowForPlayer(playerid, gCaptureZones[i][E_CAPTURE_GANGZONE], COLOR_WHITE);

		if(gCaptureZones[i][E_CAPTURE_ATTACKER] != INVALID_PLAYER_ID)
			GangZoneFlashForPlayer(playerid, gCaptureZones[i][E_CAPTURE_GANGZONE], COLOR_WHITE);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if (IsPlayerNPC(playerid)) return 1;

	SendDeathMessage(INVALID_PLAYER_ID, playerid, DEATHMESSAGE_DISCONNECT);

	if (DuelActive)
	{
		if (IsDueling[playerid])
		{
			DuelActive = false;
			IsDueling[DuelOpponentId[playerid]] = false;
			DuelOpponentId[DuelOpponentId[playerid]] = INVALID_PLAYER_ID;
			IsDueling[playerid] = false;
			DuelOpponentId[playerid] = INVALID_PLAYER_ID;
			WinningPrice = 0;
		}
	}

	KillTimer(playerData[playerid][player_TmrSpawnProtection]);
	TextDrawDestroy(damage[playerid]);
	TextDrawDestroy(damage2[playerid]);
	format(MessageStrl6, 170, MessageStrl5);
	format(MessageStrl5, 170, MessageStrl4);
	format(MessageStrl4, 170, MessageStrl3);
	format(MessageStrl3, 170, MessageStrl2);
	format(MessageStrl2, 170, MessageStr);
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	format(MessageStr, sizeof MessageStr, "~g~[LEFT]~w~%s(%d) has ~g~left ~w~the server.", playerName, playerid);

	switch (reason)
	{
		case 0: format(MessageStr, sizeof MessageStr, "~r~[LEFT]~w~%s(%d) was ~r~timeout/crashed.", playerName, playerid);

		case 1: format(MessageStr, sizeof MessageStr, "~r~[LEFT]~w~%s(%d) has left the server.", playerName, playerid);

		case 2: format(MessageStr, sizeof MessageStr, "~r~[LEFT]~w~%s(%d) was ~r~kicked/banned.", playerName, playerid);
	}

	new string[512];
	format(string, sizeof(string), "%s~n~%s~n~%s~n~%s~n~%s~n~%s", MessageStrl6, MessageStrl5, MessageStrl4, MessageStrl3, MessageStrl2, MessageStr);
	TextDrawSetString(Message, string);
	TextDrawHideForPlayer(playerid, tdScore[playerid]);
	TextDrawHideForPlayer(playerid, Rank1[playerid]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");

	if (playerData[playerid][pd_IsLoggedIn]) SavePlayerData(playerid);

  	playerData[playerid][pd_IsLoggedIn] = 0;
	KillTimer(FreezeTimer[playerid]);

	for (new i = 0; i != MAX_PLAYER_ATTACHED_OBJECTS; ++ i)
	{
		if (IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			RemovePlayerAttachedObject(playerid, i);
		}
	}

	if (playerData[playerid][pCar] != INVALID_VALUE)
	{
		CarDeleter(playerData[playerid][pCar]);
	}

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if ((GetPlayerState(i) == PLAYER_STATE_SPECTATING) && (playerData[i][SpecID] == playerid))
		{
			AdvanceSpectate(i);
		}
	}

	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;

	// Anti client crash.
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		new Float:vec[3];
		GetPlayerCameraFrontVector(playerid, vec[0], vec[1], vec[2]);
		for (new i = 0; i < sizeof(vec); i ++)
		{
			if (floatabs(vec[i]) > 10.0)
			{
				return 0;
			}
		}
	}

	if ((GetPlayerState(playerid) != PLAYER_STATE_DRIVER) && (GetPlayerState(playerid) != PLAYER_STATE_PASSENGER))
	{
		if ((GetTickCount() - armedbody_pTick[playerid]) > 113)
		{
			AttachWeaponToPlayer(playerid);
		}
	}

	if (playerData[playerid][pd_IsOnDuty])
	{
		if (ReturnPlayerHealth(playerid) < MAX_HEALTH_ADMINISTRATOR)
		{
			SetPlayerHealth(playerid, MAX_HEALTH_ADMINISTRATOR);
		}
	}

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if (IsPlayerNPC(playerid)) return 1;

	HidePlayerGameTexts(playerid);
	HidePlayerLoginTextDraws(playerid);
	Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");

	switch (classid)
	{
		case TEAM_EUROPE: // Europe 
		{
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle(playerid, 270.0);
			PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_TEAM_EUROPE);
			PlayerTextDrawSetString(playerid, playerData[playerid][pd_TdTeamSelection], "Europe");
			playerData[playerid][pd_TeamId] = TEAM_EUROPE;
			SetPlayerTeam(playerid, TEAM_EUROPE);
			SetPlayerSkinEx(playerid, SKIN_EUROPE);
			SetPlayerColor(playerid, COLOR_TEAM_EUROPE);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");
		}

		case TEAM_ASIA: // Asia
		{
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270.0);
			PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_TEAM_ASIA);
			PlayerTextDrawSetString(playerid, playerData[playerid][pd_TdTeamSelection], "Asia");
			playerData[playerid][pd_TeamId] = TEAM_ASIA;
			SetPlayerTeam(playerid, TEAM_ASIA);
			SetPlayerSkinEx(playerid, SKIN_ASIA);
			SetPlayerColor(playerid, COLOR_TEAM_ASIA);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");
		}

		case TEAM_RUSSIA: // Russia
		{
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle(playerid, 270.0);
			PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_TEAM_RUSSIA);
			PlayerTextDrawSetString(playerid, playerData[playerid][pd_TdTeamSelection], "Russia");
			playerData[playerid][pd_TeamId] = TEAM_RUSSIA;
			SetPlayerTeam(playerid, TEAM_RUSSIA);
			SetPlayerSkinEx(playerid, SKIN_RUSSIA);
			SetPlayerColor(playerid, COLOR_TEAM_RUSSIA);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");
		}

		case TEAM_USA: // USA
		{
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270.0);
			PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_TEAM_USA);
			PlayerTextDrawSetString(playerid, playerData[playerid][pd_TdTeamSelection], "USA");
			playerData[playerid][pd_TeamId] = TEAM_USA;
			SetPlayerTeam(playerid, TEAM_USA);
			SetPlayerSkinEx(playerid, SKIN_USA);
			SetPlayerColor(playerid, COLOR_TEAM_USA);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");
		}

		case TEAM_AUSTRALIA: // Australia
		{
			SetPlayerPos(playerid, 235.0027, 1935.0090, 33.2731);
			SetPlayerCameraPos(playerid, 242.6743, 1935.2080, 35.2881);
			SetPlayerCameraLookAt(playerid, 241.6707, 1935.1802, 34.9731);
			SetPlayerFacingAngle( playerid, 270.0);
			PlayerTextDrawColor(playerid, playerData[playerid][pd_TdTeamSelection], COLOR_TEAM_AUSTRALIA);
			PlayerTextDrawSetString(playerid, playerData[playerid][pd_TdTeamSelection], "Australia");
			playerData[playerid][pd_TeamId] = TEAM_AUSTRALIA;
			SetPlayerTeam(playerid, TEAM_AUSTRALIA);
			SetPlayerSkinEx(playerid, SKIN_AUSTRALIA);
			SetPlayerColor(playerid, COLOR_TEAM_AUSTRALIA);
			Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");
		}
	}

	ShowPlayerTeamSelectionTD(playerid);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if (IsPlayerNPC(playerid)) return 1;

	new const onlineAsia = GetTeamCount(TEAM_ASIA);
	new const onlineAustralia = GetTeamCount(TEAM_AUSTRALIA);
	new const onlineEurope = GetTeamCount(TEAM_EUROPE);
	new const onlineRussia = GetTeamCount(TEAM_RUSSIA);
	new const onlineUSA = GetTeamCount(TEAM_USA);
	new string[16];

	format(string, sizeof(string), "Asia: %i", onlineAsia);
	TextDrawSetString(tdTeamCount0, string);
	format(string, sizeof(string), "Australia: %i", onlineAustralia);
	TextDrawSetString(tdTeamCount1, string);
	format(string, sizeof(string), "Europe: %i", onlineEurope);
	TextDrawSetString(tdTeamCount2, string);
	format(string, sizeof(string), "Russia: %i", onlineRussia);
	TextDrawSetString(tdTeamCount3, string);
	format(string, sizeof(string), "USA: %i", onlineUSA);
	TextDrawSetString(tdTeamCount4, string);

	/*switch (playerData[playerid][pd_TeamId])
	{
		case TEAM_EUROPE:
		{
			if (onlineEurope > onlineUSA && onlineEurope > onlineAsia && onlineEurope > onlineRussia && onlineEurope > onlineAustralia)
			{
				SendScreenMessage(playerid, "Currently this team is full");
				return 0;
			}
		}

		case TEAM_USA:
		{
			if (onlineUSA > onlineEurope && onlineUSA > onlineAsia && onlineUSA > onlineRussia && onlineUSA > onlineAustralia)
			{
				SendScreenMessage(playerid, "Currently this team is full");
				return 0;
			}
		}

		case TEAM_ASIA:
		{
			if (onlineAsia > onlineUSA && onlineAsia > onlineEurope && onlineAsia > onlineRussia && onlineAsia > onlineAustralia)
			{
				SendScreenMessage(playerid, "Currently this team is full");
				return 0;
			}
		}

		case TEAM_RUSSIA:
		{
			if (onlineRussia > onlineUSA && onlineRussia > onlineAsia && onlineRussia > onlineEurope && onlineRussia > onlineAustralia)
			{
				SendScreenMessage(playerid, "Currently this team is full");
				return 0;
			}
		}

		case TEAM_AUSTRALIA:
		{
			if (onlineAustralia > onlineUSA && onlineAustralia > onlineAsia && onlineAustralia > onlineEurope && onlineAustralia > onlineRussia)
			{
				SendScreenMessage(playerid, "Currently this team is full");
				return 0;
			}
		}
	}*/

	HidePlayerTeamSelectionTD(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if (IsPlayerNPC(playerid)) return 1;

	StopAllPlayerSound(playerid);
	TextDrawShowForPlayer(playerid, mbox);
	TextDrawShowForPlayer(playerid, Message);
	UpdateLabelText(playerid);
	TextDrawShowForPlayer(playerid, tdScore[playerid]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	ResetPlayerWeaponsEx(playerid);

	if (IsSpectating[playerid])
	{
		for (new i = 0; i < TOTAL_SLOT_WEAPON; i ++)
		{
			if (playerData[playerid][previousWeapons][i])
			{
				GivePlayerWeaponEx(playerid, playerData[playerid][previousWeapons][i], playerData[playerid][previousAmmoLots][i]);
			}
		}
		SetPlayerArmedWeapon(playerid, ArmedWeapon[playerid]);
		SetPlayerPos(playerid, playerData[playerid][pd_PreviousX], playerData[playerid][pd_PreviousY], playerData[playerid][pd_PreviousZ]);
		SetPlayerArmour(playerid, playerData[playerid][pd_PreviousArmor]);
		SetPlayerHealth(playerid, playerData[playerid][pd_PreviousHealth]);
		SetPlayerVirtualWorld(playerid, playerData[playerid][pd_PreviousVW]);
		SetPlayerInterior(playerid, playerData[playerid][pd_PreviousInterior]);
		SetCameraBehindPlayer(playerid);
		IsSpectating[playerid] = false;
		if (pHasHelmet[playerid])
		{
			new const SKIN_ID = GetPlayerSkin(playerid);
			SetPlayerAttachedObject(playerid, SLOT_PAO_HAT, 19108, BONE_HEAD, gHelmetOffsets[SKIN_ID][0], gHelmetOffsets[SKIN_ID][1], gHelmetOffsets[SKIN_ID][2], gHelmetOffsets[SKIN_ID][3], gHelmetOffsets[SKIN_ID][4], gHelmetOffsets[SKIN_ID][5], gHelmetOffsets[SKIN_ID][6], gHelmetOffsets[SKIN_ID][7], gHelmetOffsets[SKIN_ID][8]);
		}
		return 1;
	}

	RemovePlayerAttachedObject(playerid, SLOT_PAO_HAT);
	pHasHelmet[playerid] = false;
	SetPlayerHealth(playerid, MAX_HEALTH_PLAYERSPAWN);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	AntiSK[playerid] = 1;

	if (FirstSpawn[playerid])
	{
		DisplayPlayerDialog(playerid, DIALOG_CLASSSELECTION);
	}

	switch (playerData[playerid][pd_TeamId])
	{
		case TEAM_EUROPE:
		{
			new const rand = random(sizeof(EuropeSpawn));
			SetPlayerPos(playerid, EuropeSpawn[rand][0], EuropeSpawn[rand][1], EuropeSpawn[rand][2]);
			SetPlayerTeam(playerid, TEAM_EUROPE);
			SetPlayerColor(playerid, COLOR_TEAM_EUROPE);
		}

		case TEAM_RUSSIA:
		{
			new const rand = random(sizeof(lstRussianSpawns));
			SetPlayerPos(playerid, lstRussianSpawns[rand][0], lstRussianSpawns[rand][1], lstRussianSpawns[rand][2]);
			SetPlayerTeam(playerid, TEAM_RUSSIA);
			SetPlayerColor(playerid, COLOR_TEAM_RUSSIA);
		}

		case TEAM_ASIA:
		{
			new const rand = random(sizeof(lstASIASpawns));
			SetPlayerPos(playerid, lstASIASpawns[rand][0], lstASIASpawns[rand][1], lstASIASpawns[rand][2]);
			SetPlayerTeam(playerid, TEAM_ASIA);
			SetPlayerColor(playerid, COLOR_TEAM_ASIA);
		}

		case TEAM_AUSTRALIA:
		{
			new const rand = random(sizeof(AusSpawn));
			SetPlayerPos(playerid, AusSpawn[rand][0], AusSpawn[rand][1], AusSpawn[rand][2]);
			SetPlayerTeam(playerid, TEAM_AUSTRALIA);
			SetPlayerColor(playerid, COLOR_TEAM_AUSTRALIA);
		}

		case TEAM_USA:
		{
			new const rand = random(sizeof(USSpawn));
			SetPlayerPos(playerid, USSpawn[rand][0], USSpawn[rand][1], USSpawn[rand][2]);
			SetPlayerTeam(playerid, TEAM_USA);
			SetPlayerColor(playerid, COLOR_TEAM_USA);
		}
	}

	playerData[playerid][player_TmrSpawnProtection] = SetTimerEx("SpawnProtection", 5000, false, "i", playerid);
	SendClientMessage(playerid, COLOR_HINT, "[HINT] You can press ~k~~CONVERSATION_NO~ key to finish Anti-Spawn protection.");
	new str1[MAX_STRING];
	format(str1, sizeof(str1), "~w~KILLS: ~r~%d~n~~w~DEATHS: ~r~%d~n~~w~RANK: ~y~%s~n~~w~CLASS: ~b~%s", playerData[playerid][pd_Kills], playerData[playerid][pd_Deaths], GetPlayerRankName(playerid), GetPlayerClassName(playerid));
	TextDrawSetString(Rank1[playerid], str1);
	TextDrawShowForPlayer(playerid, Rank1[playerid]);
	format(str1, sizeof(str1),"~y~SCORE: %i", GetPlayerScore(playerid));
	TextDrawSetString(tdScore[playerid], str1);
	TextDrawShowForPlayer(playerid, tdScore[playerid]);

	if (playerData[playerid][pd_IsOnDuty])
	{
		SetPlayerTeam(playerid, NO_TEAM);
		SetPlayerHealth(playerid, MAX_HEALTH_ADMINISTRATOR);
		SetPlayerColor(playerid, COLOR_ADMIN);
		SetPlayerSkinEx(playerid, SKIN_STAFF);
	}

	if (playerData[playerid][Frozen])
	{
		TogglePlayerControllable(playerid, false);
		SendScreenMessage(playerid, "You cant escape your punishment. You Are Still Frozen");
	}

	if (playerData[playerid][JailTime])
	{
		JailPlayer(playerid);
		SendScreenMessage(playerid, "You cant escape your punishment. You Are Still In Jail");
	}

	GangZoneShowForPlayer(playerid, zoneUSABase, COLOR_ZONE_USA);
	GangZoneShowForPlayer(playerid, zoneAustraliaBase, COLOR_ZONE_AUSTRALIA);
	GangZoneShowForPlayer(playerid, zoneEuropeBase, COLOR_ZONE_EUROPE);
	GangZoneShowForPlayer(playerid, zoneRussianBase, COLOR_ZONE_RUSSIA);
	GangZoneShowForPlayer(playerid, zoneASIABase, COLOR_ZONE_ASIA);
	
	// Briefcases
	SetPlayerMapIcon(playerid, 31, -172.5758, 1084.9557, 19.9738, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 32, -815.0687, 1559.0491, 27.1172, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // Asia
	SetPlayerMapIcon(playerid, 33, 983.9799, 2179.4363, 10.9, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL);
	SetPlayerMapIcon(playerid, 34, -1478.3594, 2649.9695, 55.8359, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // Australia
	SetPlayerMapIcon(playerid, 35, -258.8968, 2612.0898, 62.8582, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // USA
	SetPlayerMapIcon(playerid, 36, 200.6972, 1869.6072, 13.1470, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // Area-51
	SetPlayerMapIcon(playerid, 37, 423.8678, 2536.4810, 16.1484, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // Desert Airport
	SetPlayerMapIcon(playerid, 38, 681.6343, 830.9876, -42.9609, MAPICON_AMMUNATION, INVALID_VALUE, MAPICON_LOCAL); // Quarry
	SetPlayerMapIcon(playerid, 39, -24.6556, 1545.8770, 11.9568, MAPICON_REDFLAG, INVALID_VALUE, MAPICON_LOCAL); // ZONE_OILSUPPLEMENTBASE
	SetPlayerMapIcon(playerid, 40, 705.8604, 1953.3015, 4.9099, MAPICON_REDFLAG, INVALID_VALUE, MAPICON_LOCAL); // ZONE_MANSION
	SetPlayerMapIcon(playerid, 41, 410.0034, 2252.4912, 39.7248, MAPICON_REDFLAG, INVALID_VALUE, MAPICON_LOCAL); // ZONE_WAREHOUSE
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if (IsPlayerNPC(playerid)) return 1;

	// Anti fake-kill.
	if (IsPlayerInGame(killerid))
	{
		if (GetPlayerWeapon(killerid) != reason)
		{
			if (!IsPlayerInRangeOfPlayer(killerid, playerid, 350.0) || ((reason == WEAPON_VEHICLE) && !IsPlayerInAnyVehicle(killerid)) || ((reason == DEATHMESSAGE_EXPLOSION) && !IsPlayerInAnyVehicle(playerid))) return 1;
		}
	}

	StopAllPlayerSound(playerid);
	HideVehicleNameTD(playerid);

	if (killerid != INVALID_PLAYER_ID)
	{
		if (Captureing{playerid} == true)
		{
			GivePlayerScore(killerid, 1);
		}
		if (reason == DEATHMESSAGE_HELICOPTERBLADES)
		{
			SetPlayerHealth(killerid, 0.0);
			new Name[MAX_PLAYER_NAME], Message1[MAX_STRING];
			GetPlayerName(killerid, Name, sizeof(Name));
			format(Message1, sizeof(Message1), "[SERVER] %s(%i) has been fined by server, reason: Heli-Blade/Car Parking.", Name, playerid);
			SendClientMessageToAll(COLOR_SERVER, Message1);
			SendClientMessage(killerid, COLOR_NOTIFY, "   You have been killed and fined by server due to Heli-Blade/Car Parking.");
			TakePlayerCash(playerid, 5000);
			TakePlayerScore(killerid, 5);
		}
	}

 	if (playerData[playerid][pd_ClassId] == CLASS_DEMOLISHER)
	{
		new Float:APos[3];
		GetPlayerPos(playerid, APos[0], APos[1], APos[2]);
		CreateExplosion(APos[0], APos[1], APos[2], 7, 10.0);
	}

	if (DuelActive == true)
	{
		if (IsDueling[playerid])
		{
			DuelActive = false;
			if ((killerid != INVALID_PLAYER_ID) && (killerid != playerid))
			{
				IsDueling[playerid] = false;
				IsDueling[killerid] = false;
				new string[MAX_STRING];
				format(string, sizeof(string), "[ARENA] %s(%i) has defeated %s(%i) in duel and won $%i!", ReturnPlayerName(killerid), killerid, ReturnPlayerName(playerid), playerid, WinningPrice);
				SendClientMessageToAll(COLOR_NEWS, string);
				GameTextForPlayer(killerid, "~g~YOU WON!", 3000, 5);
				SetPlayerInterior(killerid, 0);
				ResetPlayerWeaponsEx(killerid);
				RemovePlayerFromVehicle(killerid);
				SpawnPlayer(killerid);
				TakePlayerCash(playerid, WinningPrice);
				GivePlayerCash(killerid, WinningPrice);
			}
		}
	}

	Update3DTextLabelText(t3dRankLabel[playerid], COLOR_WHITE, " ");

	if (IsPlayerInArea(playerid, -353.515625,2574.21875,-113.28125,2796.875))
	{
		if (playerData[playerid][pd_TeamId] == TEAM_USA)
		{
			if (IsPlayerInAnyVehicle(killerid))
			{
				new const vehicleModelId = GetVehicleModel(GetPlayerVehicleID(killerid));
				if ((vehicleModelId == 432) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
				{
					new message[MAX_STRING];
					format(message, sizeof(message), "[SERVER] %s(%i) has been kicked by server, reason: Spawn killing.", ReturnPlayerName(killerid), killerid);
					SendClientMessageToAll(COLOR_SERVER, message);
					SetTimerEx("KickEx", TIMER_KICK, false, "i", killerid);
				}
			}
		}
	}
	else if (IsPlayerInArea(playerid, 994.1957, 1817.512, 1185.533, 2049.596))
	{
		if (playerData[playerid][pd_TeamId] == TEAM_EUROPE)
		{
			if (IsPlayerInAnyVehicle(killerid))
			{
				new const vehicleModelId = GetVehicleModel(GetPlayerVehicleID(killerid));
				if ((vehicleModelId == 432) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
				{
					SetPlayerHealth(killerid, 0.0);
					SendClientMessage(killerid, COLOR_NOTIFY,"   You have been killed by server due to spawn-killing.");
				}
			}
		}
	}
	else if (IsPlayerInArea(playerid, 89.0,2418.75,466.40625,2617.96875))
	{
		if (playerData[playerid][pd_TeamId] == TEAM_AUSTRALIA)
		{
			if (IsPlayerInAnyVehicle(killerid))
			{
				new const vehicleModelId = GetVehicleModel(GetPlayerVehicleID(killerid));
				if ((vehicleModelId == 432) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
				{
					SetPlayerHealth(killerid, 0.0);
					SendClientMessage(killerid, COLOR_NOTIFY,"   You have been killed by server due to spawn-killing.");
				}
			}
		}
	}
	else if (IsPlayerInArea(playerid, -309.375,1024.21875,103.125,1211.71875))
	{
		if (playerData[playerid][pd_TeamId] == TEAM_RUSSIA)
		{
			if (IsPlayerInAnyVehicle(killerid))
			{
				new const vehicleModelId = GetVehicleModel(GetPlayerVehicleID(killerid));
				if ((vehicleModelId == 432) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
				{
					SetPlayerHealth(killerid, 0.0);
					SendClientMessage(killerid, COLOR_NOTIFY,"   You have been killed by server due to spawn-killing.");
				}
			}
		}
	}
	else if (IsPlayerInArea(playerid, -875.8406, 1389.667, -607.2495, 1623.225))
	{
		if (playerData[playerid][pd_TeamId] == TEAM_ASIA)
		{
			if (IsPlayerInAnyVehicle(killerid))
			{
				new const vehicleModelId = GetVehicleModel(GetPlayerVehicleID(killerid));
				if ((vehicleModelId == 432) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
				{
					SetPlayerHealth(killerid, 0.0);
					SendClientMessage(killerid, COLOR_NOTIFY,"   You have been killed by server due to spawn-killing.");
				}
			}
		}
	}

	SendDeathMessage(killerid, playerid, reason);
	Streak[playerid] = 0;

	if (killerid != INVALID_PLAYER_ID)
	{
		GivePlayerCash(killerid, 2000);
		SendClientMessage(killerid, COLOR_REWARD, "You have got $2,000 money, 1 score and some ammo!");
		new const weaponId = GetPlayerWeapon(killerid);
		switch (weaponId)
		{
			case WEAPON_GOLFCLUB .. WEAPON_CANE: GivePlayerWeaponEx(killerid, GetPlayerWeapon(killerid), 1);

			case WEAPON_GRENADE .. WEAPON_MOLTOV: GivePlayerWeaponEx(killerid, GetPlayerWeapon(killerid), 1);

			case WEAPON_COLT45 .. WEAPON_SNIPER: GivePlayerWeaponEx(killerid, GetPlayerWeapon(killerid), 50);

			case WEAPON_ROCKETLAUNCHER .. WEAPON_PARACHUTE: GivePlayerWeaponEx(killerid, GetPlayerWeapon(killerid), 1);
		}
		GivePlayerScore(killerid, 1);
		Streak[killerid] ++;
		playerData[killerid][pd_KillingSpree] ++;
		if (Streak[killerid] == 3)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $1,500 money and 3 scores! (bonus)");
			GivePlayerCash(killerid, 1500);
			GivePlayerScore(killerid, 3);
		}
		else if (Streak[killerid] == 5)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $2500 and 5 scores! (bonus)");
			GivePlayerCash(killerid, 2500);
			GivePlayerScore(killerid, 5);
		}
		else if (Streak[killerid] == 10)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $5,000 money and 10 scores! (bonus)");
			GivePlayerCash(killerid, 5000);
			GivePlayerScore(killerid, 10);
		}
		else if (Streak[killerid] == 15)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $7,500 money and 15 scores! (bonus)");
			GivePlayerCash(killerid, 7500);
			GivePlayerScore(killerid, 15);
		}
		if (Streak[killerid] == 20)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $12,500 money and 20 scores! (bonus)");
			GivePlayerCash(killerid, 12500);
			GivePlayerScore(killerid, 20);
		}
		else if (Streak[killerid] == 25)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $20,000 money and 25 scores! (bonus)");
			GivePlayerCash(killerid, 20000);
			GivePlayerScore(killerid, 25);
		}
		else if (Streak[killerid] == 50)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $50,000 money and 50 scores! (bonus)");
			GivePlayerCash(killerid, 50000);
			GivePlayerScore(killerid, 50);
		}
		else if (Streak[killerid] == 100)
		{
			SendClientMessage(killerid, COLOR_REWARD, "You have got $100,000 money and 50 scores! (bonus)");
			GivePlayerCash(killerid, 100000);
			GivePlayerScore(killerid, 50);
		}
		playerData[killerid][pd_Kills] ++;
	}

	playerData[playerid][pd_Deaths] ++;

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if ((GetPlayerState(i) == PLAYER_STATE_SPECTATING) && (playerData[i][SpecID] == playerid))
		{
			AdvanceSpectate(i);
		}
	}

	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	if (IsPlayerNPC(playerid)) return 1;

	if (issuerid != INVALID_PLAYER_ID)
	{
		new string[64];
		KillTimer(TempoMostrarLife2[playerid]);
		TextDrawShowForPlayer(playerid, damage2[playerid]);
		format(string, sizeof(string), "~r~%s -%.2f ~n~~r~%s", ReturnPlayerName(issuerid), amount, ReturnWeaponName(weaponid));
		TextDrawSetString(damage2[playerid], string);
		TempoMostrarLife2[playerid] = SetTimerEx("HideTextoLife2", 3000, 0, "i", playerid);
		MostrandoVida2[playerid] = 1;
		KillTimer(TempoMostrarLife[issuerid]);
		TextDrawShowForPlayer(issuerid, damage[issuerid]);
		format(string, sizeof(string), "~g~%s -%.2f ~n~~g~%s", ReturnPlayerName(playerid), amount, ReturnWeaponName(weaponid));
		TextDrawSetString(damage[issuerid], string);
		TempoMostrarLife[issuerid] = SetTimerEx("HideTextoLife", 3000, 0, "i", issuerid);
		MostrandoVida[issuerid] = 1;
		PlayerPlaySound(issuerid , 17802, 0.0, 0.0, 0.0);
		// Headshot
		if (gHeadshotState && !AntiSK[playerid] && ((GetPlayerTeam(issuerid) != GetPlayerTeam(playerid)) || IsDueling[issuerid]) && ((weaponid == WEAPON_SNIPER) || (weaponid == WEAPON_RIFLE)) && (bodypart == BODYPART_HEAD) && !playerData[playerid][pd_IsOnDuty])
		{
			if (!pHasHelmet[playerid])
			{
				SetPlayerHealth(playerid, 0.0);
				SetPlayerHealth(playerid, 0.0);
				if (IsDueling[playerid])
				{
					IsDueling[playerid] = false;
					IsDueling[issuerid] = false;
					DuelActive = false;
				}
				GameTextForPlayer(playerid, "~r~HEADSHOT!", 3000, GAMETEXTSTYLE_TYPE3);
				GameTextForPlayer(issuerid, "~g~HEADSHOT!", 3000, GAMETEXTSTYLE_TYPE3);
				GivePlayerScore(issuerid, 2);
				playerData[issuerid][Headshots] ++;
				SendClientMessage(issuerid, COLOR_REWARD, "You have successfully headshotted the target and earned +2 score.");
			}
			else
			{
				GameTextForPlayer(playerid, "~r~HELMET BROKEN!", 3000, GAMETEXTSTYLE_TYPE3);
				pHasHelmet[playerid] = false;
			}
			RemovePlayerAttachedObject(playerid, SLOT_PAO_HAT);
		}
		if (GetPlayerTeam(issuerid) != GetPlayerTeam(playerid))
		{
			if ((weaponid == WEAPON_KNIFE) && (bodypart == BODYPART_HEAD))
			{
				SetPlayerHealth(playerid, 0.0);
			}
		}
		format(string, sizeof(string), "-%.0f", amount);
		SetPlayerChatBubble(playerid, string, COLOR_DAMAGEBUBBLE, 100.0, 2000);
	}

	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if (IsPlayerNPC(playerid)) return 1;

	if (!IsPlayerInGame(playerid) || !IsPlayerInGame(damagedid))
	{
		return 1;
	}

	if ((weaponid != WEAPON_MOLTOV) && (weaponid != WEAPON_FIST) && (weaponid != WEAPON_FLAMETHROWER) && (weaponid != WEAPON_SPRAYCAN) && (weaponid != WEAPON_FIREEXTINGUISHER))
	{
		PlayerPlaySound(playerid, SOUND_HITPLAYER, 0.0, 0.0, 0.0);
	}

	if (playerData[damagedid][pd_IsOnDuty] || playerData[damagedid][God])
	{
		GameTextForPlayer(playerid, "~r~Don't attack on-duty staff", 3000, GAMETEXTSTYLE_TYPE3);
	}

	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (IsPlayerNPC(playerid)) return 0;

	if (!playerData[playerid][pd_IsLoggedIn] || (!IsSpectating[playerid] && !IsPlayerSpawned(playerid)) || IsPlayerDead(playerid))
	{
		return 0; // Returning 0 will disable the default chat.
	}

	if ((strfind(text, "hacker", true) != INVALID_VALUE) && !IsPlayerStaff(playerid))
	{
		SendClientMessage(playerid, COLOR_TIP, "[TIP] You can use '/report' to report hackers.");
	}

	if (playerData[playerid][Muted])
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_CANTSPEAKMUTED);
		return 0;
	}

	for (new i = 0; i < sizeof(b_word); i ++)
	{
		if (strfind(text, b_word[i], true) != INVALID_VALUE)
		{
			SendScreenMessage(playerid, "[TIP] Swearing and using bad words are not allowed");
			return 0;
		}
	}

	new playerName[MAX_PLAYER_NAME], string[MAX_STRING];
	GetPlayerName(playerid, playerName, sizeof(playerName));

	if (text[0] == '.' && playerData[playerid][pd_AdminRank])
	{
		format(string, sizeof(string), "[ADMIN CHAT] %s(%i): %s", playerName, playerid, text[1]);
		SendMessageToRAdmins(COLOR_ADMINCHAT, string);
		return 0;
	}

	if (text[0] == '$' && (playerData[playerid][pd_AdminRank] >= 4))
	{
		format(string, sizeof(string), "[L4 ADMIN CHAT] %s(%i): %s", playerName, playerid, text[1]);
		SendMessageTo4(COLOR_ADMINCHAT, string);
		return 0;
	}

	if (text[0] == '@' && (playerData[playerid][pd_AdminRank] >= 5))
	{
		format(string, sizeof(string), "[L5 ADMIN CHAT] %s(%i): %s", playerName, playerid, text[1]);
		SendMessageTo5(COLOR_ADMINCHAT, string);
		return 0;
	}

	if (ServerInfo[DisableChat] == 1)
	{
		SendScreenMessage(playerid, "The chat is disabled");
		return 0;
	}

	switch (playerData[playerid][pd_IsOnDuty])
	{
		case 0:
		{
			format(string, sizeof(string), "%s(%i): {FFFFFF}%s", playerName, playerid, text);
			SendClientMessageToAll(GetTeamColor(playerData[playerid][pd_TeamId]), string);
			SetPlayerChatBubble(playerid, text, COLOR_WHITE, 100.0, 10000);
			return 0;
		}

		case 1:
		{
			format(string, sizeof(string), "%s %s(%i): {FFFFFF}%s", GetStaffClassName(playerid), playerName, playerid, text);
			SendClientMessageToAll(COLOR_ADMINCHAT, string);
			return 0;
		}
	}

	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if (IsPlayerNPC(playerid)) return 1;

	if (pickupid == RP || pickupid == EP || pickupid == AP || pickupid == A2P || pickupid == MP || pickupid == puBriefcaseArea51 || pickupid == puBriefcaseDesertAirport || pickupid == puBriefcaseQuery)
	{
		DisplayPlayerDialog(playerid, DIALOG_SHOP);
	}
	else if (pickupid == NUKE)
	{
		if (nuke_time > 0)
		{
			new String[MAX_STRING_SHORT];
			format(String, sizeof(String), "Nuke is not ready for launch, wait %d seconds", nuke_time);
			SendScreenMessage(playerid, String);
			return 1;
		}
		
		if (gCaptureZones[20][E_CAPTURE_OWNER] == playerData[playerid][pd_TeamId])
		{
			ShowPlayerDialog(playerid, DIALOG_NUKE, DIALOG_STYLE_LIST, "Nuke Station (Area 51)", 
				"" COLOR_INLINE_USA LOCALE_TEAMNAME_USA "\n" COLOR_INLINE_EUROPE LOCALE_TEAMNAME_EUROPE "\n" COLOR_INLINE_ASIA LOCALE_TEAMNAME_ASIA "\n" COLOR_INLINE_RUSSIA LOCALE_TEAMNAME_RUSSIA "\n" COLOR_INLINE_AUSTRALIA LOCALE_TEAMNAME_AUSTRALIA, 
				"Launch!", "Cancel");
		}
		else
		{
			SendScreenMessage(playerid, "Your team doesn't own Area-51");
		}
	}

	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_FIRE))
	{
		if (IsPlayerInAnyVehicle(playerid))
		{
			if (!IsDriveByWeapon(GetPlayerWeapon(playerid)) || IsPlayerDriver(playerid) || !HasVehicleDriver(GetPlayerVehicleID(playerid)))
			{
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
			}
		}
	}

	if (IsPlayerUsingAnims[playerid])
	{
		IsPlayerUsingAnims[playerid] = 0;
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
	}

	if ((GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) && playerData[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		if (newkeys == KEY_JUMP) AdvanceSpectate(playerid);
		else if (newkeys == KEY_SPRINT) ReverseSpectate(playerid);
	}

	if (newkeys & KEY_YES)
	{
		new const vehicleid = GetPlayerVehicleID(playerid), AirCraft = GetVehicleModel(vehicleid);
		if (AirCraft == VEHICLE_HYDRA || AirCraft == 447 || AirCraft == 425 || AirCraft == 460 || AirCraft == 476 || AirCraft == 487 || AirCraft == 488 || AirCraft == 497 || AirCraft == 511 || AirCraft == 512 ||  AirCraft ==513 || AirCraft == 519 || AirCraft == 548 || AirCraft == 469 || AirCraft == 553 || AirCraft == 563 || AirCraft == 577 || AirCraft == 592 || AirCraft == 593)
		{
			new Float:x, Float:y, Float:z;
			GetVehiclePos(vehicleid,x,y,z);
			SetPlayerPos(playerid,x,y,z+100.0);
			GivePlayerWeaponEx(playerid, WEAPON_PARACHUTE , 1);
			GameTextForPlayer(playerid, "EJECTED!", 3000, 4);
		}
   }

	if (newkeys & KEY_NO)
	{
		if (AntiSK[playerid] == 1)
		{
			KillTimer(playerData[playerid][player_TmrSpawnProtection]);
			SpawnProtection(playerid);
		}
	}

	new vehicleModelId = GetVehicleModel(GetPlayerVehicleID(playerid));

	if ((playerData[playerid][pd_ClassId] != CLASS_ENGINEER) && (playerData[playerid][pd_ClassId] != CLASS_DONATOR) && !playerData[playerid][pd_IsOnDuty])
	{
		if (vehicleModelId == 432)
		{
			SendScreenMessage(playerid, "You need to be Engineer or VIP to drive this vehicle");
			RemovePlayerFromVehicle(playerid);
		}
	}

	if (playerData[playerid][pd_ClassId] != CLASS_PILOT && playerData[playerid][pd_ClassId] != CLASS_DONATOR && !playerData[playerid][pd_IsOnDuty])
	{
		if ((vehicleModelId == 447) || (vehicleModelId == VEHICLE_HYDRA) || (vehicleModelId == 425))
		{
			SendScreenMessage(playerid, "You need to be Pilot or VIP to drive this vehicle");
			RemovePlayerFromVehicle(playerid);
		}
	}

	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (IsPlayerAdmin(playerid) || playerData[playerid][pd_IsOnDuty])
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ + 3.0);
		StopAllPlayerSound(playerid);
	}

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(IsPlayerNPC(playerid)) return 1;

	VID[playerid] = vehicleid;
	SetPlayerArmedWeapon(playerid, WEAPON_FIST);

	// Anti team vehicle jack.
	if (!ispassenger)
	{
		new target = INVALID_PLAYER_ID;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid && GetPlayerVehicleID(i) == vehicleid && GetPlayerVehicleSeat(i) == 0)
			{
				target = i;
				continue;
			}
		}
		if (target != INVALID_PLAYER_ID && GetPlayerTeam(playerid) != NO_TEAM && GetPlayerTeam(playerid) == GetPlayerTeam(target))
		{
			ClearAnimations(playerid);
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			SetPlayerPos(playerid, x, y, z + 5);
			return 0;
	 	}
	}

	VID[playerid] = vehicleid;

	if (HV == 0)
	{
		new const vehicleModelId = GetVehicleModel(vehicleid);
		if ((vehicleModelId == 432 || vehicleModelId == 447 || vehicleModelId == VEHICLE_HYDRA || vehicleModelId == 425) && !playerData[playerid][pd_IsOnDuty])
		{
			Slap(playerid);
			SendScreenMessage(playerid, "Its No Heavy Vehicles Week");
		}
	}

	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(IsPlayerNPC(playerid)) return 1;

	if ((fX > 2140000000) || (fY > 2140000000) || (fZ > 2140000000))
	{
		new String[MAX_STRING];
		format(String, sizeof(String), "[ALERT] %s(%i) has been kicked by server, reason: Invalid bullet shots. (Client-crash)", ReturnPlayerName(playerid), playerid);
		MessageToAdmins(COLOR_ALERT, String);
		Kick(playerid);
		return 0; // Desync the shot.
	}

	// Anti drive-by.
	if (IsPlayerInAnyVehicle(playerid))
	{
		if (!IsDriveByWeapon(GetPlayerWeapon(playerid)) || IsPlayerDriver(playerid) || !HasVehicleDriver(GetPlayerVehicleID(playerid)))
		{
			SetPlayerArmedWeapon(playerid, WEAPON_FIST);
			return 0; // Desync the shot.
		}
	}

	if (hittype == BULLET_HIT_TYPE_VEHICLE)
	{
		new target = INVALID_PLAYER_ID;
		for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
		{
			if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
			if (i != playerid && GetPlayerVehicleID(i) == hitid && GetPlayerVehicleSeat(i) == 0)
			{
				target = i;
				continue;
			}
		}
		if (target != INVALID_PLAYER_ID && GetPlayerTeam(playerid) != NO_TEAM && GetPlayerTeam(playerid) == GetPlayerTeam(target))
		{
			return 0;
		}
	}

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(IsPlayerNPC(playerid)) return 1;

	switch (newstate)
	{
		case PLAYER_STATE_SPECTATING:
		{
			SetPlayerArmedWeapon(playerid, WEAPON_FIST);
		}

		case PLAYER_STATE_ONFOOT:
		{
			StopAllPlayerSound(playerid);
			HideVehicleNameTD(playerid);
			SetPlayerArmedWeapon(playerid, ArmedWeapon[playerid]);
			switch (oldstate)
			{
				case PLAYER_STATE_DRIVER: OnPlayerExitVehicle(playerid, 255);

				case PLAYER_STATE_PASSENGER: OnPlayerExitVehicle(playerid, 255);
			}
		}

		case PLAYER_STATE_PASSENGER:
		{
			ArmedWeapon[playerid] = GetPlayerWeapon(playerid);
			new const vehicleId = GetPlayerVehicleID(playerid);
			if (!IsDriveByWeapon(ArmedWeapon[playerid]) || IsPlayerDriver(playerid) || !HasVehicleDriver(vehicleId))
			{
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
			}
			if (IsVehiclePlane(vehicleId) || IsVehicleHelicopter(vehicleId))
			{
				SendClientMessage(playerid, COLOR_HINT, "[HINT] You can press ~k~~CONVERSATION_YES~ to eject yourself.");
			}
		}
	}

	if (newstate == PLAYER_STATE_DRIVER)
	{
		new const vehicleId = GetPlayerVehicleID(playerid);
		new const vehicleModelId = GetVehicleModel(vehicleId);
		ShowVehicleNameTD(playerid, vehicleModelId);
		ArmedWeapon[playerid] = GetPlayerWeapon(playerid);
		SetPlayerArmedWeapon(playerid, WEAPON_FIST);
		if (IsVehiclePlane(vehicleId) || IsVehicleHelicopter(vehicleId))
		{
			SendClientMessage(playerid, COLOR_HINT, "[HINT] You can press ~k~~CONVERSATION_YES~ to eject yourself.");
		}
		switch (vehicleModelId)
		{
			case 432:
			{
				if (playerData[playerid][pd_ClassId] != CLASS_ENGINEER && playerData[playerid][pd_ClassId] != CLASS_DONATOR && !playerData[playerid][pd_IsOnDuty])
				{
					SendScreenMessage(playerid, "You need to be Engineer or VIP to use this vehicle");
					RemovePlayerFromVehicle(playerid);
				}
			}

			case 447, VEHICLE_HYDRA, 425:
			{
				if (playerData[playerid][pd_ClassId] != CLASS_PILOT && playerData[playerid][pd_ClassId] != CLASS_DONATOR && !playerData[playerid][pd_IsOnDuty])
				{
					SendScreenMessage(playerid, "You must be Pilot or VIP to use this vehicle");
					RemovePlayerFromVehicle(playerid);
				}
			}
		}
	}

	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if (playerData[playerid][DoorsLocked] == 1) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), playerid, false, false);

	return 1;
}

public OnVehicleDeath(vehicleid)
{
	if (heliobjects[vehicleid][0] != INVALID_VALUE)
	{
		DestroyObject(heliobjects[vehicleid][0]);
		DestroyObject(heliobjects[vehicleid][1]);
		heliobjects[vehicleid][0] = 0;
		heliobjects[vehicleid][1] = 0;
	}

	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (vehicleid == playerData[i][pCar])
		{
			CarDeleter(vehicleid);
			playerData[i][pCar] = -1;
		}
	}

	if (heliobjects[vehicleid][0] != INVALID_VALUE)
	{
		DestroyObject(heliobjects[vehicleid][0]);
		DestroyObject(heliobjects[vehicleid][1]);
		heliobjects[vehicleid][0] = 0;
		heliobjects[vehicleid][1] = 0;
	}

	switch (GetVehicleModel(vehicleid))
	{
		case 609:
		{
			AddVehicleComponent(vehicleid, COMPONENT_OFFROADWHEEL);
		}

		case VEHICLE_HYDRA, 425, 447:
		{
			SetVehicleHealth(vehicleid, 500);
		}

		case 432, 427, 528:
		{
			SetVehicleHealth(vehicleid, 1500);
		}
	}

	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case DIALOG_REGISTER:
		{
			if (response)
			{
				if (IsSavingAllStats)
				{
					DisplayPlayerDialog(playerid, DIALOG_REGISTER);
					SendScreenMessage(playerid, LOCALE_MESSAGE_CANTDOTHATRIGHTNOW);
				}
				else if (!IsValidPassword(inputtext, MAX_STRING_PASSWORD))
				{
					DisplayPlayerDialog(playerid, DIALOG_REGISTER_ISSUE);
					playerData[playerid][LoginAttempts] ++;
					if (playerData[playerid][LoginAttempts] >= MAX_FAILEDLOGINREGISTER)
					{
						HideAllPlayerDialog(playerid);
						SendScreenMessage(playerid, "Too many registration failures, try again later");
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
						SetTimerEx("KickEx", 100, false, "i", playerid);
					}
				}
				else
				{
					new query[160 + MAX_PLAYER_NAME + MAX_STRING_IP + MAX_STRING_IP];
					mysql_format(gGameConnection, query, sizeof(query), "INSERT INTO `accounts` (`name`, `password`, `ip`, `registration_ip`) VALUES ('%e', SHA1('%e'), '%s', '%s');", ReturnPlayerName(playerid), inputtext, playerData[playerid][pd_IP], playerData[playerid][pd_IP]);
					mysql_tquery(gGameConnection, query, "OnExecuteFinish", "iiiss", THREAD_INSERT_ACCOUNT, playerid, INVALID_VALUE, "", "");
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
				SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
			}
			return 1;
		}

		case DIALOG_LOGIN:
		{
			if (response)
			{
				if (IsSavingAllStats)
				{
					DisplayPlayerDialog(playerid, DIALOG_LOGIN);
					SendScreenMessage(playerid, LOCALE_MESSAGE_CANTDOTHATRIGHTNOW);
				}
				else if (!IsValidPassword(inputtext, MAX_STRING_PASSWORD))
				{
					DisplayPlayerDialog(playerid, DIALOG_LOGIN_ISSUE);
					SendScreenMessage(playerid, "The password is not valid");
				}
				else
				{
					playerData[playerid][LoginAttempts] ++;
					if (playerData[playerid][LoginAttempts] >= MAX_FAILEDLOGINREGISTER)
					{
						HideAllPlayerDialog(playerid);
						SendScreenMessage(playerid, "Too many login failures, try again later");
						SendClientMessage(playerid, COLOR_HINT, "[HINT] If you forgot your password, contact staff. (" SERVER_URL ")");
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
						SetTimerEx("KickEx", 100, false, "i", playerid);
					}
					else
					{
						new query[110 + MAX_PLAYER_NAME];
						mysql_format(gGameConnection, query, sizeof(query), "SELECT * FROM `accounts` WHERE `name` = '%e' AND `password` = SHA1('%e') LIMIT 1;", ReturnPlayerName(playerid), inputtext);
						mysql_tquery(gGameConnection, query, "OnExecuteFinish", "iiiss", THREAD_LOGIN, playerid, INVALID_VALUE, "", "");
					}
				}
			}
			else
			{
				HideAllPlayerDialog(playerid);
				SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
			}
			return 1;
		}

		case DIALOG_NUKE:
		{
			if (!response)
			{
			  SendClientMessage(playerid, COLOR_NOTIFY, "   You have cancelled the operation.");
			}
			else
			{
				switch (listitem)
				{
					case 0:
					{
						LaunchNuke(playerid, TEAM_USA, -353.515625, 2574.21875, -113.28125, 2796.875);
					}

					case 1:
					{
						LaunchNuke(playerid, TEAM_EUROPE, 873.046875, 2068.359375, 1001.953125, 2250);
					}

					case 2:
					{
						LaunchNuke(playerid, TEAM_ASIA, -875.8406, 1389.667, -607.2495, 1623.225);
					}

					case 3:
					{
						LaunchNuke(playerid, TEAM_RUSSIA, -309.375, 1024.21875, 103.125, 1211.71875);
					}

					case 4:
					{
						LaunchNuke(playerid, TEAM_AUSTRALIA, 89.0, 2418.75, 466.40625, 2617.96875);
					}
				} // switch (listitem)
			}
			return 1;
		}

		case DIALOG_CLASSSELECTION:
		{
			if (!response) return DisplayPlayerDialog(playerid, DIALOG_CLASSSELECTION);
			
			FirstSpawn[playerid] = 0;

			new str[16 + MAX_STRING_CLASSNAME] = "Class: {0000FF}";
			if(GetPlayerRank(playerid) < gClass[listitem][E_CLASS_RANK])
			{
				DisplayPlayerDialog(playerid, DIALOG_CLASSSELECTION);
				format(str, sizeof str, "You must be %s to access this class", gRanks[gClass[listitem][E_CLASS_RANK]][E_RANK_NAME]);
				return SendScreenMessage(playerid, str);
			}
			if (listitem == CLASS_DONATOR && playerData[playerid][pd_VIPRank] < 2)
			{
				DisplayPlayerDialog(playerid, DIALOG_CLASSSELECTION);
				return SendScreenMessage(playerid, "You must be VIP rank 2 to use this class");
			}

			playerData[playerid][pd_ClassId] = listitem;
			strcat(str, gClass[listitem][E_CLASS_NAME]);
			SendClientMessage(playerid, COLOR_WHITE, str);
			UpdateLabelText(playerid);
			GivePlayerClassWeapons(playerid);
			return 1;
		}

		case DIALOG_ACCOUNT_EMAIL:
		{
			if (response)
			{
				if (IsSavingAllStats)
				{
					DisplayPlayerDialog(playerid, DIALOG_ACCOUNT_EMAIL);
					SendScreenMessage(playerid, LOCALE_MESSAGE_CANTDOTHATRIGHTNOW);
				}
				else if (isnull(inputtext) || (strlen(inputtext) < MIN_STRING_EMAIL) || (strlen(inputtext) > MAX_STRING_EMAIL))
				{
					DisplayPlayerDialog(playerid, DIALOG_ACCOUNT_EMAIL_ISSUE);
				}
				else
				{
					format(playerData[playerid][piEmail], MAX_STRING_EMAIL, "%s", inputtext);
					new Query[70 + MAX_STRING_EMAIL];
					mysql_format(gGameConnection, Query, sizeof(Query), "UPDATE `accounts` SET `email` = '%e' WHERE `id` = %i;", inputtext, playerData[playerid][pd_AccountId]);
					mysql_tquery(gGameConnection, Query);
					SendClientMessage(playerid, COLOR_NOTIFY, "   The Email address has been associated in your account.");
				}
			}
			return 1;
		}

		case DIALOG_COMMANDS_ADMINISTRATOR:
		{
			return 1;
		}

		case DIALOG_INTERIORSLIST:
		{
			if (response)
			{
				SetPlayerPosEx(playerid, Lst_InteriorCoordinates[listitem][0], Lst_InteriorCoordinates[listitem][1], Lst_InteriorCoordinates[listitem][2], Lst_InteriorCoordinates[listitem][3], VW_OUTSIDE, Lst_InteriorIds[listitem][0]);
				SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have been teleported to interior '%s'(IId %i).", Lst_InteriorNames[listitem][0], Lst_InteriorIds[listitem][0]);
			}
			return 1;
		}

		case DIALOG_SHOP:
		{
			if (response)
			{
				switch (listitem)
				{
					case 0:
					{
						if (GetPlayerMoney(playerid) < 5000) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANNOTAFFORD);
						TakePlayerCash(playerid, 5000);
						SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have bought a First-Aid Kit and used it.");
						DisplayPlayerDialog(playerid, DIALOG_SHOP);
					}

					case 1:
					{
						if (GetPlayerMoney(playerid) < 10000) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANNOTAFFORD);
						TakePlayerCash(playerid, 10000);
						SetPlayerArmour(playerid, 99.0);
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have bought Armor.");
						DisplayPlayerDialog(playerid, DIALOG_SHOP);
					}

					case 2:
					{
						if (GetPlayerMoney(playerid) < 5500) return SendScreenMessage(playerid, LOCALE_MESSAGE_CANNOTAFFORD);
						if (pHasHelmet[playerid])
						{
							DisplayPlayerDialog(playerid, DIALOG_SHOP);
							return SendScreenMessage(playerid, "You already have a protection helmet");
						}
						GivePlayerHelmet(playerid);
						TakePlayerCash(playerid, 5500);
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have bought Protection Helmet for $5500.");
						SendClientMessage(playerid, COLOR_WHITE, "[HINT] You can notice a helmet over your head, it will protect you from the headshot.");
					}

					case 4:
					{
						DisplayPlayerDialog(playerid, DIALOG_WEAPON_BUY);
					}

					case 6:
					{
						if (!AntiSK[playerid])
						{
							SetPlayerTeam(playerid, NO_TEAM);
							SetPlayerSkinEx(playerid, 28);
							SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
							SetPlayerArmour(playerid, 99.0);
							SetPlayerColor(playerid, COLOR_WHITE);
							SetPlayerPos(playerid, 1290.4106, 1.9512, 1001.0201);
							SetPlayerInterior(playerid, INTERIOR_WAREHOUSE1);
							ResetPlayerWeaponsEx(playerid);
							GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 500);
							GivePlayerWeaponEx(playerid, WEAPON_SHOTGSPA, 500);
							GivePlayerWeaponEx(playerid, 31, 500);
							GivePlayerWeaponEx(playerid, 16, 1);
							GivePlayerWeaponEx(playerid, WEAPON_KNIFE, 1);
							new string[MAX_STRING];
							format(string, sizeof(string), "[ARENA] %s(%i) has joined to standard Deathmatch Arena!", ReturnPlayerName(playerid), playerid);
							SendClientMessageToAll(COLOR_NEWS, string);
							SendClientMessage(playerid, COLOR_HINT, "[HINT] You can type '/kill' to leave the Arena.");
						}
						else
						{
							SendScreenMessage(playerid, "You cannot join DM while in AntiSK protection");
						}
					}

					case 7:
					{
						SendScreenMessage(playerid, "This feature is currently disabled.");
						/*if (AntiSK[playerid] == 0)
						{
							SetPlayerTeam(playerid, NO_TEAM);
							SetPlayerSkinEx(playerid, 240);
							SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
							SetPlayerArmour(playerid, 99.0);
							SetPlayerColor(playerid, COLOR_WHITE);
							new const rand = random(sizeof(MiniSpawn));
							SetPlayerPos(playerid, MiniSpawn[rand][0], MiniSpawn[rand][1], MiniSpawn[rand][2]);
							SetPlayerInterior(playerid, 15);
							ResetPlayerWeaponsEx(playerid);
							GivePlayerWeaponEx(playerid, WEAPON_MINIGUN, MAX_WEAPON_AMMO);
							new name[MAX_PLAYER_NAME];
							GetPlayerName(playerid, name, sizeof(name));
							new string[MAX_STRING];
							format(string, sizeof(string), "[ARENA] %s has joined to Minigun Deathmatch Arena!", name);
							SendClientMessageToAll(COLOR_NEWS, string);
							SendClientMessage(playerid, COLOR_HINT, "[HINT] You cna type '/kill' to leave the Arena.");
						}
						else
						{
							SendScreenMessage(playerid, "You cannot join Minigun-DM while in AntiSK protection");
						}*/
					}

					case 8:
					{
						if (AntiSK[playerid] == 0)
						{
							SetPlayerTeam(playerid, NO_TEAM);
							SetPlayerSkinEx(playerid, 230);
							SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
							SetPlayerArmour(playerid, 99.0);
							SetPlayerColor(playerid, COLOR_WHITE);
							new const rand = random(sizeof(CBSpawn));
							SetPlayerPos(playerid, CBSpawn[rand][0], CBSpawn[rand][1], CBSpawn[rand][2]);
							SetPlayerInterior(playerid, INTERIOR_PAINTBALL);
							ResetPlayerWeaponsEx(playerid);
							GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, MAX_WEAPON_AMMO);
							new name[MAX_PLAYER_NAME];
							GetPlayerName(playerid, name, sizeof(name));
							new string[MAX_STRING];
							format(string, sizeof(string), "[ARENA] %s has joined to Cbug Deathmatch Arena!", name);
							SendClientMessageToAll(COLOR_NEWS, string);
							SendClientMessage(playerid, COLOR_HINT, "[HINT] You can type '/kill' to leave the Arena.");
						}
						else
						{
							SendScreenMessage(playerid, "You cannot join Cbug-DM while in AntiSK protection");
						}
					}
				}
			}
			return 1;
		}

		case DIALOG_SETTINGS:
		{
			if (response)
			{
				switch (listitem)
				{
					case 0:
					{
						cmd_st(playerid, "");
					}

					case 1:
					{
						cmd_sc(playerid, "");
					}

					case 2:
					{
						cmd_setemail(playerid, "");
					}

					case 3:
					{
						cmd_dnd(playerid, "");
					}
				}
			}
			return 1;
		}

		case DIALOG_WEAPON_BUY:
		{
			if (response)
			{
				switch (listitem)
				{
					case 0:
					{
						PlayerBuyWeapon(playerid, 8000, 31, 300);
					}

					case 1:
					{
						PlayerBuyWeapon(playerid, 8000, 30, 300);
					}

					case 2:
					{
						PlayerBuyWeapon(playerid, 6000, 29, 300);
					}

					case 3:
					{
						PlayerBuyWeapon(playerid, 12000, 28, 500);
					}

					case 4:
					{
						PlayerBuyWeapon(playerid, 10000, WEAPON_SHOTGSPA, 300);
					}

					case 5:
					{
						PlayerBuyWeapon(playerid, 5000, 25, 300);
					}

					case 6:
					{
						PlayerBuyWeapon(playerid, 6000, WEAPON_DEAGLE, 300);
					}

					case 7:
					{
						PlayerBuyWeapon(playerid, 3000, 23, 300);
					}

					case 8:
					{
						PlayerBuyWeapon(playerid, 3000, WEAPON_COLT45, 300);
					}
				}
				DisplayPlayerDialog(playerid, DIALOG_WEAPON_BUY);
			}
			else
			{
				DisplayPlayerDialog(playerid, DIALOG_SHOP);
			}
			return 1;
		}
	}

	return 0;
}
