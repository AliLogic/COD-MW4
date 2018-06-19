// Macro

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#if !defined isnull
	#define isnull(%1) ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

// Function

bool:IsNonNitroVehicle(const vehiclemodelid)
{
	static const nonNitroVehicles[29] = {581, 523, 462, 521, 463, 522, 461, 448, 468, 586, 509, 481, 510, 472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 569, 537, 538, 570, 449};

	for (new i = 0, j = sizeof(nonNitroVehicles); i != j; ++ i)
	{
		if (vehiclemodelid == nonNitroVehicles[i])
		{
			return true;
		}
	}

	return false;
}

bool:IsPlayerInGame(const playerid)
{
	if (!IsPlayerConnected(playerid) || (playerid == INVALID_PLAYER_ID) || IsPlayerNPC(playerid))
	{
		return false;
	}

	return true;
}

Float:ReturnPlayerHealth(const playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	return health;
}

bool:IsPlayerDriver(const playerid)
{
   if (IsPlayerInAnyVehicle(playerid) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
   {
      return true;
   }

   return false;
}

bool:HasVehicleDriver(const vehicleid) 
{ 
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && IsPlayerInAnyVehicle(i))
		{
			if ((GetPlayerState(i) == PLAYER_STATE_DRIVER) && (GetPlayerVehicleID(i) == vehicleid))
			{
				return true;
			}
		}
	}

	return false; 
}

bool:IsDriveByWeapon(const weaponid)
{
	switch (weaponid)
	{
		case WEAPON_COLT45, WEAPON_UZI, WEAPON_MP5, WEAPON_AK47, WEAPON_M4, WEAPON_TEC9:
		{
			return true;
		}
	}

	return false;
}

bool:IsPlayerDead(const playerid)
{
   new Float:health;
   GetPlayerHealth(playerid, health);

   if ((GetPlayerState(playerid) == PLAYER_STATE_WASTED) && (health <= 0.0))
   {
      return true;
   }

   return false;
}

bool:IsPlayerSpawned(const playerid)
{
	switch (GetPlayerState(playerid))
	{
		case PLAYER_STATE_ONFOOT, PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER, PLAYER_STATE_SPAWNED:
		{
			return true;
		}
	}

	return false;
}

bool:IsPlayerStaff(const playerid)
{
	if (IsPlayerAdmin(playerid) || playerData[playerid][pd_AdminRank])
	{
		return true;
	}

	return false;
}

bool:IsVehicleInGame(const vehicleid)
{
	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);

	if (((x == 0.0) && (y == 0.0) && (z == 0.0)) || (vehicleid == INVALID_VEHICLE_ID) || (vehicleid == INVALID_VALUE))
	{
		return false;
	}

	return true;
}

GetPlayerIP(const playerid)
{
	new ip[MAX_STRING_IP];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

ShowPlayerTeamSelectionTD(const playerid)
{
	PlayerTextDrawShow(playerid, playerData[playerid][pd_TdTeamSelection]);
	TextDrawShowForPlayer(playerid, tdTeamCount0);
	TextDrawShowForPlayer(playerid, tdTeamCount1);
	TextDrawShowForPlayer(playerid, tdTeamCount2);
	TextDrawShowForPlayer(playerid, tdTeamCount3);
	TextDrawShowForPlayer(playerid, tdTeamCount4);
}

HidePlayerTeamSelectionTD(const playerid)
{
	PlayerTextDrawHide(playerid, playerData[playerid][pd_TdTeamSelection]);
	TextDrawHideForPlayer(playerid,  tdTeamCount0);
	TextDrawHideForPlayer(playerid, tdTeamCount1);
	TextDrawHideForPlayer(playerid, tdTeamCount2);
	TextDrawHideForPlayer(playerid, tdTeamCount3);
	TextDrawHideForPlayer(playerid, tdTeamCount4);
}

forward OnExecuteFinish(threadid, playerid, integer, string[], string2[]);
public OnExecuteFinish(threadid, playerid, integer, string[], string2[])
{
	if (mysql_errno(gGameConnection))
	{
		printf("MySQL: Error in executing query! E #%i T #%i", mysql_errno(gGameConnection), threadid); // TODO
	}

	if (threadid == INVALID_VALUE)
	{
		return 1;
	}
	
	new foundRows, foundFields;
	cache_get_data(foundRows, foundFields);

	switch (threadid)
	{
		case THREAD_CHECK_BAN:
		{
			if (foundRows)
			{
				new reason[MAX_STRING_REASON], closedDate[MAX_STRING_DATETIME], bannedIP[MAX_STRING_IP], closedBy[MAX_PLAYER_NAME];
				new const closeType = cache_get_field_content_int(0, "close_type", gGameConnection);
				cache_get_field_content(0, "reason", reason, gGameConnection, sizeof(reason));
				new const isPermanently = cache_get_field_content_int(0, "is_permanently", gGameConnection);
				cache_get_field_content(0, "closed_date", closedDate, gGameConnection, sizeof(closedDate));
				cache_get_field_content(0, "ip", bannedIP, gGameConnection, sizeof(bannedIP));
				cache_get_field_content(0, "closed_by", closedBy, gGameConnection, sizeof(closedBy));
				new message[230 + MAX_PLAYER_NAME + MAX_STRING_REASON + MAX_STRING_DATETIME + MAX_STRING_IP + MAX_PLAYER_NAME];
				if (integer == INVALID_VALUE) // Is checking by staff
				{
					if (closeType == 0) // 0 = banned
					{
						if (!isPermanently)
						{
							SendClientMessage(playerid, COLOR_HINT, "[HINT] To unban this account you can apply in forums: " SERVER_URL);
						}
						format(message, sizeof(message), "{FFFFFF}This account is {FF0000}Banned {FFFFFF}in the server.\n\n{FFFFFF}Account name: {FFFF00}%s\n{FFFFFF}Reason: {FFFF00}%s\n{FFFFFF}Is permanently: {FF0000}%s!\n{FFFFFF}Banned date: {FFFF00}%s\n{FFFFFF}Banned by: {FFFF00}%s", 
							string, reason, ReturnYesNo(isPermanently), closedDate, closedBy);
						DisplayDialogMessage(playerid, "Account - Banned", message);
					}
					else
					{
						if (!isPermanently)
						{
							SendClientMessage(playerid, COLOR_HINT, "[HINT] To open this account you can contact staff. (" SERVER_URL ")");
						}
						format(message, sizeof(message), "{FFFFFF}This account is {80FF80}Closed {FFFFFF}in the server.\n\n{FFFFFF}Account name: {FFFF00}%s\n{FFFFFF}Reason: {FFFF00}%s\n{FFFFFF}Is permanently: {FF0000}%s!\n{FFFFFF}Closed date: {FFFF00}%s\n{FFFFFF}Closed by: {FFFF00}%s", 
							string, reason, ReturnYesNo(isPermanently), closedDate, closedBy);
						DisplayDialogMessage(playerid, "Account - Closed", message);
					}
					SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
					SetTimerEx("KickEx", 100, false, "i", playerid); // Do NOT use higher than 100.
				}
				else
				{
					if (closeType == 0) // 0 = banned
					{
						format(message, sizeof(message), "{FFFFFF}Account: {FFFF00}%s(DbId %i)\n{FFFFFF}Reason: {FFFF00}%s\n{FFFFFF}Is permanently: {FF0000}%s\n{FFFFFF}Banned date: {FFFF00}%s\n{FFFFFF}Banned IP: {FFFF00}%s\n{FFFFFF}Banned by: {FFFF00}%s", 
							string, cache_get_field_content_int(0, "account_id", gGameConnection), reason, ReturnYesNo(isPermanently), closedDate, bannedIP, closedBy);
						DisplayDialogMessage(playerid, "Account - Banned", message);
					}
					else
					{
						format(message, sizeof(message), "{FFFFFF}Account: {80FF80}%s(DbId %i)\n{FFFFFF}Reason: {80FF80}%s\n{FFFFFF}Is permanently: {80FF80}%s\n{FFFFFF}Closed date: {80FF80}%s\n{FFFFFF}Closed IP: {80FF80}%s\n{FFFFFF}Closed by: {80FF80}%s", 
							string, cache_get_field_content_int(0, "account_id", gGameConnection), reason, ReturnYesNo(isPermanently), closedDate, bannedIP, closedBy);
						DisplayDialogMessage(playerid, "Account - Closed", message);
					}
				}
			} // if (foundRows)
			else
			{
				if (integer != INVALID_VALUE)
				{
					SendScreenMessage(playerid, "That account is not banned or doesn't exist");
				}
			}
		}

		case THREAD_CHECK_ACCOUNT:
		{
			if (foundRows)
			{
				DisplayPlayerDialog(playerid, DIALOG_LOGIN);
			}
			else
			{
				if (strfind(ReturnPlayerName(playerid), SERVER_TAG, true) != INVALID_VALUE)
				{
					SendScreenMessage(playerid, "You are not allowed to use the " GAMEMODE_NAME "'s tag in your name");
					SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
					SetTimerEx("KickEx", 100, false, "i", playerid);
				}
				else
				{
					DisplayPlayerDialog(playerid, DIALOG_REGISTER);
				}
			}
		}

		case THREAD_INSERT_ACCOUNT:
		{
			playerData[playerid][pd_AccountId] = cache_insert_id();
			new query[MAX_STRING];
			format(query, sizeof(query), "UPDATE `accounts` SET `lastlogin_date` = NOW() WHERE `id` = %i;", playerData[playerid][pd_AccountId]);
			mysql_tquery(gGameConnection, query);
			SendClientMessage(playerid, COLOR_NOTIFY, "   You have been successfully registered and logged in.");
			SendClientMessage(playerid, COLOR_HINT, "[HINT] To change your settings type '/settings'.");
			SendClientMessage(playerid, COLOR_HINT, "[HINT] Type '/commands' for a list of commands or type '/help' for guides.");
			playerData[playerid][pd_IsLoggedIn] = 1;
			TogglePlayerSpectating(playerid, false);
			SetPlayerWeaponSkill(playerid, 999);
			SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
			ResetPlayerMoney(playerid);
			SetPlayerScoreEx(playerid, 20);
			SetPlayerWantedLevel(playerid, 0);
			cmd_rules(playerid, "");
		}

		case THREAD_LOGIN:
		{
			if (foundRows)
			{
				HidePlayerLoginTextDraws(playerid);
				ImportPlayerData(playerid);
			}
			else
			{
				DisplayPlayerDialog(playerid, DIALOG_LOGIN_ISSUE);
			}
		}

		case THREAD_GET_LASTLOGGED:
		{
			if (foundRows)
			{
				new datetime[MAX_STRING_DATETIME];
				cache_get_field_content(0, "lastlogin_date", datetime, gGameConnection, MAX_STRING_DATETIME);
				new Body[MAX_STRING];
				format(Body, sizeof(Body), "{FFFFFF}Account name: {FFFF00}%s\n\nLast logged: {FFFF00}%s", string, datetime);
				DisplayDialogMessage(playerid, "Player - Last Logged", Body);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDACCOUNT);
			}
		}

		case THREAD_ADD_OFFLINEBAN:
		{
			if (foundRows)
			{
				new targetIP[MAX_STRING_IP];
				cache_get_field_content(0, "ip", targetIP, gGameConnection, sizeof(targetIP));
				new string3[135 + MAX_STRING_REASON + MAX_STRING_IP];
				mysql_format(gGameConnection, string3, sizeof(string3), "INSERT IGNORE INTO `closed_accounts` (`account_id`, `reason`, `ip`, `by_account_id`) VALUES (%i, '%e', '%s', %i);", cache_get_field_content_int(0, "id", gGameConnection), string, targetIP, playerData[playerid][pd_AccountId]);
				mysql_tquery(gGameConnection, string3);
				mysql_format(gGameConnection, string3, sizeof(string3), "UPDATE `accounts` SET `total_bans` = `total_bans` + 1 WHERE `name` = '%e';", string2);
				mysql_tquery(gGameConnection, string3);
				format(string3, sizeof(string3), "[SERVER] %s has been offline-banned by %s %s(%i), reason: %s.", string2, GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, string);
				SendClientMessageToAll(0x8B0000FF/*COLOR_SERVER*/, string3);
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDACCOUNT);
			}
		}

		case THREAD_DELETE_BAN:
		{
			if (foundRows)
			{
				if (!cache_get_field_content_int(0, "is_permanently", gGameConnection))
				{
					new string3[MAX_STRING];
					format(string3, sizeof(string3), "DELETE FROM `closed_accounts` WHERE `account_id` = %i;", cache_get_field_content_int(0, "account_id", gGameConnection));
					mysql_tquery(gGameConnection, string3);
					format(string3, sizeof(string3), "[SERVER] %s %s(%i) has unbanned %s from the server.", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, string);
					SendClientMessageToAll(0x8B0000FF/*COLOR_SERVER*/, string3);
				}
				else
				{
					SendScreenMessage(playerid, "That account is permanently banned, cannot be unbanned");
				}
			}
			else
			{
				SendScreenMessage(playerid, "That account is not banned or doesn't exist");
			}
		}


		case THREAD_UPDATE_ACCOUNTNAME:
		{
			if (foundRows)
			{
				SendScreenMessage(playerid, "That name is already in use");
			}
			else
			{
				new query[60 + MAX_PLAYER_NAME + MAX_PLAYER_NAME];
				// Account
				mysql_format(gGameConnection, query, sizeof(query), "UPDATE `accounts` SET `name` = '%e' WHERE `name` = '%e';", string, string2);
				mysql_tquery(gGameConnection, query);
				if (integer == INVALID_VALUE)
				{
					SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have changed %s's name to %s", string2, string);
				}
				else
				{
					SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have changed %s(%i)'s name to %s", string2, integer, string);
					SetPlayerName(integer, string);
					SendClientMessageEx(integer, COLOR_REWARD, "%s %s(%i) has changed your name to %s", GetStaffClassName(playerid), ReturnPlayerName(playerid), playerid, string);
				}
			}
		}

		case THREAD_GET_ACCOUNTS:
		{
			if (foundRows)
			{
				new targetName[MAX_PLAYER_NAME], targetIP[MAX_STRING_IP], accounts[1000];
				new found;
				for (new i = 0; i < foundRows; i ++)
				{
					found ++;
					cache_get_field_content(i, "name", targetName, gGameConnection, sizeof(targetName));
					cache_get_field_content(i, "ip", targetIP, gGameConnection, sizeof(targetIP));
					format(accounts, sizeof(accounts), "%s%s\t%s\t%i\t%i\n", accounts, targetName, targetIP, cache_get_field_content_int(i, "score", gGameConnection), cache_get_field_content_int(i, "money", gGameConnection));
					if (found == 20)
					{
						break;
					}
				}
				format(accounts, sizeof(accounts), "Name\tIP/Reg. IP\tScore\tCash\n%s", accounts);
				ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_TABLIST_HEADERS, "Player - Accounts", accounts, "OK", "");
				format(accounts, sizeof(accounts), "");
			}
			else
			{
				SendScreenMessage(playerid, LOCALE_MESSAGE_INVALIDACCOUNT);
			}
		}
	}

	return 1;
}

