enum E_PLAYERDATA
{
	pd_AccountId,
	// name
	// password
	piEmail[MAX_STRING_EMAIL],
	pd_IP[MAX_STRING_IP],
	// registration_ip
	pd_RegisteredDate[MAX_STRING_DATETIME],
	// lastlogin_date
	// gender
	pd_Score,
	pd_Money,
	pd_AdminRank,
	// developer_rank
	pd_HelperRank,
	pd_VIPRank,
	// vip_start_date
	// vip_end_date
	CTagg,
	// custom_skinid
	// fightingstyle_id
	// weapon_skill
	// new_year_gift
	JailTime,
	// jail_reason
	// jailed_by
	Muted,
	// staff_notes
	// offline_pm
	pd_Kills,
	pd_KillingSpree,
	pd_Deaths,
	Headshots,
	// arena_wins
	// arena_loses
	pd_CapturedZones,
	pd_PlayedTime,
	// total_donates
	// staff_warnings
	// total_bans
	// total_kicks
 	pd_Warnings,
	// imprison_records
	// total_banned_players
	// total_kicked_players
	// total_warned_players
	// total_imprisoned_players
	// Game
	pd_IsLoggedIn,
	pd_TeamId,
	pd_ClassId,
	Float:pd_PreviousX,
	Float:pd_PreviousY,
	Float:pd_PreviousZ,
	Float:pd_PreviousArmor,
	Float:pd_PreviousHealth,
	previousAmmoLots[16],
	previousWeapons[16],
	pd_PreviousVW,
	pd_PreviousInterior,
	pd_CurrentWarnings,
	pd_RealAdminRank,
	PlayerText:player_TdScreenMessage,
	PlayerText:pd_TdGMVersion,
	PlayerText:pd_TDVehicleName,
	PlayerText:pd_TdTeamSelection[2],
	Frozen,
	FreezeTime,
	player_TmrSpawnProtection,
	God,
	GodCar,
	DoorsLocked,
	pCar,
	SpecID,
	SpecType,
	bool:pd_IsOnDuty,
	Clock,
	Hide,
	LoginAttempts
};

// Teams
enum E_TEAM
{
	E_TEAM_NAME[15],
	E_TEAM_COLOR,
	E_TEAM_SKIN,
	Float: E_TEAM_GANGZONE_OFFSET[4]
}

// Capture Zones
enum E_CAPTURE
{
	E_CAPTURE_NAME[25],
	Float: E_CAPTURE_ZONE_OFFSET[4],
	Float: E_CAPTURE_CP_OFFSET[3],

	E_CAPTURE_OWNER,
	E_CAPTURE_ATTACKER,
	E_CAPTURE_COUNTDOWN,
	E_CAPTURE_GANGZONE,
	E_CAPTURE_CP,
	E_CAPTURE_AREA,
	E_CAPTURE_TIMER,
	E_CAPTURE_PLAYERS,
	Text3D: E_CAPTURE_LABEL
};

enum E_RANK
{
	E_RANK_NAME[20],
	E_RANK_SCORE
};

enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	AdminOnlySkins,
	AdminSkin,
	AdminSkin2,
	NameKick,
	PartNameKick,
	AntiSpam,
 	AntiSwear,
 	NoCaps,
	Locked,
	GiveWeap,
	GiveMoney,
	ConnectMessages,
	AdminCmdMsg,
	AutoLogin,
	MaxMuteWarnings,
	DisableChat,
	MustLogin,
	MustRegister,
	AntiBot
};

#if (GAMEMODE_ACTORSTATE == true)
enum E_ACTOR
{
	actor_Id,
	actor_SkinId,
	Float:actor_Position[3],
	Float:actor_Angle,
	Float:actor_Health,
	bool:actor_IsInvulnerable,
	actor_Label[MAX_PLAYER_NAME],
	Float:actor_LabelPosition[3],
	actor_ColorId,
	actor_VW
}
#endif

enum E_CLASS
{
	E_CLASS_NAME[MAX_STRING_CLASSNAME],
	E_CLASS_RANK
};