SetPlayerWeaponSkill(const playerid, const LEVEL)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, LEVEL);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, LEVEL);
}

ImportPlayerData(const playerid)
{
	playerData[playerid][pd_AccountId] = cache_get_field_content_int(0, "id", gGameConnection);
	// name
	// password
	cache_get_field_content(0, "email", playerData[playerid][piEmail], gGameConnection, MAX_STRING_EMAIL);
	// ip
	// registration_ip
	cache_get_field_content(0, "registered_date", playerData[playerid][pd_RegisteredDate], gGameConnection, MAX_STRING_DATETIME);
	// lastlogin_date
	// gender
	playerData[playerid][pd_Score] = cache_get_field_content_int(0, "score", gGameConnection);
	playerData[playerid][pd_Money] = cache_get_field_content_int(0, "money", gGameConnection);
	playerData[playerid][pd_AdminRank] = cache_get_field_content_int(0, "administrator_rank", gGameConnection);
	// developer_rank
	playerData[playerid][pd_VIPRank] = cache_get_field_content_int(0, "vip_rank", gGameConnection);
	// vip_start_date
	// vip_end_date
	playerData[playerid][CTagg] = cache_get_field_content_int(0, "has_tag", gGameConnection);
	// custom_skinid
	// fightingstyle_id
	// weapon_skill
	// new_year_gift
	playerData[playerid][JailTime] = cache_get_field_content_int(0, "imprison_time", gGameConnection);
	// jail_reason
	// jailed_by
	playerData[playerid][Muted] = cache_get_field_content_int(0, "mute_time", gGameConnection);
	// staff_notes
	// offline_pm
	playerData[playerid][pd_Kills] = cache_get_field_content_int(0, "kills", gGameConnection);
	playerData[playerid][pd_KillingSpree] = cache_get_field_content_int(0, "killing_spree", gGameConnection);
	playerData[playerid][pd_Deaths] = cache_get_field_content_int(0, "deaths", gGameConnection);
	playerData[playerid][Headshots] = cache_get_field_content_int(0, "headshot_kills", gGameConnection);
	// arena_wins
	// arena_loses
	playerData[playerid][pd_CapturedZones] = cache_get_field_content_int(0, "captured_zones", gGameConnection);
	playerData[playerid][pd_PlayedTime] = cache_get_field_content_int(0, "played_hours", gGameConnection);
	// total_donates
	// staff_warnings
	// total_bans
	// total_kicks
	playerData[playerid][pd_Warnings] = cache_get_field_content_int(0, "total_warnings", gGameConnection);
	// imprison_records
	// total_banned_players
	// total_kicked_players
	// total_warned_players
	// total_imprisoned_players

	if (strfind(ReturnPlayerName(playerid), SERVER_TAG, true) != INVALID_VALUE)
	{
		if (!playerData[playerid][CTagg])
		{
			SendScreenMessage(playerid, "You are not allowed to use the " GAMEMODE_NAME "'s tag in your name");
			SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
			SetTimerEx("KickEx", 100, false, "i", playerid);
			return;
		}
	}

	playerData[playerid][pd_RealAdminRank] = playerData[playerid][pd_AdminRank];
	playerData[playerid][pd_IsLoggedIn] = 1;
	TogglePlayerSpectating(playerid, false);
	SetPlayerWeaponSkill(playerid, 999);
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
	SetPlayerCash(playerid, playerData[playerid][pd_Money]);
	SetPlayerScoreEx(playerid, playerData[playerid][pd_Score]);
	SetPlayerWantedLevel(playerid, 0);

	if ((strlen(playerData[playerid][piEmail]) <= 0) || isnull(playerData[playerid][piEmail]))
	{
		SendClientMessage(playerid, COLOR_ALERT, "   You need to associate an Email in your account. Type '/setemail'");
	}

	if (playerData[playerid][pd_VIPRank])
	{
		// TODO: Missing VIP time check.
	}

	new string[MAX_STRING];

	if (playerData[playerid][pd_AdminRank] && playerData[playerid][pd_VIPRank])
	{
		format(string, sizeof(string), "   You have logged in.(Rank %i, VIP %i)", playerData[playerid][pd_AdminRank], playerData[playerid][pd_VIPRank]);
	}
	else if (playerData[playerid][pd_AdminRank])
	{
		format(string, sizeof(string), "   You have logged in.(Rank %i)", playerData[playerid][pd_AdminRank]);
	}
	else if (playerData[playerid][pd_VIPRank])
	{
		format(string, sizeof(string),"   You have logged in.(VIP %i)", playerData[playerid][pd_VIPRank]);
	}
	else
	{
		format(string, sizeof(string), "  You have logged in.");
	}

	SendClientMessage(playerid, COLOR_NOTIFY, string);
}

SetPlayerScoreEx(const playerid, const amount)
{
	playerData[playerid][pd_Score] = amount;
	SetPlayerScore(playerid, amount);
}

GivePlayerScore(const playerid, const amount)
{
	playerData[playerid][pd_Score] = playerData[playerid][pd_Score] + amount;
	SetPlayerScore(playerid, playerData[playerid][pd_Score]);
}

TakePlayerScore(const playerid, const amount)
{
	playerData[playerid][pd_Score] = playerData[playerid][pd_Score] - amount;
	SetPlayerScore(playerid, playerData[playerid][pd_Score]);
}

ShowPlayerLoginTextDraws(const playerid)
{
	TextDrawShowForPlayer(playerid, tdServerName);
	TextDrawShowForPlayer(playerid, tdWelcome);
	PlayerTextDrawShow(playerid, playerData[playerid][pd_TdGMVersion]);
}

HidePlayerLoginTextDraws(const playerid)
{
	TextDrawHideForPlayer(playerid, tdServerName);
	TextDrawHideForPlayer(playerid, tdWelcome);
	PlayerTextDrawHide(playerid, playerData[playerid][pd_TdGMVersion]);
}

HidePlayerGameTexts(const playerid)
{
	GameTextForPlayer(playerid, " ", 1, 6);
	GameTextForPlayer(playerid, " ", 1000, 1);
}

bool:IsValidPassword(password[], const maximum_lenght)
{
	if (!isnull(password) && (strlen(password) >= 4) && (strlen(password) <= maximum_lenght))
	{
		return true;
	}

	return false;
}

ReturnYesNo(const input)
{
	new output[4];

	if (input)
	{
		output = "Yes";
	}
	else
	{
		output = "No";
	}

	return output;
}

ResetPlayerData(const playerid)
{
	// Database
	playerData[playerid][pd_AccountId] = INVALID_VALUE;
	// name
	// password
	format(playerData[playerid][piEmail], MAX_STRING_EMAIL, "");
	format(playerData[playerid][pd_IP], MAX_STRING_IP, "");
	// registration_ip
	format(playerData[playerid][pd_RegisteredDate], MAX_STRING_DATETIME, "");
	// lastlogin_date
	// gender
	playerData[playerid][pd_Score] = 0;
	playerData[playerid][pd_Money] = 0;
	playerData[playerid][pd_AdminRank] = 0;
	// developer_rank
	playerData[playerid][pd_VIPRank] = 0;
	// vip_start_date
	// vip_end_date
	playerData[playerid][CTagg] = 0;
	// custom_skinid
	// fightingstyle_id
	// weapon_skill
	// new_year_gift
	playerData[playerid][JailTime] = 0;
	// jail_reason
	// jailed_by
	playerData[playerid][Muted] = 0;
	// staff_notes
	// offline_pm
	playerData[playerid][pd_Kills] = 0;
	playerData[playerid][pd_KillingSpree] = 0;
	playerData[playerid][pd_Deaths] = 0;
	playerData[playerid][Headshots] = 0;
	// arena_wins
	// arena_loses
	playerData[playerid][pd_CapturedZones] = 0;
	playerData[playerid][pd_PlayedTime] = 0;
	// total_donates
	// staff_warnings
	// total_bans
	// total_kicks
	playerData[playerid][pd_Warnings] = 0;
	// imprison_records
	// total_banned_players
	// total_kicked_players
	// total_warned_players
	// total_imprisoned_players
	// Game
	playerData[playerid][pd_IsLoggedIn] = 0;
	Player_ConnectTime[playerid] = gettime();
	TogglePlayerSpectating(playerid, true);
	playerData[playerid][pd_TeamId] = NO_TEAM;
	playerData[playerid][pd_ClassId] = INVALID_VALUE;
	ResetPlayerWeaponsEx(playerid);
	LastCommandTime[playerid] = 0;
	playerData[playerid][pd_RealAdminRank] = 0;
	playerData[playerid][Frozen] = 0;
	playerData[playerid][pd_IsOnDuty] = false;
	playerData[playerid][God] = 0;
	playerData[playerid][GodCar] = 0;
	playerData[playerid][pd_Warnings] = 0;
	playerData[playerid][DoorsLocked] = 0;
	playerData[playerid][pCar] = INVALID_VALUE;
	playerData[playerid][Hide] = 0;
	playerData[playerid][pd_CurrentWarnings] = 0;
	pHasHelmet[playerid] = false;
	HidePlayerGameTexts(playerid);
	playerData[playerid][LoginAttempts] = 0;
	Invited[playerid]= INVALID_VALUE;
	IsDueling[playerid] = false;
	DuelOpponentId[playerid] = INVALID_PLAYER_ID;
	IsPlayerUsingAnims[playerid] = 0;
	seconds[playerid] = 0;
	LastPm[playerid] = INVALID_VALUE;
	IsSpectating[playerid] = false;
	FirstSpawn[playerid] = 1;
	rconAttempts[playerid] = 0;

	ArmedWeapon[playerid] = WEAPON_FIST;
	isDND[playerid] = 0;
	rconAttempts[playerid] = 0;
	LastPm[playerid] = INVALID_VALUE;
	Streak[playerid] = 0;
	AntiSK[playerid] = 0;
	armedbody_pTick[playerid] = 0;
}

ResetPlayerWeaponsEx(const playerid)
{
	ResetPlayerWeapons(playerid);

	for (new i = 0; i < TOTAL_WEAPONS; i ++)
	{
		playerWeapon[playerid][i] = false;
	}
}

bool:IsVehiclePlane(const vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 460, 464, 476, 511, 512, 513, 519, VEHICLE_HYDRA, 553, 577, 592, 593: return true;
	}

	return false;
}

bool:IsVehicleHelicopter(const vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 417, 425, VEHICLE_SEASPARROW, 465, 469, 487, 488, 497, 501, 548, VEHICLE_RAINDANCE: return true;
	}

	return false;
}

JailPlayer(const playerid)
{
	new str[32];
	ResetPlayerWeaponsEx(playerid);
	SetPlayerInterior(playerid, 3);
	TogglePlayerControllable(playerid,true);
	SetPlayerPos(playerid,197.6661,173.8179,1003.0234);
	SetCameraBehindPlayer(playerid);
	playerData[playerid][JailTime] --;
	format(str, sizeof(str), "~g~Release In:~n~~w~%d seconds", playerData[playerid][JailTime]);
	GameTextForPlayer(playerid, str, playerData[playerid][JailTime], 4);
	if (playerData[playerid][JailTime] <= 0) JailRelease(playerid);
}

JailRelease(const playerid)
{
	playerData[playerid][JailTime] = 0;
	SetPlayerInterior(playerid, 0);
	RemovePlayerFromVehicle(playerid);
	SpawnPlayer(playerid);
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	GameTextForPlayer(playerid, "~g~FREEDOM!", 3000, 4);
	return 1;
}

UnFreezeMe(playerid)
{
	KillTimer(FreezeTimer[playerid]);
	TogglePlayerControllable(playerid, true);
	playerData[playerid][Frozen] = 0;
	PlayerPlaySound(playerid, SOUND_NOTIFICATION, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid, "~g~Unfrozen!", 3000, 4);
	return 1;
}

forward KickEx(const playerid);
public KickEx(const playerid)
{
 	Kick(playerid);
	return 1;
}

ConnectedPlayers()
{
	new Connected;

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i))
		{
			Connected ++;
		}
	}

	return Connected;
}

SetPlayerSkinEx(const playerid, const skinid)
{
	new returnvalue;
	new const vehicleId = GetPlayerVehicleID(playerid);

	if (!vehicleId)
	{
		returnvalue = SetPlayerSkin(playerid, skinid);
	}
	else
	{
		new seatid = GetPlayerVehicleSeat(playerid);
		ClearAnimations(playerid);
		returnvalue = SetPlayerSkin(playerid, skinid);
		PutPlayerInVehicle(playerid, vehicleId, seatid);
	}

	TogglePlayerControllable(playerid, true); // Fixes skin change bug.
	return returnvalue;
}

AttachWeaponToPlayer(const playerid)
{
	new weaponid[TOTAL_SLOT_WEAPON], weaponammo[TOTAL_SLOT_WEAPON];
	new const currentWeapon = GetPlayerWeapon(playerid);
	GetPlayerWeaponData(playerid, SLOT_WEAPON_PISTOL, weaponid[SLOT_WEAPON_PISTOL], weaponammo[SLOT_WEAPON_PISTOL]);
	GetPlayerWeaponData(playerid, SLOT_WEAPON_SMG, weaponid[SLOT_WEAPON_SMG], weaponammo[SLOT_WEAPON_SMG]);
	GetPlayerWeaponData(playerid, SLOT_WEAPON_ASSAULTRIFLES, weaponid[SLOT_WEAPON_ASSAULTRIFLES], weaponammo[SLOT_WEAPON_ASSAULTRIFLES]);

	if (weaponid[2] && weaponammo[2] > 0)
	{
		if (currentWeapon != weaponid[2])
		{
			if (!IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONAR))
			{
				SetPlayerAttachedObject(playerid, SLOT_PAO_WEAPONAR, GetWeaponObjectlId(weaponid[2]), BONE_RIGHTTHIGH, -0.079999, -0.039999, 0.109999, -90.100006, 0.0, 0.0, 1.0, 1.0, 1.0);
			}
		}
		else
		{
			if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONAR))
			{
				RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONAR);
			}
		}
	}
	else if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONAR))
	{
		RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONAR);
	}

	if (weaponid[4] && weaponammo[4] > 0)
	{
		if (currentWeapon != weaponid[4])
		{
			if (!IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONPISTOL))
			{
				SetPlayerAttachedObject(playerid, SLOT_PAO_WEAPONPISTOL, GetWeaponObjectlId(weaponid[4]), BONE_LEFTTHIGH, 0.0, -0.1, -0.08, -95.0, -10.0, 0.0, 1.0, 1.0, 1.0);
			}
		}
		else
		{
			if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONPISTOL))
			{
				RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONPISTOL);
			}
		}
	}
	else if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONPISTOL))
	{
		RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONPISTOL);
	}

	if (weaponid[5] && weaponammo[5] > 0)
	{
		if (currentWeapon != weaponid[5])
		{
			if (!IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONSMG))
			{
				SetPlayerAttachedObject(playerid, SLOT_PAO_WEAPONSMG, GetWeaponObjectlId(weaponid[5]), BONE_SPINE, 0.2, -0.119999, -0.059999, 0.0, 206.0, 0.0, 1.0, 1.0, 1.0);
			}
		}
		else
		{
			if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONSMG))
			{
				RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONSMG);
			}
		}
	}
	else if (IsPlayerAttachedObjectSlotUsed(playerid, SLOT_PAO_WEAPONSMG))
	{
		RemovePlayerAttachedObject(playerid, SLOT_PAO_WEAPONSMG);
	}

	armedbody_pTick[playerid] = GetTickCount();
}

GetWeaponObjectlId(const weaponid)
{
	switch (weaponid)
	{
		case 1: return 331;

		case 2..8: return weaponid + 331;

		case 9: return 341;

		case 10..15: return weaponid + 311;

		case 16..18: return weaponid + 326;

		case 22..29: return weaponid + 324;

		case 30, 31: return weaponid + 325;

		case 32: return 372;

		case 33..45: return weaponid + 324;

		case 46: return 371;
	}

	return 0;
}

DisplayPlayerDialog(const playerid, const dialogid)
{
	switch (dialogid)
	{
		case DIALOG_REGISTER:
		{
			new Body[105 + MAX_PLAYER_NAME];
			format(Body, sizeof(Body), "{FFFFFF}This name {FFFF00}%s {FFFFFF}is {66FF66}not registered. {FFFFFF}Enter your password to register:", ReturnPlayerName(playerid));
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Account - Register", Body, "Register", "Quit");
		}

		case DIALOG_REGISTER_ISSUE:
		{
			ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Account - Register - Invalid", "{FF0000}Password length must be between 4 and "#MAX_STRING_PASSWORD" characters.\n\n{FFFFFF}Enter a valid password to register:", "Register", "Quit");
		}

		case DIALOG_LOGIN:
		{
			new Body[165 + MAX_PLAYER_NAME];
			format(Body, sizeof(Body), "{FFFFFF}This name {FFFF00}%s {FFFFFF}is {FF0000}registered. {FFFFFF}Enter your password to login:\n{808080}If this is not your account, leave and change your name.", ReturnPlayerName(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account - Login", Body, "Login", "Quit");
		}

		case DIALOG_LOGIN_ISSUE:
		{
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account - Login - Wrong", "{FF0000}Wrong password.\n\n{FFFFFF}Enter the correct password to login:\n{808080}If this is not your account, leave and change your name.", "Login", "Quit");
		}

		case DIALOG_ACCOUNT_EMAIL:
		{
			ShowPlayerDialog(playerid, DIALOG_ACCOUNT_EMAIL, DIALOG_STYLE_INPUT, "Account - Email", "{FFFFFF}Enter a Email address to associate in your account (used for recovery):\n\n{808080}You can do this just once.", "Submit", "Skip");
		}

		case DIALOG_ACCOUNT_EMAIL_ISSUE:
		{
			ShowPlayerDialog(playerid, DIALOG_ACCOUNT_EMAIL, DIALOG_STYLE_INPUT, 
				"Account - Email - Invalid", "{FF0000}Email address length must be between "#MIN_STRING_EMAIL" and "#MAX_STRING_EMAIL" characters.\n\n{FFFFFF}Enter a {66FF66}VALID{FFFFFF} Email address to associate in your account (used for recovery):\n\n{808080}You can do this only once.", 
				"Submit", "Skip");
		}

		case DIALOG_SETTINGS:
		{
			ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_LIST, "Account - Settings", "Change Team\nChange Class\nSet Email\nToggle PM", "Select", "Cancel");
		}

		case DIALOG_CLASSSELECTION:
		{
			new str[500] = "Class Name\tRequired Rank\n";

			for(new i; i < sizeof gClass; i++)
			{
				strcat(str, gClass[i][E_CLASS_NAME]);
				strcat(str, "\t"COLOR_INLINE_SCORE"");
				if(i == CLASS_DONATOR) strcat(str, "Donation Rank 2");
				else strcat(str, gRanks[gClass[i][E_CLASS_RANK]][E_RANK_NAME]);
				strcat(str, "\n");
			}

			ShowPlayerDialog(playerid, DIALOG_CLASSSELECTION, DIALOG_STYLE_TABLIST_HEADERS, "Class Selection", str, "Select", "");
		}

		case DIALOG_SHOP:
		{
			ShowPlayerDialog(playerid, DIALOG_SHOP, DIALOG_STYLE_TABLIST, "Briefcase", "First-Aid Kit\t$5000\nArmor\t$10000\nProtection Helmet\t$5500\n-----------------------\nWeapons\n-----------------------\nDeathmatch Stadium\nMinigun Deathmatch\nC-bug Deathmatch", "Select", "Cancel");
		}

		case DIALOG_WEAPON_BUY:
		{
			ShowPlayerDialog(playerid, DIALOG_WEAPON_BUY, DIALOG_STYLE_TABLIST_HEADERS, "Briefcase - Weapons", 
				"Weapon Name\tPrice\n\
				M4\t$8000\nAK47\t$8000\nMP5\t$6000\nUZI\t$12000\nCombat Shotgun\t$10000\nShotgun\t$5000\nDesert Eagle\t$6000\nSilent Pistol\t$3000\nPistol\t$3000", "Buy", "Cancel");
		}
	}
	return 1;
}

CreateAllActors()
{
	#if (GAMEMODE_ACTORSTATE == true)
	print("Creating actors...");

	for (new i = 0; i < sizeof(gActor); i ++)
	{
		gActor[i][actor_Id] = CreateActor(gActor[i][actor_SkinId], gActor[i][actor_Position][0], gActor[i][actor_Position][1], gActor[i][actor_Position][2], gActor[i][actor_Angle]);
		SetActorVirtualWorld(gActor[i][actor_Id], gActor[i][actor_VW]);
		SetActorHealth(gActor[i][actor_Id], gActor[i][actor_Health]);
		SetActorInvulnerable(gActor[i][actor_Id], gActor[i][actor_IsInvulnerable]);
		Create3DTextLabel(gActor[i][actor_Label], gActor[i][actor_ColorId], gActor[i][actor_LabelPosition][0], gActor[i][actor_LabelPosition][1], gActor[i][actor_LabelPosition][2], DRAWDISTANCE_NORMAL, gActor[i][actor_VW], LOS_DISABLE);
	}
	#endif
}

GetPlayerSpeedSpeedo(const playerid, bool:kmh)
{
	new Float:Vx,Float:Vy,Float:Vz,Float:rtn;

	if (IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz);
	else GetPlayerVelocity(playerid,Vx,Vy,Vz);

	rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
	return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}

MaxAmmo(const playerid)
{
	new slot, weap, ammo;

	for (slot = 0; slot < TOTAL_SLOT_WEAPON; slot ++)
	{
		GetPlayerWeaponData(playerid, slot, weap, ammo);
		if (IsValidWeapon(weap))
		{
		  	GivePlayerWeaponEx(playerid, weap, MAX_WEAPON_AMMO);
		}
	}
}

ReturnPlayerName(const playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

IsValidWeapon(const weaponid)
{
	if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;

	return 0;
}

IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

GetPlayerId(playername[])
{
	new playerName[MAX_PLAYER_NAME];

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i))
		{
			GetPlayerName(i, playerName, sizeof(playerName));
			if (strcmp(playerName, playername, true, strlen(playername)) == 0)
			{
				return i;
			}
		}
	}

	return INVALID_PLAYER_ID;
}

forward hideAnnouncement();
public hideAnnouncement()
{
	TextDrawHideForAll(tdAnnounce);
	return 1;
}

bool:IsPlayerInRangeOfPlayer(const playerid, const targetid, const Float:radius)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);

	if (IsPlayerInRangeOfPoint(playerid, radius, x, y, z))
	{
		return true;
	}

	return false;
}

GetVehicleModelIDFromName(vname[])
{
	for (new i = 0; i < 211; i++)
	{
		if ( strfind(vehicleNames[i], vname, true) != INVALID_VALUE )
			return i + 400;
	}

	return INVALID_VALUE;
}

GiveScoreToTeam(const teamid, const amount)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
		{
			if (playerData[i][pd_TeamId] == teamid)
			{
				GivePlayerScore(i, amount);
			}
		}
	}
}

SendMessageToTeam(const teamid, const color, const string[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
		{
			if (playerData[i][pd_TeamId] == teamid)
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}

CheckPlayerHealthHack(const playerid, const staffid)
{
	TogglePlayerControllable(playerid, true);
	playerData[playerid][pd_PreviousVW] = GetPlayerVirtualWorld(playerid);
	playerData[playerid][pd_PreviousInterior] = GetPlayerInterior(playerid);
	GetPlayerHealth(playerid, playerData[playerid][pd_PreviousHealth]);
	GetPlayerArmour(playerid, playerData[playerid][pd_PreviousArmor]);
	GetPlayerPos(playerid, playerData[playerid][pd_PreviousX], playerData[playerid][pd_PreviousY], playerData[playerid][pd_PreviousZ]);
	SetPlayerVirtualWorld(playerid, VW_CHECKHEALTHACK);
	SetPlayerInterior(playerid, INTERIOR_INSIDE);
	SetPlayerHealth(playerid, MAX_HEALTH_PLAYER);
	SetPlayerArmour(playerid, 0.0);
	new const position = random(8);
	SetPlayerPos(playerid, 0.0 + position, 0.0 + position, 3.0);
	CreateExplosion(0.0 + position, 0.0 + position, 3.0, EXPLOSION_VNSNFSVS, 3.0);
	SetTimerEx("CheckPlayerHealthHack2", 2000, 0, "ii", playerid, staffid);
}

forward CheckPlayerHealthHack2(const playerid, const staffid);
public CheckPlayerHealthHack2(const playerid, const staffid)
{
	new Float:newArmor;
	GetPlayerArmour(playerid, newArmor);
	SetPlayerVirtualWorld(playerid, playerData[playerid][pd_PreviousVW]);
	SetPlayerInterior(playerid, playerData[playerid][pd_PreviousInterior]);
	SetPlayerHealth(playerid, playerData[playerid][pd_PreviousHealth]);
	SetPlayerArmour(playerid, playerData[playerid][pd_PreviousArmor]);
	SetPlayerPos(playerid, playerData[playerid][pd_PreviousX], playerData[playerid][pd_PreviousY], playerData[playerid][pd_PreviousZ] + 1.0);

	if ((ReturnPlayerHealth(playerid) < MAX_HEALTH_PLAYER) && (newArmor <= 0.0)) SendClientMessageEx(staffid, COLOR_NOTIFY, "   %s(%i)%s is NOT using health/armor hacks.", ReturnPlayerName(playerid), playerid);
	else
	{
		SendClientMessageEx(staffid, COLOR_NOTIFY, "   %s(%i) is suspected of using health/armor hacks and kicked, ping: %i packet-lost: %.2f percent.", ReturnPlayerName(playerid), playerid, GetPlayerPing(playerid), NetStats_PacketLossPercent(playerid));
		SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server due to Health-Hacking.");
		SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
	}

	if (playerid != staffid)
	{
		SendClientMessage(playerid, COLOR_NOTIFY, "   You have been checked for health-hacks.");
	}

	return 1;
}

MessageToAdmins(const color, const string[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
		{
			if (playerData[i][pd_AdminRank])
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}

GetPlayerClassName(const playerid)
{
	new name[MAX_STRING_CLASSNAME] = "None";
	if(playerData[playerid][pd_ClassId] != INVALID_VALUE) format(name, sizeof name, gClass[playerData[playerid][pd_ClassId]][E_CLASS_NAME]);
	return name;
}

GetStaffClassName(const playerid)
{
	new className[MAX_STRING_CLASSNAME];

	if (playerData[playerid][pd_AdminRank])
	{
		className = "Admin";
	}

	return className;
}

MessageTo4(const color, const string[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_AdminRank] >= 4)
		{
			SendClientMessage(i, color, string);
		}
	}
}

PlaySoundForAll(const soundid, const Float:x, const Float:y, const Float:z)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i))
		{
			PlayerPlaySound(i, soundid, x, y, z);
		}
	}
}

Log(const destinationfile[], data[])
{
	new logFile[MAX_STRING_SHORT] = "logs/";
	strcat(logFile, destinationfile);

	if (!fexist(logFile))
	{
		new File:fileToCreate = fopen(logFile, io_write);
		fclose(fileToCreate);
	}

	new string[1024];
	format(string, sizeof(string), "[%s - %s] %s\r\n", GetDate(), GetTime(), data);
	new File:fileToAppend = fopen(logFile, io_append);
	fwrite(fileToAppend, string);
	fclose(fileToAppend);
}

GetTime()
{ 
	new time[10];
	new hour, minute, second;
	gettime(hour, minute, second);
	format(time, sizeof(time), "%i:%i:%i", hour, minute, second);
	return time;
}

GetDate()
{ 
	new year, month, day;
	new date[16];
	getdate(year, month, day);
	format(date, sizeof(date), "%i-%i-%i", year, month, day);
	return date;
}

public Streamer_OnPluginError(error[])
{
	new string[1024];
	format(string, sizeof(string), "\r\n[Message: %s]\r\n", error);
	Log(FILE_LOG_STREAMERPLUGIN, string);
	return 1;
}

SaveAllPlayersData()
{
	IsSavingAllStats = true;

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
		{
			SavePlayerData(i);
		}
	}

	IsSavingAllStats = false;
}

GetSecondToTime(input, &h, &m, &s)
{
	h = input / 3600;
	m = input / 60 % 60;
	s = (input = input % 60);
}