enum
{
	RANK_PLAYER_PRIVATE,
	RANK_PLAYER_CORPORAL,
	RANK_PLAYER_SERGEANT,
	RANK_PLAYER_SERGEANTMAJOR,
	RANK_PLAYER_LIEUTENANT,
	RANK_PLAYER_LIEUTENANTMAJOR,
	RANK_PLAYER_CAPTAIN,
	RANK_PLAYER_MAJOR,
	RANK_PLAYER_COLONEL,
	RANK_PLAYER_BRIGADIER,
	RANK_PLAYER_GENERAL,
	RANK_PLAYER_FIELDMARSHALL,
	RANK_PLAYER_MASTEROFWAR,
	RANK_PLAYER_GODOFWAR
};

enum
{
	ZONE_OILSUPPLEMENTBASE,
	ZONE_SNAKESFARM,
	ZONE_WAREHOUSE,
	ZONE_MANSION,
	ZONE_BAYSIDE,
	ZONE_AREA51,
	ZONE_ARMYRESTAURANT,
	ZONE_ARMYPETROLBUNK,
	ZONE_OILFACTORY,
	ZONE_GASFACTORY,
	ZONE_QUARRY,
	ZONE_ARMYGUESTHOUSE,
	ZONE_BIGEAR,
	ZONE_DESERTAIRPORT,
	ZONE_WEAPONSHOP,
	ZONE_SHERMANDAM,
	ZONE_CLUCKINBELL,
	ZONE_RUSTYBRIDGE,
	ZONE_GHOSTTOWN,
	ZONE_HOSPITAL,
	ZONE_ITALIANVILLA,
	ZONE_BIOLOGICALSHIP,
	ZONE_CERBERUSISLAND,
	ZONE_DESPUEBLO,
	ZONE_SECRETMILITARYCAMP,
	ZONE_ABANDONEDGASSTATION,
	ZONE_BASKETBALLSTADIUM,
	ZONE_OILPUMP
};

// Thread
enum 
{
	THREAD_CHECK_BAN, // 0
	THREAD_CHECK_ACCOUNT,
	THREAD_INSERT_ACCOUNT,
	THREAD_LOGIN,
	THREAD_GET_LASTLOGGED,
	THREAD_ADD_OFFLINEBAN,
	THREAD_DELETE_BAN,
	THREAD_UPDATE_ACCOUNTNAME,
	THREAD_GET_ACCOUNTS
};

// Dialog
enum
{
	DIALOG_GLOBAL, // 0
	DIALOG_REGISTER_ISSUE,
	DIALOG_REGISTER,
	DIALOG_LOGIN,
	DIALOG_LOGIN_ISSUE,
	DIALOG_WEAPON_BUY,
	DONOR_DIALOG,
	DIALOG_SHOP,
	DIALOG_NUKE,
	DIALOG_COMMANDS_ADMINISTRATOR,
	DIALOG_COMMANDS,
	DIALOG_SETTINGS,
	DIALOG_INTERIORSLIST,
	DIALOG_ACCOUNT_EMAIL,
	DIALOG_ACCOUNT_EMAIL_ISSUE,
	DIALOG_CLASSSELECTION
};

// Bone
enum 
{
	BONE_NONE, // 0
	BONE_SPINE,
	BONE_HEAD,
	BONE_LEFTUPPERARM,
	BONE_RIGHTUPPERARM,
	BONE_LEFTHAND,
	BONE_RIGHTHAND,
	BONE_LEFTTHIGH,
	BONE_RIGHTTHIGH,
	BONE_LEFTFOOT,
	BONE_RIGHTFOOT, // 10
	BONE_RIGHTCALF,
	BONE_LEFTCALF,
	BONE_LEFTFOREARM,
	BONE_RIGHTFOREARM,
	BONE_LEFT_CLAVICLE,
	BONE_RIGHTCLAVICLE,
	BONE_NECK,
	BONE_JAW
};

// Class
enum
{
	CLASS_SOLDIER = 0,
	CLASS_SNIPER,
	CLASS_ENGINEER,
	CLASS_JETTROOPER,
	CLASS_SUPPORT,
	CLASS_SPY,
	CLASS_PILOT,
	CLASS_DEMOLISHER,
	CLASS_TERMINATOR,
	CLASS_DONATOR
};