SavePlayerData(const playerid)
{
	if (IsPlayerInGame(playerid) && playerData[playerid][pd_IsLoggedIn])
	{
		playerData[playerid][pd_PlayedTime] += (gettime() - Player_ConnectTime[playerid]);
		new query[700];
		// pd_AccountId,
		// name
		// password
		format(query, sizeof(query), "ip='%s',", playerData[playerid][pd_IP]);
		format(query, sizeof(query), "%semail='%s',", query, playerData[playerid][piEmail]);
		// registration_ip
		format(query, sizeof(query), "%slastlogin_date=NOW(),", query);
		// gender
		format(query, sizeof(query), "%sscore=%i,", query, playerData[playerid][pd_Score]);
		format(query, sizeof(query), "%smoney=%i,", query, playerData[playerid][pd_Money]);
		format(query, sizeof(query), "%sadministrator_rank=%i,", query, playerData[playerid][pd_RealAdminRank]);
		// developer_rank
		format(query, sizeof(query), "%svip_rank=%i,", query, playerData[playerid][pd_VIPRank]);
		// vip_start_date
		// vip_end_date
		format(query, sizeof(query), "%shas_tag=%i,", query, playerData[playerid][CTagg]);
		// custom_skinid
		// fightingstyle_id
		// weapon_skill
		// new_year_gift
		format(query, sizeof(query), "%simprison_time=%i,", query, playerData[playerid][JailTime]);
		// jail_reason
		// jailed_by
		format(query, sizeof(query), "%smute_time=%i,", query, playerData[playerid][Muted]);
		// staff_notes
		// offline_pm
		format(query, sizeof(query), "%skills=%i,", query, playerData[playerid][pd_Kills]);
		format(query, sizeof(query), "%skilling_spree=%i,", query, playerData[playerid][pd_KillingSpree]);
		format(query, sizeof(query), "%sdeaths=%i,", query, playerData[playerid][pd_Deaths]);
		format(query, sizeof(query), "%sheadshot_kills=%i,", query, playerData[playerid][Headshots]);
		// arena_wins
		// arena_loses
		format(query, sizeof(query), "%scaptured_zones=%i,", query, playerData[playerid][pd_CapturedZones]);
		format(query, sizeof(query), "%splayed_hours=%i,", query, playerData[playerid][pd_PlayedTime]);
		// total_donates
		// staff_warnings
		// total_bans
		// total_kicks
		format(query, sizeof(query), "%stotal_warnings=%i", query, playerData[playerid][pd_Warnings]);
		// imprison_records
		// total_banned_players
		// total_kicked_players
		// total_warned_players
		// total_imprisoned_players
		mysql_format(gGameConnection, query, sizeof(query), "UPDATE `accounts` SET %s WHERE `name` = '%e';", query, ReturnPlayerName(playerid));
		mysql_tquery(gGameConnection, query);
		format(query, sizeof(query), " ");
	}
}

SendMessageToStaff(const color, const string[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (IsPlayerInGame(i) && playerData[i][pd_IsLoggedIn])
		{
			if (playerData[i][pd_AdminRank])
			{
				SendClientMessage(i, color, string);
			}
		}
	}
}

forward EnableCMD(playerid, cmdid);
public EnableCMD(playerid, cmdid)
{
	Block_CMD[playerid][cmdid] = false;
	return 1;
}

bool:IsValidAccountName(name[])
{
	new i;
	new const length = strlen(name);

	if (length < 3)
	{
		return false;
	}

	while (i < length)
	{
		switch (name[i])
		{
			case 'a'..'z', 'A'..'Z', '0'..'9', '(', ')', '[', ']', '.', '_', '$', '=', '@':
			{
				i ++;
			}

			default:
			{
				return false;
			}
		}
	}

	return true;
}

CMDMessageToAdmins(const playerid, command[])
{
	if (ServerInfo[AdminCmdMsg] == 0) return;

	new string[MAX_STRING_SHORT];
	format(string, sizeof(string), "[STAFF] %s(%i) used '/%s'", ReturnPlayerName(playerid), playerid, command);
	SendMessageToStaff(COLOR_STAFFCOMMAND, string);
}

UpdateConfig()
{
	new file[256];
	format(file,sizeof(file),"ladmin/config/Config.ini");

	if (!dini_Exists("ladmin/config/aka.txt")) dini_Create("ladmin/config/aka.txt");

	if (!dini_Exists(file))
	{
		dini_Create(file);
	}

	if (!dini_Isset(file,"MaxPing")) dini_IntSet(file,"MaxPing",1200);
	if (!dini_Isset(file,"ReadPms")) dini_IntSet(file,"ReadPMs",1);
	if (!dini_Isset(file,"ReadCmds")) dini_IntSet(file,"ReadCmds",1);
	if (!dini_Isset(file,"MaxAdminLevel")) dini_IntSet(file,"MaxAdminLevel",5);
	if (!dini_Isset(file,"AdminOnlySkins")) dini_IntSet(file,"AdminOnlySkins",0);
	if (!dini_Isset(file,"AdminSkin")) dini_IntSet(file,"AdminSkin",SKIN_STAFF);
	if (!dini_Isset(file,"AdminSkin2")) dini_IntSet(file,"AdminSkin2",214);
	if (!dini_Isset(file,"AntiSpam")) dini_IntSet(file,"AntiSpam",1);
	if (!dini_Isset(file,"AntiSwear")) dini_IntSet(file,"AntiSwear",1);
	if (!dini_Isset(file,"NameKick")) dini_IntSet(file,"NameKick",1);
 	if (!dini_Isset(file,"PartNameKick")) dini_IntSet(file,"PartNameKick",1);
	if (!dini_Isset(file,"Locked")) dini_IntSet(file,"Locked",0);
	if (!dini_Isset(file,"SaveWeap")) dini_IntSet(file,"SaveWeap",1);
	if (!dini_Isset(file,"SaveMoney")) dini_IntSet(file,"SaveMoney",1);
	if (!dini_Isset(file,"ConnectMessages")) dini_IntSet(file,"ConnectMessages",1);
	if (!dini_Isset(file,"AdminCmdMessages")) dini_IntSet(file,"AdminCmdMessages",1);
	if (!dini_Isset(file,"AutoLogin")) dini_IntSet(file,"AutoLogin",0);
	if (!dini_Isset(file,"MaxMuteWarnings")) dini_IntSet(file,"MaxMuteWarnings",4);
	if (!dini_Isset(file,"MustLogin")) dini_IntSet(file,"MustLogin",0);
	if (!dini_Isset(file,"MustRegister")) dini_IntSet(file,"MustRegister",1);

	if (dini_Exists(file))
	{
		ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
		ServerInfo[ReadPMs] = dini_Int(file,"ReadPMs");
		ServerInfo[ReadCmds] = dini_Int(file,"ReadCmds");
		ServerInfo[MaxAdminLevel] = dini_Int(file,"MaxAdminLevel");
		ServerInfo[AdminOnlySkins] = dini_Int(file,"AdminOnlySkins");
		ServerInfo[AdminSkin] = dini_Int(file,"AdminSkin");
		ServerInfo[AdminSkin2] = dini_Int(file,"AdminSkin2");
		ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
		ServerInfo[AntiSwear] = dini_Int(file,"AntiSwear");
		ServerInfo[NameKick] = dini_Int(file,"NameKick");
		ServerInfo[PartNameKick] = dini_Int(file,"PartNameKick");
		ServerInfo[Locked] = dini_Int(file,"Locked");
		ServerInfo[GiveWeap] = dini_Int(file,"SaveWeap");
		ServerInfo[GiveMoney] = dini_Int(file,"SaveMoney");
		ServerInfo[ConnectMessages] = dini_Int(file,"ConnectMessages");
		ServerInfo[AdminCmdMsg] = dini_Int(file,"AdminCmdMessages");
		ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
		ServerInfo[MaxMuteWarnings] = dini_Int(file,"MaxMuteWarnings");
		ServerInfo[MustLogin] = dini_Int(file,"MustLogin");
		ServerInfo[MustRegister] = dini_Int(file,"MustRegister");
	}

}

forward HideTextoLife(playerid);
public HideTextoLife(playerid)
{
	if (MostrandoVida[playerid] == 1)
	{
		TextDrawHideForPlayer(playerid, damage[playerid]);
		MostrandoVida[playerid] = 0;
	}

	return 1;
}

forward HideTextoLife2(playerid);
public HideTextoLife2(playerid)
{
	if (MostrandoVida2[playerid] == 1)
	{
		TextDrawHideForPlayer(playerid, damage2[playerid]);
		MostrandoVida2[playerid] = 0;
	}

	return 1;
}

AnimPlayer(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	return 1;
}

AnimLoopPlayer(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	IsPlayerUsingAnims[playerid] = 1;
	ApplyAnimation(playerid,animlib,animname,Speed,looping,lockx,locky,lockz,lp);
	GameTextForPlayer(playerid, "~w~PRESS ~r~ANY KEY ~w~TO STOP ANIM", 3000, GAMETEXTSTYLE_TYPE3);
	return 1;
}

forward scoretimer();
public scoretimer()
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		SavePlayerData(i);
		seconds[i] ++;
		if (seconds[i] == 1800000)
		{
			GivePlayerScore(i, 5);
			GameTextForPlayer(i,"~w~You Got ~g~5 ~w~Score For Being Online 30 Mins", 3000, GAMETEXTSTYLE_TYPE3);
			seconds[i] = 0;
		}
	}

	return 1;
}

GetVehicleEmpty(const vehicleid)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		if (IsPlayerInVehicle(i, vehicleid)) return 0;
	}

	return 1;
}

forward stats0();
public stats0()
{
	new str[MAX_STRING];

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		format(str, sizeof(str), "~w~KILLS: ~r~%i~n~~w~DEATHS: ~r~%i~n~~w~RANK: ~y~%s~n~~w~CLASS: ~b~%s", playerData[i][pd_Kills], playerData[i][pd_Deaths], GetPlayerRankName(i), GetPlayerClassName(i));
		TextDrawSetString(Rank1[i], str);
	}

	return 1;
}

forward stats1();
public stats1()
{
	new str1[16];
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		format(str1, sizeof(str1),"~y~SCORE: %i", GetPlayerScore(i));
		TextDrawSetString(tdScore[i], str1);
	}
	return 1;
}

TuneLCar(VehicleID)
{
	ChangeVehicleColor(VehicleID,0,7);
	AddVehicleComponent(VehicleID, 1010);
	AddVehicleComponent(VehicleID, 1087);
}

forward HackCheck();
public HackCheck()
{
	new str[MAX_STRING], playerName[MAX_PLAYER_NAME];
	new Float:x, Float:y, Float:z, Float:armor;

	for (new playerid = 0, j = GetPlayerPoolSize(); playerid <= j; playerid ++)
	{
		if (IsPlayerInGame(playerid))
		{
			GetPlayerName(playerid, playerName, sizeof(playerName));
			SetPVarInt(playerid, "IsWarnedHacking", false);
			GetPlayerArmour(playerid, armor);
			if (armor >= 100.0)
			{
				format(str, sizeof(str), "[SERVER] %s(%i) has been kicked by server, reason: Armor hacking.", playerName, playerid);
				SendClientMessageToAll(COLOR_SERVER, str);
				SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
				SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
			}
			if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
			{
				if ((playerData[playerid][pd_ClassId] != CLASS_JETTROOPER) && !playerData[playerid][pd_AdminRank])
				{
					format(str, sizeof(str), "[SERVER] %s(%i) has been kicked by server, reason: Jetpack hacking.", playerName, playerid);
					SendClientMessageToAll(COLOR_SERVER, str);
					SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
					SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
				}
			}
			if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				if (GetPlayerSpeedSpeedo(playerid, true) > 500)
				{
					if (GetVehicleModel(GetPlayerVehicleID(playerid)) != VEHICLE_HYDRA)
					{
						SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server due to speed-hacking.");
						SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
						return 1;
					}
				}
			}
			new const weaponId = GetPlayerWeapon(playerid);
			if (weaponId > WEAPON_FIST)
			{
				if (!playerWeapon[playerid][weaponId] && (weaponId != WEAPON_BOMB) && (weaponId != WEAPON_PARACHUTE) && (weaponId != WEAPON_CAMERA))
				{
					GivePlayerClassWeapons(playerid);
				}
			}
			if ((weaponId == WEAPON_HEATSEEKER) && !playerData[playerid][pd_AdminRank])
			{
				format(str, sizeof(str), "[SERVER] %s(%i) has been kicked by server, reason: Heat Seeker Weapon.", playerName, playerid);
				SendClientMessageToAll(COLOR_SERVER, str);
				SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
			}
			GetPlayerVelocity(playerid, x, y, z);
			if ((x <= -0.800000) || (y <= -0.800000) || (z <= -0.800000) && (GetPlayerAnimationIndex(playerid) == 1008))
			{
				if (GetPlayerWeapon(playerid) != WEAPON_PARACHUTE)
				{
					format(str, sizeof(str), "[ALERT] %s(%i) is suspected of fly-hacking/air-breaking.", playerName, playerid);
					MessageToAdmins(COLOR_ALERT, str);
				}
			}
		}
	}

	return 1;
}

StopSpectate(const playerid)
{
	TogglePlayerSpectating(playerid, false);
	playerData[playerid][SpecID] = INVALID_PLAYER_ID;
	playerData[playerid][SpecType] = TYPE_SPECTATE_NONE;

	if (playerData[playerid][pd_IsOnDuty])
	{
		SetPlayerSkinEx(playerid, SKIN_STAFF);
	}

	return 1;
}

AdvanceSpectate(playerid)
{
	if (ConnectedPlayers() <= 2)
	{
		StopSpectate(playerid);
		return 1;
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
	{
		for (new x = playerData[playerid][SpecID] + 1; x <= MAX_PLAYERS; x ++)
		{
			if (x == MAX_PLAYERS) x = 0;
			if (IsPlayerConnected(x) && x != playerid)
			{
				if (GetPlayerState(x) == PLAYER_STATE_SPECTATING && playerData[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}

	return 1;
}

ReverseSpectate(const playerid)
{
	if (ConnectedPlayers() <= 2)
	{
		StopSpectate(playerid);
		return 1;
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && playerData[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		for (new x = playerData[playerid][SpecID] - 1; x >= 0; x --)
		{
			if (x == 0) x = MAX_PLAYERS;
			if (IsPlayerConnected(x) && x != playerid)
			{
				if (GetPlayerState(x) == PLAYER_STATE_SPECTATING && playerData[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}

	return 1;
}

EraseVehicle(const vehicleid)
{
	new Float:X,Float:Y,Float:Z;

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		if (IsPlayerInVehicle(i,vehicleid))
		{
			GetPlayerPos(i,X,Y,Z);
			SetPlayerPos(i,X,Y,Z+2);
			SetVehicleToRespawn(vehicleid);
		}
		SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}

	SetTimerEx("VehRes",3000,0,"d",vehicleid);
	return 1;
}

CarSpawner(playerid,model)
{
	if (IsPlayerInAnyVehicle(playerid)) SendScreenMessage(playerid, "You already have a vehicle");
 	else
	{
		new Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);
		if (playerData[playerid][pCar] != INVALID_VALUE) CarDeleter(playerData[playerid][pCar]);
		new const vehicleId = CreateVehicle(model, x, y, z, angle, INVALID_VALUE, INVALID_VALUE, INVALID_VALUE);
		PutPlayerInVehicle(playerid, vehicleId, 0);
		SetVehicleVirtualWorld(vehicleId, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleId, GetPlayerInterior(playerid));
		ChangeVehicleColor(vehicleId,0,7);
		playerData[playerid][pCar] = vehicleId;
	}
}

CarDeleter(const vehicleid)
{
	new Float:X,Float:Y,Float:Z;
	
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i)) continue;
		if (IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			GetPlayerPos(i,X,Y,Z);
			SetPlayerPos(i,X,Y+3,Z);
		}
		SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}

	SetTimerEx("VehRes",1500,0,"i",vehicleid);
}

forward VehRes(vehicleid);
public VehRes(vehicleid)
{
	DestroyVehicle(vehicleid);
	return 1;
}

StartSpectate(const playerid, const targetid)
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (GetPlayerState(i) == PLAYER_STATE_SPECTATING && playerData[i][SpecID] == playerid)
		{
			AdvanceSpectate(i);
		}
	}

	new log[MAX_STRING];
	new Float:Armour;
	GetPlayerArmour(targetid, Armour);
	format(log, sizeof(log), "   Player: %s(%i) | Money: $%i | Health: %.0f | Armor: %.0f", ReturnPlayerName(targetid), targetid, GetPlayerMoney(targetid), ReturnPlayerHealth(targetid), Armour);
	SendClientMessage(playerid, COLOR_NOTIFY, log);
	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	TogglePlayerSpectating(playerid, true);

	if (IsPlayerInAnyVehicle(targetid))
	{
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
		playerData[playerid][SpecID] = targetid;
		playerData[playerid][SpecType] = TYPE_SPECTATE_VEHICLE;
	}
	else
	{
		PlayerSpectatePlayer(playerid, targetid);
		playerData[playerid][SpecID] = targetid;
		playerData[playerid][SpecType] = TYPE_SPECTATE_PLAYER;
	}

	return 1;
}

Slap(playerid)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(playerid,x,y,z+1);
	return 1;
}

GetPlayerRank(const playerid)
{
	new score = GetPlayerScore(playerid);
	for(new i = (sizeof gRanks - 1); i != -1; i--)
	{
		if(score >= gRanks[i][E_RANK_SCORE]) return i;
	}
	return 0;
}

GetFightingStyleName(const type)
{
	new name[MAX_STRING_FIGHTSTYLENAME];

	switch (type)
	{
		case FIGHT_STYLE_NORMAL:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_NORMAL);
		}

		case FIGHT_STYLE_BOXING:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_BOXING);
		}

		case FIGHT_STYLE_KUNGFU:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_KUNGFU);
		}

		case FIGHT_STYLE_KNEEHEAD:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_KNEEHEAD);
		}

		case FIGHT_STYLE_GRABKICK:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_GRABKICK);
		}

		case FIGHT_STYLE_ELBOW:
		{
			format(name, sizeof(name), "%s", LOCALE_FIGHTSTYLE_ELBOW);
		}

		default:
		{
			format(name, sizeof(name), "%s", INVALID_NAME);
		}
	}

	return name;
}

GetPlayerRankName(const playerid)
{
	new name[20];
	strcat(name, gRanks[GetPlayerRank(playerid)][E_RANK_NAME]);
	return name;
}

StopAllPlayerSound(const playerid)
{
	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 1063, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 1069, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 1077, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
	StopAudioStreamForPlayer(playerid);
}

GivePlayerWeaponEx(const playerid, const weaponid, const ammo)
{
	playerWeapon[playerid][weaponid] = true;
	GivePlayerWeapon(playerid, weaponid, ammo);
}

SendMessageToRAdmins(color, const msg[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_AdminRank]) SendClientMessage(i,color,msg);
	}
}

SendMessageTo4(color,const msg[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_AdminRank] >= 4) SendClientMessage(i,color,msg);
	}
}

SendMessageTo5(color,const msg[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_AdminRank] >= 5) SendClientMessage(i,color,msg);
	}
}

CaptureZoneMessage(playerid, messageid)
{
	switch (messageid)
	{
		case 1: SendScreenMessage(playerid, LOCALE_MESSAGE_CANTPERFORMANIMINVEHICLE);
		case 2: SendScreenMessage(playerid, "This zone is already being captured");
		case 3: SendScreenMessage(playerid, LOCALE_MESSAGE_MUSTBEOFFDUTY);
	}
	return 1;
}

public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	if (IsSpectating[playerid] || playerData[playerid][pd_IsOnDuty] || !IsPlayerInAnyVehicle(playerid)) return 1;

	for(new i; i < sizeof gCaptureZones; i++)
	{
		if (checkpointid != gCaptureZones[i][E_CAPTURE_CP]) continue;
		if (playerData[ gCaptureZones[i][E_CAPTURE_ATTACKER] ][pd_TeamId] != playerData[playerid][pd_TeamId]) return 1;

		LeavingZone(playerid, i);
	}
	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if (IsSpectating[playerid]) return 1;
	if (playerData[playerid][pd_IsOnDuty]) return CaptureZoneMessage(playerid, 3);
	
	for(new i; i < sizeof gCaptureZones; i++)
	{
		if (checkpointid != gCaptureZones[i][E_CAPTURE_CP]) continue;
		
		if (!IsPlayerInAnyVehicle(playerid))
			return CaptureZoneMessage(playerid, 1);
		
		if (gCaptureZones[i][E_CAPTURE_OWNER] == playerData[playerid][pd_TeamId])
			return SendScreenMessage(playerid, "This zone is already captured by your team");
		
		if (gCaptureZones[i][E_CAPTURE_ATTACKER] != INVALID_PLAYER_ID && playerData[ gCaptureZones[i][E_CAPTURE_ATTACKER] ][pd_TeamId] != playerData[playerid][pd_TeamId])
			return CaptureZoneMessage(playerid, 2);

		ActiveCaptureZone(playerid, i);
		break;
	}

	return 1;
}

bool:IsValidSkin(const skinid)
{
	return ((SKIN_TRUTH <= skinid <= TOTAL_SKINS) && (skinid != SKIN_INVALID));
}

GetTeamColor(const teamid)
{
	return teamid != NO_TEAM ? gTeams[teamid][E_TEAM_COLOR] : COLOR_TEAM_NONE;
}

CreateAllCaptureZones()
{
	new str[60];
	for(new i; i < sizeof gCaptureZones; i++)
	{
		gCaptureZones[i][E_CAPTURE_OWNER] = NO_TEAM;
		gCaptureZones[i][E_CAPTURE_ATTACKER] = INVALID_PLAYER_ID;
		
		gCaptureZones[i][E_CAPTURE_GANGZONE] = GangZoneCreate(gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][0], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][1], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][2], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][3]);
		gCaptureZones[i][E_CAPTURE_AREA] = CreateDynamicRectangle(gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][0], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][1], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][2], gCaptureZones[i][E_CAPTURE_ZONE_OFFSET][3]);
		
		format(str, sizeof str, "%s\tCaptured by: %s", gCaptureZones[i][E_CAPTURE_NAME], GetTeamName(gCaptureZones[i][E_CAPTURE_OWNER]));

		gCaptureZones[i][E_CAPTURE_CP] = CreateDynamicCP(gCaptureZones[i][E_CAPTURE_CP_OFFSET][0], gCaptureZones[i][E_CAPTURE_CP_OFFSET][1], gCaptureZones[i][E_CAPTURE_CP_OFFSET][2], 4.0);
		gCaptureZones[i][E_CAPTURE_LABEL] = CreateDynamic3DTextLabel(str, GetTeamColor(gCaptureZones[i][E_CAPTURE_OWNER]), gCaptureZones[i][E_CAPTURE_CP_OFFSET][0], gCaptureZones[i][E_CAPTURE_CP_OFFSET][1], gCaptureZones[i][E_CAPTURE_CP_OFFSET][2], 10.0);

		CreateDynamicMapIcon(gCaptureZones[i][E_CAPTURE_CP_OFFSET][0], gCaptureZones[i][E_CAPTURE_CP_OFFSET][1], gCaptureZones[i][E_CAPTURE_CP_OFFSET][2], MAPICON_REDFLAG, 0);
		CreateDynamicPickup(PICKUPICON_TWOPLAYERS, 1, gCaptureZones[i][E_CAPTURE_CP_OFFSET][0], gCaptureZones[i][E_CAPTURE_CP_OFFSET][1], gCaptureZones[i][E_CAPTURE_CP_OFFSET][2]);
	}
	
	return 1;
}

forward OnCaptureZoneUpdate(const zoneid);
public OnCaptureZoneUpdate(const zoneid)
{
	gCaptureZones[zoneid][E_CAPTURE_COUNTDOWN] += gCaptureZones[zoneid][E_CAPTURE_PLAYERS];

	new str1[35];
	format(str1, sizeof(str1),"PROCESSING:~n~~y~%d%%", gCaptureZones[zoneid][E_CAPTURE_COUNTDOWN] * 4);
	
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if (IsPlayerInDynamicCP(i, gCaptureZones[zoneid][E_CAPTURE_CP]) && !IsPlayerInAnyVehicle(i) && playerData[i][pd_TeamId] == playerData[ gCaptureZones[zoneid][E_CAPTURE_ATTACKER] ][pd_TeamId])
		{
			TextDrawSetString(CountText[i], str1);
			TextDrawShowForPlayer(i, CountText[i]);
		}
	}

	if(gCaptureZones[zoneid][E_CAPTURE_COUNTDOWN] > 25)
	{
		KillTimer(gCaptureZones[zoneid][E_CAPTURE_TIMER]);
		OnZoneCaptured(gCaptureZones[zoneid][E_CAPTURE_ATTACKER], zoneid);
	}
	return 1;
}

OnZoneCaptured(const playerid, const zoneid)
{
	new message[MAX_STRING];
	format(message, sizeof message, "You have assisted in capturing '%s' and recieved 2 scores and $1,000 money!", gCaptureZones[zoneid][E_CAPTURE_NAME]);

	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
		if (IsPlayerInDynamicCP(i, gCaptureZones[zoneid][E_CAPTURE_CP]) && !IsPlayerInAnyVehicle(i) && playerData[i][pd_TeamId] == playerData[ gCaptureZones[zoneid][E_CAPTURE_ATTACKER] ][pd_TeamId])
		{
			TextDrawHideForPlayer(i, CountText[i]);

			if (i != gCaptureZones[zoneid][E_CAPTURE_ATTACKER])
			{
				SendClientMessage(playerid, COLOR_REWARD, message);
				GivePlayerCash(playerid, 1000);
				GivePlayerScore(playerid, 2);
			}
		}
	}

	GivePlayerScore(playerid, 5);
	GivePlayerCash(playerid, 5000);
	PlayerPlaySound(playerid, SOUND_CAPTURE, 0.0, 0.0, 0.0);
	playerData[playerid][pd_CapturedZones] ++;

	format(message, sizeof(message), "You have captured '%s' and received 5 scores and $5,000 money!", gCaptureZones[zoneid][E_CAPTURE_NAME]);
	SendClientMessage(playerid, COLOR_REWARD, message);
	
	format(message, sizeof(message), "[%s HQ] We have captured '%s'! You received 1 score for it.", GetTeamName(playerData[playerid][pd_TeamId]), gCaptureZones[zoneid][E_CAPTURE_NAME]);
	SendMessageToTeam(playerData[playerid][pd_TeamId], GetTeamColor(playerData[playerid][pd_TeamId]), message);
	
	GiveScoreToTeam(playerData[playerid][pd_TeamId], 1);

	format(message, sizeof(message), "[NEWS] %s %s(%i) has captured '%s' for team %s!", GetPlayerRankName(playerid), ReturnPlayerName(playerid), playerid, gCaptureZones[zoneid][E_CAPTURE_NAME], GetTeamName(playerData[playerid][pd_TeamId]));
	SendClientMessageToAll(COLOR_NEWS, message);

	gCaptureZones[zoneid][E_CAPTURE_OWNER] = playerData[playerid][pd_TeamId];
	gCaptureZones[zoneid][E_CAPTURE_ATTACKER] = INVALID_PLAYER_ID;
	gCaptureZones[zoneid][E_CAPTURE_COUNTDOWN] = 0;
	gCaptureZones[zoneid][E_CAPTURE_PLAYERS] = 0;

	format(message, sizeof message, "%s\nCaptured by: %s", gCaptureZones[zoneid][E_CAPTURE_NAME], gCaptureZones[zoneid][E_CAPTURE_OWNER]);
	UpdateDynamic3DTextLabelText(gCaptureZones[zoneid][E_CAPTURE_LABEL], GetTeamColor(gCaptureZones[zoneid][E_CAPTURE_OWNER]), message);

	GangZoneStopFlashForAll(gCaptureZones[zoneid][E_CAPTURE_GANGZONE]);
	GangZoneShowForAll(gCaptureZones[zoneid][E_CAPTURE_GANGZONE], GetTeamColor(gCaptureZones[zoneid][E_CAPTURE_OWNER]));
	return 1;
}

ActiveCaptureZone(const playerid, const zoneid)
{
	gCaptureZones[zoneid][E_CAPTURE_ATTACKER] = playerid;
	gCaptureZones[zoneid][E_CAPTURE_COUNTDOWN] = 0;
	gCaptureZones[zoneid][E_CAPTURE_PLAYERS] += 1;
	gCaptureZones[zoneid][E_CAPTURE_TIMER] = SetTimerEx("OnCaptureZoneUpdate", 1000, false,"i", zoneid);

	new message[64];
	format(message, sizeof message, "[HINT] Stay in the red checkpoint for 25 seconds to capture the '%s'.", gCaptureZones[zoneid][E_CAPTURE_NAME]);
	SendClientMessage(playerid, COLOR_HINT, message);
	
	format(message, sizeof(message), "[%s HQ] '%s' is under attack!", GetTeamName(gCaptureZones[zoneid][E_CAPTURE_OWNER]), gCaptureZones[zoneid][E_CAPTURE_NAME]);
	SendTeamMessage(gCaptureZones[zoneid][E_CAPTURE_OWNER], GetTeamColor(gCaptureZones[zoneid][E_CAPTURE_OWNER]), message);
	return 1;
}

LeavingZone(const playerid, const zoneid)
{
	if(playerData[playerid][pd_TeamId] != playerData[ gCaptureZones[zoneid][E_CAPTURE_ATTACKER] ][pd_TeamId]) return 1;

	TextDrawHideForPlayer(playerid, CountText[playerid]);

	gCaptureZones[zoneid][E_CAPTURE_PLAYERS] -= 1;

	if(!gCaptureZones[zoneid][E_CAPTURE_PLAYERS])
	{
		gCaptureZones[zoneid][E_CAPTURE_ATTACKER] = INVALID_PLAYER_ID;		
		KillTimer(gCaptureZones[zoneid][E_CAPTURE_TIMER]);
		GangZoneStopFlashForAll(gCaptureZones[zoneid][E_CAPTURE_GANGZONE]);

		SendClientMessage(playerid, COLOR_NOTIFY, "   The operation of capture has been cancelled.");
	}
	else
	{
		if(playerid == gCaptureZones[zoneid][E_CAPTURE_ATTACKER])
		{
			for (new i, j = GetPlayerPoolSize(); i <= j; i ++)
			{
				if (!IsPlayerInGame(i)) continue;

				if (IsPlayerInDynamicCP(i, gCaptureZones[zoneid][E_CAPTURE_CP]) && !IsPlayerInAnyVehicle(i) && playerData[i][pd_TeamId] == playerData[ gCaptureZones[zoneid][E_CAPTURE_ATTACKER] ][pd_TeamId])
				{
					gCaptureZones[zoneid][E_CAPTURE_ATTACKER] = i;

					new str[MAX_STRING], name[MAX_PLAYER_NAME];
					GetPlayerName(playerid, name, sizeof(name));
					format(str, sizeof str, "   %s is no longer the initial zone capturer. You're now in place of that position.", name);
					SendClientMessage(i, COLOR_NOTIFY, str);

					format(str, sizeof str, "[HINT] Stay in the red checkpoint for 25 seconds to capture the '%s'.", gCaptureZones[zoneid][E_CAPTURE_NAME]);
					SendClientMessage(i, COLOR_HINT, str);

					SendClientMessage(playerid, COLOR_NOTIFY, "   You left the red checkpoint before capture! You're no longer the initial zone capturer.");
					break;
				}
			}
		}
		else
		{
			SendClientMessage(playerid, COLOR_NOTIFY, "   You left the red checkpoint before capture! You're no longer assisting in capture!");
		}
	}
	return 1;
}

forward SpawnProtection(const playerid);
public SpawnProtection(const playerid)
{
	KillTimer(playerData[playerid][player_TmrSpawnProtection]);
	SendClientMessage(playerid, COLOR_NOTIFY, "   The anti spawn-kill protection has ended.");
	AntiSK[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	GivePlayerClassWeapons(playerid);

	if ((playerData[playerid][pd_ClassId] == CLASS_SNIPER) || (playerData[playerid][pd_ClassId] == CLASS_DONATOR))
	{
		SetPlayerColor(playerid, SET_ALPHA(gTeams[ playerData[playerid][pd_TeamId] ][E_TEAM_COLOR], 00));
	}

	return 1;
}

GivePlayerClassWeapons(const playerid)
{
	ResetPlayerWeaponsEx(playerid);

	switch (playerData[playerid][pd_ClassId])
	{
		case CLASS_SOLDIER:
		{
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 50); // Deagle
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGSPA, 200); // Spaz
			GivePlayerWeaponEx(playerid, WEAPON_AK47, 300); // M4
		}

		case CLASS_SNIPER:
		{
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGSPA, 100);
			GivePlayerWeaponEx(playerid, WEAPON_SNIPER, 200); // Sniper
			GivePlayerWeaponEx(playerid, WEAPON_SILENCED, 200); // Silenced.
			GivePlayerWeaponEx(playerid, WEAPON_KNIFE, 1); // Knife.
		}

		case CLASS_ENGINEER:
		{
			GivePlayerWeaponEx(playerid, WEAPON_M4, 300); // M4
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 300); // Shotgun
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 50); // Deagle
			GivePlayerWeaponEx(playerid, WEAPON_GRENADE, 3); // Grenades
		}

		case CLASS_JETTROOPER:
		{
			GivePlayerWeaponEx(playerid, WEAPON_TEC9, 500); // M4
			GivePlayerWeaponEx(playerid, WEAPON_KATANA, 2);
			GivePlayerWeaponEx(playerid, WEAPON_COLT45, 100); // Colt
			GivePlayerWeaponEx(playerid, WEAPON_GRENADE, 2); // Grenades
		}

		case CLASS_PILOT:
		{
			GivePlayerWeaponEx(playerid, WEAPON_AK47, 400); // M4
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 300); // Shotgun
			GivePlayerWeaponEx(playerid, WEAPON_COLT45, 150); // Deagle
		}

		case CLASS_SUPPORT:
		{
			GivePlayerWeaponEx(playerid, WEAPON_CHAINSAW, 1);// Katana
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 100);// Deagle
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGSPA, 200);// Spaz
			GivePlayerWeaponEx(playerid, WEAPON_AK47, 1000);// Ak 47
			GivePlayerWeaponEx(playerid, WEAPON_SNIPER, 50); // Sniper
		}

		case CLASS_SPY:
		{
			GivePlayerWeaponEx(playerid, WEAPON_KNIFE, 1);// Knife
			GivePlayerWeaponEx(playerid, WEAPON_MP5, 200);// MP5
			GivePlayerWeaponEx(playerid, WEAPON_M4, 150);// M4
			GivePlayerWeaponEx(playerid, WEAPON_SILENCED, 50);// Silenced
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 100); // Shotgun
		}

		case CLASS_DEMOLISHER:
		{
			GivePlayerWeaponEx(playerid, WEAPON_CHAINSAW, 1); // Chainsaw.
			GivePlayerWeaponEx(playerid, WEAPON_COLT45, 100); // Colt 45.
			GivePlayerWeaponEx(playerid, WEAPON_AK47, 100); // Ak 47.
			GivePlayerWeaponEx(playerid, WEAPON_ROCKETLAUNCHER, 5); // RPG.
			GivePlayerWeaponEx(playerid, WEAPON_GRENADE, 10); // Grenade.
		}

		case CLASS_TERMINATOR:
		{
			GivePlayerWeaponEx(playerid, WEAPON_KNIFE, 1); // Knife.
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 400); // Deagle
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGSPA, 300); // Combat Shotgun
			GivePlayerWeaponEx(playerid, WEAPON_SNIPER, 200); // Sniper
			GivePlayerWeaponEx(playerid, WEAPON_M4, 500); // M4
			GivePlayerWeaponEx(playerid, WEAPON_MINIGUN, 50); // Minigun
		}

		case CLASS_DONATOR:
		{
			GivePlayerWeaponEx(playerid, WEAPON_M4, 1500); // M4
			GivePlayerWeaponEx(playerid, WEAPON_SAWEDOFF, 1500); // Shotgun
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 1500); // Deagle
			GivePlayerWeaponEx(playerid, WEAPON_GRENADE, 30); // Grenades
			GivePlayerWeaponEx(playerid, WEAPON_SNIPER, 1500); // Sniper
			GivePlayerWeaponEx(playerid, WEAPON_KNIFE, 1); // Knife
		}
	}
}

UpdateLabelText(const playerid)
{
	new string[MAX_STRING];
	format(string, sizeof(string), "%s - %s\n %s", GetPlayerRankName(playerid), GetTeamName(playerData[playerid][pd_TeamId]), GetPlayerClassName(playerid));

	Update3DTextLabelText(t3dRankLabel[playerid], GetTeamColor(playerData[playerid][pd_TeamId]), string);
}

forward RandomMessage();
public RandomMessage()
{
	SendClientMessageToAll(COLOR_TIP, gMessages[random(sizeof gMessages)]);
	return 1;
}

HideAllPlayerDialog(const playerid)
{
	ShowPlayerDialog(playerid, INVALID_VALUE, 0, " ", " ", " ", " ");
}

public OnPlayerCleoDetected(playerid, cleoid)
{
	switch (cleoid)
	{
		case CLEO_FAKEKILL:
		{
			new fakekill[MAX_STRING];
			format(fakekill, sizeof(fakekill),"[SERVER] %s(%i) has been kicked by server, reason: Fake Killing.", ReturnPlayerName(playerid), playerid);
			SendClientMessageToAll(COLOR_SERVER, fakekill);
			SendClientMessage(playerid, COLOR_NOTIFY, "   You have been kicked from the server.");
			SetTimerEx("KickEx", TIMER_KICK, false, "i", playerid);
		}
	}

	return 1;
}

stock SendClientMessageEx(playerid, color, form[], {Float, _}: ...)
{
	#pragma unused form

	static tmp[145];
	new t1 = playerid, t2 = color ;
	const n4 = -4, n16 = -16, size = sizeof tmp;
	#emit stack 28
	#emit push.c size
	#emit push.c tmp
	#emit stack n4
	#emit sysreq.c format
	#emit stack n16
	return SendClientMessage(t1, t2, tmp);
}

SetPlayerPosEx(const playerid, const Float:x, const Float:y, const Float:z, Float:angle = 0.0, vw = 0, interior = 0)
{
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, angle);
	SetPlayerVirtualWorld(playerid, vw);
	SetPlayerInterior(playerid, interior);
	SetCameraBehindPlayer(playerid);
}

ReturnWeaponName(const id)
{
	new name[MAX_STRING_WEAPONNAME];
	GetWeaponName(id, name, sizeof(name));
	return name;
}

PlayerBuyWeapon(const playerid, const cost, const weaponid, const ammo)
{
	if (GetPlayerMoney(playerid) < cost)
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_CANNOTAFFORD);
		return;
	}

	TakePlayerCash(playerid, cost);
	GivePlayerWeaponEx(playerid, weaponid, ammo);
	SendClientMessageEx(playerid, COLOR_NOTIFY, "   You have purchased a %s with %i ammo for $%i.", ReturnWeaponName(weaponid), ammo, cost);
}

/*public OnPlayerAirbreak(playerid)
{
	if (!GetPVarInt(playerid, "IsWarnedHacking"))
	{
		new message[MAX_STRING];
		format(message, sizeof(message), "[ALERT] %s(%i) is suspected of air-breaking.", ReturnPlayerName(playerid), playerid);
		MessageToAdmins(COLOR_ALERT, message);
		SetPVarInt(playerid, "IsWarnedHacking", true);
	}

	return 1;
}*/

/*public OnPlayerPause(playerid)
{
	if (Captureing{playerid} == true)
	{
		SetPlayerHealth(playerid, 0.0);
		TakePlayerScore(playerid, 3);
		TakePlayerCash(playerid, 5000);
		new message[MAX_STRING];
		format(message, sizeof(message), "[ALERT] %s(%i) has been fined and killed by server, reason: AFK/Alt-Tab capturing.", ReturnPlayerName(playerid), playerid);
		MessageToAdmins(COLOR_ALERT, message);
	}

	return 1;
}*/

public OnPlayerResume(playerid)
{
	return 1;
}

IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
	new Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, X, Y, Z);
	if (X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY) {
		return 1;
	}
	return 0;
}

DisplayDialogMessage(const playerid, title[], message[])
{
	ShowPlayerDialog(playerid, INVALID_VALUE, 0, " ", " ", " ", "");
	ShowPlayerDialog(playerid, DIALOG_GLOBAL, DIALOG_STYLE_MSGBOX, title, message, "OK", "");
}

IsEnemyInRange(const playerid)
{
	new Float:x, Float:y, Float:z;

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		GetPlayerPos(i, x, y, z);
		if (IsPlayerInRangeOfPoint(playerid, 50.0 , x, y, z) && (playerData[playerid][pd_TeamId] != playerData[i][pd_TeamId]) && !playerData[i][pd_IsOnDuty])
		{
			return 1;
		}
	}

	return 0;
}

forward HidePlayerScreenMessage(const playerid);
public HidePlayerScreenMessage(const playerid)
{
	PlayerTextDrawSetString(playerid, playerData[playerid][player_TdScreenMessage], " ");
	return 1;
}

SendScreenMessage(const playerid, message[])
{
	PlayerTextDrawSetString(playerid, playerData[playerid][player_TdScreenMessage], message);
	SetTimerEx("HidePlayerScreenMessage", TIMER_SCREENMESSAGE, false, "i", playerid);
	return 1;
}

GivePlayerCash(const playerid, const amount)
{
	PlayerPlaySound(playerid, SOUND_MONEYCHANGE, 0.0, 0.0, 0.0);
	playerData[playerid][pd_Money] = playerData[playerid][pd_Money] + amount;
	GivePlayerMoney(playerid, amount);
}

TakePlayerCash(const playerid, const amount)
{
	PlayerPlaySound(playerid, SOUND_MONEYCHANGE, 0.0, 0.0, 0.0);
	GivePlayerMoney(playerid, -amount);
	playerData[playerid][pd_Money] = playerData[playerid][pd_Money] - amount;
}

SetPlayerCash(const playerid, const amount)
{
	ResetPlayerMoney(playerid);
	playerData[playerid][pd_Money] = amount;
	GivePlayerMoney(playerid, amount);
}

SendMessageToRange(const playerid, const Float:radius, const virtualworld, const color, message[])
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (IsPlayerInRangeOfPoint(i, radius, x, y, z) && (virtualworld == GetPlayerVirtualWorld(i)))
		{
			SendClientMessage(i, color, message);
		}
	}
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if (!IsPlayerInGame(playerid) || !playerData[playerid][pd_IsLoggedIn])
	{
		SendScreenMessage(playerid, LOCALE_MESSAGE_YOUARENOTLOGGED);
		return 0;
	}

	#if (GAMEMODE_DEVELOPMODE == false)
	if ((!IsSpectating[playerid] && !IsPlayerSpawned(playerid)) || IsPlayerDead(playerid))
	{
		SendScreenMessage(playerid, "You are not spawned yet");
		return 0;
	}
	#endif

	if (playerData[playerid][JailTime] && !playerData[playerid][pd_AdminRank])
	{
		SendScreenMessage(playerid, "You cannot use commands in jail");
		return 0;
	}

	if ((LastCommandTime[playerid] != 0) && (gettime() - LastCommandTime[playerid] < 2))
	{
		if (!playerData[playerid][pd_AdminRank])
		{
			SendScreenMessage(playerid, "You must wait few seconds before using another command");
			return 0;
		}
	}

	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	#pragma unused cmdtext

	if (success)
	{
		LastCommandTime[playerid] = gettime();
	}
	else
	{
		SendScreenMessage(playerid, "Unknown command");
		SendClientMessage(playerid, COLOR_HINT, "[HINT] Type '/commands' for a list of commands or type '/help' for guides.");
	}

	return 1;
}

SendCMDMessge(playerid,command[])
{
	if (ServerInfo[AdminCmdMsg] == 0) return;

	new string[MAX_STRING];
	format(string,sizeof(string),"[VIP] %s(%i) has used command /%s", ReturnPlayerName(playerid), playerid, command);
	SendMessageToStaff(COLOR_STAFFCOMMAND, string);
}

GiveAmmo(const playerid)
{
	new slot, ammo;
	new weaponid = GetPlayerWeapon(playerid);

	for (slot = 0; slot < TOTAL_SLOT_WEAPON; slot ++)
	{
		GetPlayerWeaponData(playerid, slot, weaponid, ammo);
		if (IsValidWeapon(weaponid))
		{
			if (weaponid == WEAPON_GRENADE || weaponid == WEAPON_ROCKETLAUNCHER || weaponid == WEAPON_MOLTOV || weaponid == WEAPON_TEARGAS)
			{
				GivePlayerWeaponEx(playerid, weaponid, 1);
	 		}
		  	else
			{
				GivePlayerWeaponEx(playerid, weaponid, 100);
			}
		}
	}

	return 1;
}

GetTeamCount(const teamid)
{
	new count;
	foreach(new i : Player)
	{
		if (!IsPlayerInGame(i) || GetPlayerState(i) == PLAYER_STATE_NONE) continue;
		if (playerData[i][pd_TeamId] != teamid) continue;
		count ++;
	}

	return count;
}

forward CountDown();
public CountDown()
{
	nuke_time -= 1;

	return 1;
}

GetTeamName(const teamid)
{
	new name[15] = "None";
	if(teamid != NO_TEAM) format(name, sizeof name, gTeams[teamid][E_TEAM_NAME]);
	return name;
}

SendTeamMessage(const teamid, const color, string[])
{
	for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
	{
		if (!IsPlayerInGame(i) || !playerData[i][pd_IsLoggedIn]) continue;
		if (playerData[i][pd_TeamId] == teamid)
		{
			SendClientMessage(i, color, string);
		}
	}

	return 1;
}

forward HideVehicleNameTD(const playerid);
public HideVehicleNameTD(const playerid)
{
	PlayerTextDrawHide(playerid, playerData[playerid][pd_TDVehicleName]);
	return 1;
}

// Procedure

ShowVehicleNameTD(const playerid, const vehiclemodelid)
{
	PlayerTextDrawSetString(playerid, playerData[playerid][pd_TDVehicleName], vehicleNames[vehiclemodelid - MIN_VEHICLEMODELID]);
	PlayerTextDrawShow(playerid, playerData[playerid][pd_TDVehicleName]);
	SetTimerEx("HideVehicleNameTD", 3000, false, "i", playerid);
}

RemoveAllBuildingsForPlayer(const playerid)
{
	// Mansion
	RemoveBuildingForPlayer(playerid, 16388, 694.41406, 1973.8359, 4.53125, 28.782139); // removeWorldObject (des_studbldg) (1)
	RemoveBuildingForPlayer(playerid, 16626, 694.41406, 1973.8359, 4.53125, 28.782139); // (LOD) removeWorldObject (des_studbldg) (1)
	RemoveBuildingForPlayer(playerid, 1535, 693.39966, 1968.0391, 5.21189, 3.458308); // removeWorldObject (Gen_doorEXT14) (1)
	RemoveBuildingForPlayer(playerid, 16389, 704.41406, 1978.7031, 3.92969, 52.572056); // removeWorldObject (des_studgrnd) (1)
	RemoveBuildingForPlayer(playerid, 16624, 704.41406, 1978.7031, 3.92969, 52.572056); // (LOD) removeWorldObject (des_studgrnd) (1)
	RemoveBuildingForPlayer(playerid, 669, 684.36719, 1957.6094, 4.45313, 12.053597); // removeWorldObject (sm_veg_tree4) (1)
	RemoveBuildingForPlayer(playerid, 652, 725.03906, 1991.1172, 3.54688, 12.086936); // removeWorldObject (sjmpalmbig) (1)
	RemoveBuildingForPlayer(playerid, 700, 716.05469, 1999.2422, 4.23438, 11.084518); // removeWorldObject (sm_veg_tree6) (1)
	RemoveBuildingForPlayer(playerid, 669, 681.74219, 1993.1641, 3.64844, 12.053597); // removeWorldObject (sm_veg_tree4) (2)
	RemoveBuildingForPlayer(playerid, 700, 705.55469, 1956.4219, 4.72656, 11.084518); // removeWorldObject (sm_veg_tree6) (2)
	RemoveBuildingForPlayer(playerid, 669, 717.77344, 1959.1563, 4.45313, 12.053597); // removeWorldObject (sm_veg_tree4) (3)
	RemoveBuildingForPlayer(playerid, 652, 722.39063, 1924.875, 4.27344, 12.086936); // removeWorldObject (sjmpalmbig) (2)
	RemoveBuildingForPlayer(playerid, 652, 678.86719, 2011.7578, 4.28125, 12.086936); // removeWorldObject (sjmpalmbig) (3)
	//Italian Villa
	//Luxury Cottage
	RemoveBuildingForPlayer(playerid, 11654, -681.8750, 965.8906, 11.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -730.4297, 905.1172, 12.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -716.6406, 903.9844, 12.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -698.9609, 909.6719, 11.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -687.3125, 909.6016, 11.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -710.6094, 909.7422, 11.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -729.5313, 916.5391, 12.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -728.7500, 928.1641, 12.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -712.0703, 928.3047, 11.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -727.9688, 939.7891, 12.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -727.1875, 951.4141, 12.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -709.3203, 991.1641, 12.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -700.6563, 984.1406, 11.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -697.6719, 990.9922, 12.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -686.0234, 990.8203, 11.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -665.5625, 912.9453, 11.9766, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -675.6641, 909.5313, 12.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1223, -683.0703, 920.4844, 10.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 11492, -681.8750, 965.8906, 11.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -656.5781, 974.4688, 11.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -674.3750, 990.6484, 11.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -662.7266, 990.4766, 11.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -650.1953, 928.1953, 11.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -645.8828, 937.9063, 11.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -645.7109, 949.5547, 11.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -645.5391, 961.2031, 11.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -645.3672, 972.8516, 12.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -645.1953, 984.5000, 12.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 3276, -651.0781, 990.3047, 11.9219, 0.25);
	//Rusty Bridge
	RemoveBuildingForPlayer(playerid, 16609, -1024.4141, 2710.7188, 48.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16611, -1143.7109, 2696.8438, 48.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16037, -1143.7109, 2696.8438, 48.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16610, -1024.4141, 2710.7188, 48.4063, 0.25);
	//Abandon Gas Station
	RemoveBuildingForPlayer(playerid, 1686, -1477.6563, 1859.7344, 31.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1464.9375, 1860.5625, 31.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1477.8516, 1867.3125, 31.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 11505, -1471.4922, 1864.8516, 36.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1686, -1465.4766, 1868.2734, 31.8203, 0.25);
	//Big Ear
	RemoveBuildingForPlayer(playerid, 16614, -346.6719, 1595.0781, 79.6641, 0.25);
	RemoveBuildingForPlayer(playerid, 16616, -326.6953, 1541.3906, 74.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 16138, -326.6953, 1541.3906, 74.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 16613, -346.6719, 1595.0781, 79.6641, 0.25);
	// Military Camp
	RemoveBuildingForPlayer(playerid, 16411, -806.0078, 2387.6719, 153.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 3275, -812.0547, 2406.4531, 155.9688, 100.0);
	RemoveBuildingForPlayer(playerid, 3350, -773.0391, 2419.6484, 155.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 3260, -774.2266, 2421.2656, 157.0313, 100.0);
	RemoveBuildingForPlayer(playerid, 3302, -774.2031, 2425.3672, 159.2969, 100.0);
	RemoveBuildingForPlayer(playerid, 16404, -772.1641, 2424.2031, 157.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 16405, -809.6953, 2429.2188, 157.7656, 0.25);
	// Desert Airport
	RemoveBuildingForPlayer(playerid, 3369, 349.8750, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 242.3984, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3369, 188.6563, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3367, 296.1406, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 16598, 231.2813, 2545.7969, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 188.6563, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 242.3984, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 16599, 231.2813, 2545.7969, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3271, 296.1406, 2438.2500, 15.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 3269, 349.8750, 2438.2500, 15.4766, 0.25);
	// Gas Station
	RemoveBuildingForPlayer(playerid, 669, 551.1016, 1221.3594, 10.7578, 0.25);
	// Stadium
	RemoveBuildingForPlayer(playerid, 3509, 1363.8828, 2077.3672, 9.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1351.3906, 2079.4766, 9.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1375.4297, 2079.8828, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1362.2031, 2087.7813, 12.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1323.4766, 2094.1797, 10.8750, 0.25);
	// Useless Object Remover
	RemoveBuildingForPlayer(playerid, 3853, -2651.7813, 227.8672, 3.3281, 9999);
	RemoveBuildingForPlayer(playerid, 3854, -2651.7813, 227.8672, 3.3281, 9999);
	RemoveBuildingForPlayer(playerid, 3855, -2651.7813, 227.8672, 3.3281, 9999);
	// Area-51
	RemoveBuildingForPlayer(playerid, 1411, 347.1953, 1799.2656, 18.7578, 0.25); // Fence - DYN_MESH_1
	RemoveBuildingForPlayer(playerid, 1411, 342.9375, 1796.2891, 18.7578, 0.25); // Fence - DYN_MESH_1
	RemoveBuildingForPlayer(playerid, 16670, 330.7891, 1813.2188, 17.8281, 0.25); // Large fence - a51_extfence02
	RemoveBuildingForPlayer(playerid, 16095, 279.1328, 1829.7813, 16.6328, 0.25); // des_a51guardbox02
	RemoveBuildingForPlayer(playerid, 16094, 191.1406, 1870.0391, 21.4766, 0.25); // Large fence - des_a51infenc
	RemoveBuildingForPlayer(playerid, 16096, 120.5078, 1934.0313, 19.8281, 0.25); // des_a51guardbox04
	// Australia
	RemoveBuildingForPlayer(playerid, 3297, -1568.1016, 2709.6484, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -1518.0313, 2698.5938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1464.3438, 2656.5000, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 11600, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1477.5859, 2549.2344, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1448.1328, 2690.7813, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1476.0391, 2565.3984, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1548.3359, 2699.6172, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1463.7656, 2692.8594, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -1448.8594, 2560.5703, 54.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 3357, -1523.8047, 2656.6563, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 11671, -1459.9375, 2583.1563, 57.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 11672, -1520.9609, 2577.1641, 58.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 11625, -1430.5781, 2303.7578, 62.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1560.2266, 2617.7031, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 11456, -1520.9609, 2577.1641, 58.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -1520.8906, 2597.0391, 59.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -1509.6563, 2611.1172, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 11449, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 11460, -1523.2891, 2618.5938, 65.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1515.2578, 2635.2188, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1476.0391, 2565.3984, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1477.5859, 2549.2344, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1470.7891, 2553.7109, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1579.9141, 2676.8594, 55.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1551.2734, 2610.6172, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1540.1563, 2590.8125, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1462.4063, 2527.0078, 54.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1464.2500, 2556.2344, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1515.5547, 2595.2969, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1476.7813, 2573.4141, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1467.9531, 2595.4297, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1517.7422, 2677.1484, 55.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1486.3359, 2657.2578, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1461.2344, 2678.8359, 55.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1485.8516, 2680.7422, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1436.1016, 2655.4766, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1486.0000, 2607.6406, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1460.7891, 2611.2422, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1438.6719, 2630.0234, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1553.0156, 2680.6563, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -1536.2891, 2661.4688, 55.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 11450, -1459.9375, 2583.1563, 57.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1454.2734, 2640.1406, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1458.9531, 2565.6641, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1459.3203, 2552.8281, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 11461, -1466.0313, 2637.5938, 54.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1457.8672, 2648.9922, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -1448.8594, 2560.5703, 54.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1437.4141, 2558.0859, 54.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -1450.6406, 2591.4688, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1403.4766, 2611.8047, 55.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1393.0625, 2616.0859, 54.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1441.7891, 2647.3281, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1568.1016, 2709.6484, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1548.3359, 2699.6172, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1538.3906, 2683.9609, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1506, -1532.1328, 2657.4063, 55.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 3355, -1523.8047, 2656.6563, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -1518.0313, 2698.5938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1504.0859, 2704.5859, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1521.6094, 2707.5781, 55.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1464.3438, 2656.5000, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1448.1328, 2690.7813, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1463.7656, 2692.8594, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -1454.8906, 2698.2031, 55.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1449.5234, 2705.4766, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1466.9922, 2705.9453, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1437.5234, 2691.8984, 55.2422, 0.25);
	// Russia
	RemoveBuildingForPlayer(playerid, 16413, -174.2109, 1120.4531, 24.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16433, -177.4375, 1056.3906, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 16440, 12.1172, 1178.5391, 20.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 16441, -32.5234, 1185.1875, 22.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 16443, -161.1719, 1179.5313, 22.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 16476, -98.1953, 1180.0703, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 3371, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3371, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 3373, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 16617, -122.7422, 1122.7500, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16618, -117.7656, 1079.4609, 22.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3372, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 16672, 86.9063, 1182.6641, 21.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 16738, -217.4922, 1026.8203, 27.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 16061, -193.3750, 1055.2891, 18.3203, 0.25);
	RemoveBuildingForPlayer(playerid, 16007, -177.4375, 1056.3906, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -233.1172, 1061.6563, 18.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -179.8984, 1069.4297, 19.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -169.3594, 1077.4766, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 774, -82.9688, 1022.7813, 18.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -127.8750, 1058.6641, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 780, -147.2500, 1055.5156, 18.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -120.4766, 1061.2109, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -82.2969, 1060.2734, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 769, -96.9453, 1054.9297, 18.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1071.1641, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -139.3984, 1067.3516, 19.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -164.3750, 1078.3906, 17.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1076.4453, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1028.4141, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, -38.0469, 1045.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -51.6875, 1042.5938, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -55.5078, 1035.3828, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -51.1484, 1052.1094, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -20.2266, 1057.6406, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -38.0313, 1075.8828, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -51.1406, 1064.8125, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 11.8594, 1009.8125, 17.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 780, 26.6094, 1030.3281, 16.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 773, 4.9453, 1052.8906, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, 6.9453, 1075.8828, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 44.5469, 1003.7813, 15.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 769, 53.2188, 1039.1484, 13.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 75.7500, 1067.0469, 11.5234, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -228.3828, 1111.8750, 18.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 16434, -180.7109, 1081.0781, 27.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -146.9297, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -166.7500, 1107.9688, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -146.8438, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -225.3125, 1127.2109, 18.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -186.4609, 1123.3984, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 16070, -174.2109, 1120.4531, 24.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -160.2656, 1122.5391, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1692, -161.7656, 1115.8516, 27.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 16760, -178.2031, 1122.3203, 28.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -154.8281, 1137.1406, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1447, -160.0703, 1137.1406, 20.0078, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -149.8516, 1133.7656, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -162.1953, 1136.2266, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16740, -152.3203, 1144.0703, 30.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 16787, -152.3203, 1144.0703, 30.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -161.9297, 1162.0781, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -164.1719, 1153.3125, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -170.1719, 1169.0547, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -149.8203, 1164.1094, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -186.4609, 1173.5625, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -162.0938, 1175.1406, 19.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 16064, -161.1719, 1179.5313, 22.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 1692, -174.2422, 1177.8984, 22.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 3286, -230.2031, 1185.7734, 23.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -159.8594, 1187.8281, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16386, -117.7656, 1079.4609, 22.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -123.8125, 1079.3984, 19.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1081.7188, 19.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1352, -59.7813, 1088.1094, 18.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -86.8438, 1088.4141, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -50.1797, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -136.5391, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1411, -141.7344, 1108.2344, 20.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 1352, -54.9063, 1103.9922, 18.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -133.9844, 1111.0781, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -120.8750, 1110.4219, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -45.7344, 1109.0234, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 3303, -43.0547, 1120.8594, 20.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 16385, -122.7422, 1122.7500, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -53.2656, 1135.5781, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -45.2031, 1130.4141, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 1412, -133.8516, 1134.4141, 20.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -133.3594, 1137.5938, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -106.6719, 1140.0234, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 16788, -49.2422, 1137.7031, 28.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -50.1797, 1144.1094, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -50.5078, 1160.9141, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -41.8125, 1160.0781, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -126.1719, 1159.0703, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -88.8594, 1165.3828, 19.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -47.7031, 1162.3672, 19.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -52.9766, 1162.3672, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -42.4219, 1162.3672, 19.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -96.7188, 1164.3516, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -127.0000, 1173.4219, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -44.3047, 1179.2734, 19.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 16475, -98.1953, 1180.0703, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -46.6953, 1179.5703, 18.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -53.1016, 1188.3281, 18.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -132.0703, 1187.4609, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -76.5313, 1187.6406, 18.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -26.7422, 1080.1719, 18.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -26.4766, 1087.5859, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -3.7813, 1093.6953, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -5.2188, 1112.5703, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -13.2969, 1112.2656, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -4.3125, 1108.9453, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1102.9375, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3304, 6.9531, 1120.8516, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3305, -18.0547, 1120.8594, 21.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -31.8672, 1118.8359, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -36.4922, 1136.0703, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1.5000, 1133.8984, 17.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 773, -18.3906, 1136.8203, 18.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 1.1484, 1137.7578, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -3.7813, 1144.1094, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 12.0156, 1159.5703, 18.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 3.8281, 1159.2969, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 11.4063, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 6.1328, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 0.8594, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -26.4141, 1159.4844, 19.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -30.1719, 1153.3516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -31.3203, 1160.6875, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1345, -24.8203, 1165.4063, 19.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -37.1484, 1162.3672, 19.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, -31.8359, 1162.3672, 19.7188, 0.25);
	RemoveBuildingForPlayer(playerid, 16069, 12.1172, 1178.5391, 20.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 16442, -18.4688, 1178.8828, 29.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 955, -14.7031, 1175.3594, 18.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -13.6953, 1187.4063, 18.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 16068, -32.5234, 1185.1875, 22.4297, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -13.7891, 1185.4922, 18.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -25.7813, 1188.0313, 18.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -0.1484, 1193.6406, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, -25.7813, 1193.6406, 22.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 19.8281, 1085.3984, 19.0469, 0.25);
	RemoveBuildingForPlayer(playerid, 774, 39.5547, 1087.0938, 18.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 19.5781, 1102.9375, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 17.1406, 1136.5938, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 33.6094, 1152.6953, 19.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 24.2969, 1127.8516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 30.4922, 1157.7891, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 22.2578, 1158.4766, 18.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 35.9922, 1157.1875, 18.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 16.6875, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1468, 21.9609, 1160.0234, 19.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 19.5781, 1153.3516, 23.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 27.6719, 1186.5547, 18.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 761, 25.3594, 1187.5859, 18.0391, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 65.0313, 1148.2344, 18.8516, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 59.0391, 1181.6797, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 68.7969, 1117.5781, 17.2578, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 71.1797, 1182.1719, 16.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 773, 72.9063, 1137.3281, 14.5469, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 92.4141, 1099.5313, 12.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 691, 79.3359, 1099.9453, 11.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 669, 90.0859, 1147.8828, 16.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 16673, 86.9063, 1182.6641, 21.5391, 0.25);
	// Asia
	RemoveBuildingForPlayer(playerid, 11570, -805.3984, 1510.7188, 24.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -908.5547, 1514.8047, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -765.3594, 1611.7344, 26.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -880.9219, 1540.3203, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -885.4375, 1512.2578, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -882.8984, 1551.1875, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -881.1641, 1529.9375, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -905.0000, 1541.0547, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3344, -881.4375, 1564.3203, 25.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3344, -906.4375, 1529.9375, 24.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3344, -831.4375, 1587.5313, 25.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 11668, -816.6719, 1602.3516, 27.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 11670, -793.1563, 1557.0391, 33.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -908.5547, 1514.8047, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -902.5156, 1524.5391, 25.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 3171, -906.4375, 1529.9375, 24.8828, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -905.0000, 1541.0547, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -885.4375, 1512.2578, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -881.1641, 1529.9375, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -882.8984, 1551.1875, 24.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3171, -881.4375, 1564.3203, 25.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -880.9219, 1540.3203, 24.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 11478, -814.3125, 1458.8828, 23.7891, 0.25);
	RemoveBuildingForPlayer(playerid, 11469, -861.7578, 1525.7500, 21.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 11470, -860.3828, 1526.5625, 30.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -832.3281, 1525.5391, 20.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -816.4922, 1526.7734, 25.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -857.6719, 1534.6094, 21.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -818.7656, 1546.9922, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11475, -805.3984, 1510.7188, 24.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -795.8906, 1501.7656, 20.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 11426, -800.8438, 1525.2734, 25.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -808.8906, 1523.3594, 26.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 11427, -793.1563, 1557.0391, 33.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -811.4063, 1532.0625, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11433, -788.0391, 1522.6250, 28.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -790.6250, 1552.3828, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -790.2031, 1547.3906, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11437, -775.5938, 1555.6797, 26.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -768.4844, 1502.9141, 24.1484, 0.25);
	RemoveBuildingForPlayer(playerid, 649, -866.7578, 1572.8359, 23.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 652, -871.8438, 1572.4063, 24.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -871.2188, 1564.1563, 24.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -832.1250, 1565.8438, 25.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 11476, -825.7891, 1564.1641, 30.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -826.8438, 1575.6484, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -835.4766, 1574.8594, 24.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 3171, -831.4375, 1587.5313, 25.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -858.2891, 1587.6094, 25.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -828.8672, 1595.0078, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 761, -823.7031, 1593.9922, 26.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -826.3984, 1594.5781, 25.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -818.6016, 1591.2266, 26.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 11564, -853.0625, 1593.5938, 35.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 11425, -816.6719, 1602.3516, 27.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -798.3984, 1566.7578, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -776.6406, 1586.2813, 26.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 11477, -778.9063, 1585.0313, 0.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 700, -781.1016, 1594.1172, 25.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 11566, -792.3984, 1610.1719, 27.4531, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -783.1875, 1601.2266, 26.2031, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -765.3594, 1611.7344, 26.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 4319, -741.5391, 1752.1328, -25.9922, 0.25);
	RemoveBuildingForPlayer(playerid, 4453, -741.5391, 1752.1328, -25.9922, 0.25);
	// USA
	RemoveBuildingForPlayer(playerid, 3301, -216.8750, 2770.1484, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3301, -282.2266, 2719.2578, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -264.0234, 2766.4063, 62.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -166.1328, 2731.0859, 63.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -195.6016, 2768.7578, 61.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -314.1875, 2720.6406, 62.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3298, -258.8438, 2786.1484, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3298, -165.3906, 2708.1016, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -229.2500, 2809.9453, 62.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 3297, -147.7891, 2684.8125, 63.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3345, -167.6797, 2767.1328, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3343, -154.5547, 2761.0078, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -275.1797, 2738.4844, 61.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -289.7422, 2758.2344, 61.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 16761, -312.2422, 2646.3750, 62.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16763, -279.7188, 2650.2109, 61.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 16764, -288.8359, 2682.4297, 61.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 16765, -227.4531, 2716.3516, 62.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 16019, -352.1484, 2648.0547, 64.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 16399, -312.2422, 2646.3750, 62.4063, 0.25);
	RemoveBuildingForPlayer(playerid, 16398, -279.7188, 2650.2109, 61.6875, 0.25);
	RemoveBuildingForPlayer(playerid, 16402, -318.2891, 2650.2422, 69.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 16401, -271.9688, 2662.1953, 61.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 16776, -237.0234, 2662.8359, 62.6094, 0.25);
	RemoveBuildingForPlayer(playerid, 1340, -197.4922, 2659.9141, 62.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 16062, -222.6641, 2663.3047, 66.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 16063, -222.3438, 2663.4531, 71.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -206.6328, 2672.2422, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -278.9688, 2679.0234, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 16396, -288.8359, 2682.4297, 61.6563, 0.25);
	RemoveBuildingForPlayer(playerid, 16020, -155.1797, 2635.5078, 63.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -156.0234, 2675.2031, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -333.5000, 2694.3672, 62.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -283.9453, 2695.3203, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -243.0313, 2688.3047, 62.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -307.9922, 2707.6563, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -263.1563, 2711.1250, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16013, -286.2266, 2709.7266, 73.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 3284, -282.2266, 2719.2578, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -333.5703, 2719.3516, 61.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -314.1875, 2720.6406, 62.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -240.8359, 2737.1484, 62.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -267.9453, 2732.0469, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -275.1797, 2738.4844, 61.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -249.9141, 2744.0859, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -269.6953, 2750.4609, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -291.6094, 2752.6563, 59.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -289.7422, 2758.2344, 61.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -297.8047, 2755.1875, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -267.1719, 2758.3594, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -264.0234, 2766.4063, 62.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3241, -258.8438, 2786.1484, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -245.3125, 2781.4922, 62.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -242.0313, 2789.3438, 61.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -232.1641, 2685.2734, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -238.6016, 2695.5469, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -202.5703, 2687.9688, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -215.6328, 2695.3125, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -193.6406, 2708.7188, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16622, -190.8359, 2707.5859, 73.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 16011, -227.4531, 2716.3516, 62.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -209.7734, 2745.3906, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -231.2813, 2757.4297, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 16014, -228.8359, 2751.6094, 72.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 3284, -216.8750, 2770.1484, 63.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -195.6016, 2768.7578, 61.4844, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -230.4531, 2775.3359, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -213.2891, 2787.9297, 61.9219, 0.25);
	RemoveBuildingForPlayer(playerid, 16015, -235.7891, 2782.9375, 73.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -229.2500, 2809.9453, 62.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -211.9609, 2805.6641, 61.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 3241, -165.3906, 2708.1016, 62.2266, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -155.0938, 2711.2344, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -177.5078, 2687.7188, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -166.1328, 2731.0859, 63.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -181.1953, 2728.2109, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -164.1641, 2754.7656, 61.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -168.4844, 2740.5547, 61.3672, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -186.6563, 2753.1406, 61.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3172, -167.6797, 2767.1328, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -174.5547, 2769.4609, 61.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 3168, -154.5547, 2761.0078, 61.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -147.7891, 2684.8125, 63.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, -150.2734, 2700.0781, 61.1484, 0.25);
	// Europe
	RemoveBuildingForPlayer(playerid, 7628, 997.1641, 2143.2734, 13.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 7672, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 7673, 966.3594, 2140.9688, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 3537, 983.8281, 2268.1953, 12.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 3536, 957.0781, 2268.1250, 12.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 3537, 982.4219, 2316.7969, 12.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 3536, 982.3203, 2343.5469, 12.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1268, 1003.4844, 2178.4922, 25.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3444, 983.8281, 2268.1953, 12.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 3464, 957.0781, 2268.1250, 12.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 3444, 982.4219, 2316.7969, 12.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 3464, 982.3203, 2343.5469, 12.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 7627, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 7926, 969.6250, 2082.1406, 14.1797, 0.25);
	RemoveBuildingForPlayer(playerid, 3474, 978.2891, 2094.9922, 16.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 7647, 1005.2891, 2105.4531, 21.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 7493, 966.3594, 2140.9688, 13.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 1497, 965.8047, 2159.1406, 9.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 1497, 965.7891, 2162.1484, 9.8125, 0.25);
	RemoveBuildingForPlayer(playerid, 7915, 1005.1641, 2178.3984, 31.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 1259, 1003.4844, 2178.4922, 25.1563, 0.25);
	RemoveBuildingForPlayer(playerid, 3459, 997.5078, 2183.0469, 17.3203, 0.25);
}

LaunchNuke(const playerid, const targetteamid, const Float:MinX, const Float:MinY, const Float:MaxX, const Float:MaxY)
{
	if (GetPlayerRank(playerid) >= RANK_PLAYER_LIEUTENANTMAJOR)
	{
		if (GetPlayerMoney(playerid) >= COST_NUKE)
		{
			if (playerData[playerid][pd_TeamId] != targetteamid)
			{
				SendClientMessageToAll(COLOR_NEWS, "[NEWS] The Nuke has been launched to a base!");
				TakePlayerCash(playerid, COST_NUKE);
				nuke_time = 250;
				SendClientMessage(playerid, COLOR_NOTIFY, "   You have launched the Nuke for $" #COST_NUKE ".");
				new Float:x, Float:y, Float:z;
				new string[MAX_STRING_SHORT];
				for (new i = 0, j = GetPlayerPoolSize(); i <= j; i ++)
				{
					if (!IsPlayerInGame(i)) continue;
					if (IsPlayerInArea(i, MinX, Float:MinY, Float:MaxX, Float:MaxY))
					{
						playerData[i][pd_Deaths] ++;
						playerData[playerid][pd_Kills] ++;
						SetPlayerHealth(i, 0.0);
						GetPlayerPos(i, x, y, z);
						CreateExplosion(x, y, z, 12, 10.0);
						GameTextForPlayer(i, "~r~NUKE!", 3000, 4);
						SendDeathMessage(playerid, i, DEATHMESSAGE_EXPLOSION);
						GivePlayerCash(playerid, 1000);
						GivePlayerScore(playerid, 1);
						format(string, sizeof(string), "Killed: %s(%i) | Score: 1 | Money: $1,000", ReturnPlayerName(i), i);
						SendClientMessage(playerid, COLOR_REWARD, string);
					}
				}
			}
			else
			{
				SendScreenMessage(playerid, "You cannot launch nuke to your team");
			}
		}
		else
		{
			SendScreenMessage(playerid, "You need $200,000 to launch nuke");
		}
	}
	else
	{
		format(gString, sizeof gString, "You must be %s (%d) to launch nuke.", gRanks[RANK_PLAYER_LIEUTENANTMAJOR][E_RANK_NAME], RANK_PLAYER_LIEUTENANTMAJOR);
		SendScreenMessage(playerid, gString);
	}
}

AntiDeAMX()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}

GivePlayerHelmet(playerid)
{
	new const SKIN_ID = GetPlayerSkin(playerid);
	SetPlayerAttachedObject(playerid, SLOT_PAO_HAT, 19108, BONE_HEAD, gHelmetOffsets[SKIN_ID][0], gHelmetOffsets[SKIN_ID][1], gHelmetOffsets[SKIN_ID][2], gHelmetOffsets[SKIN_ID][3], gHelmetOffsets[SKIN_ID][4], gHelmetOffsets[SKIN_ID][5], gHelmetOffsets[SKIN_ID][6], gHelmetOffsets[SKIN_ID][7], gHelmetOffsets[SKIN_ID][8]);
	pHasHelmet[playerid] = true;
	return 1;
}