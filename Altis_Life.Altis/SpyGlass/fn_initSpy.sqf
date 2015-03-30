#define GVAR_UINS uiNamespace getVariable
#define CONST(var1,var2) var1 = compileFinal (if(typeName var2 == "STRING") then {var2} else {str(var2)})
#define steamid getPlayerUID player
#define SPY "spy_log"
/*
	File: fn_initSpy.sqf
	
	Description:
	Does some things that I made over-complicated / un-needed but blah.
	Will eventually include server-side checks but it's blah at this point.
	
	Will also become a standalone system which is why it's setup like this.
*/
private["_binConfigPatches","_cfgPatches","_endM"];
if(isServer && !hasInterface) exitWith {}; //Server doesn't need to know.

CONST(W_O_O_K_I_E_ANTI_ANTI_HAX,"false");
CONST(W_O_O_K_I_E_FUD_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_ANTI_ANTI_HAX,"false");
CONST(E_X_T_A_S_Y_Pro_RE,"false");
CONST(E_X_T_A_S_Y_Car_RE,"false");
CONST(DO_NUKE,"false");
CONST(JxMxE_spunkveh,"false");
CONST(JxMxE_spunkveh2,"false");
CONST(JxMxE_spunkair,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE,"false");
CONST(JJJJ_MMMM___EEEEEEE_LLYYSSTTIICCC_SHIT_RE_OLD,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_VEH,"false");
CONST(JJJJ_MMMM___EEEEEEE_SPAWN_WEAPON,"false");

/*
	Compile our list of allowed addon patches, by default this DOES NOT ALLOW ANY ADDONS.
	
	If you want to white-list addons such as JSRS or Blastcore you need to start a test instance (Host locally and not the mission) and first fill the SPY_cfg_patchList array, once you executed it (Filled it)
	Run the following code and it will copy the list of addons / patches not in the list to your clipboard (Ctrl + V) and then add it to the array.
	
	_cfgPatches = [];
	_binConfigPatches = configFile >> "CfgPatches";
	for "_i" from 0 to count (_binConfigPatches)-1 do {
		_patchEntry = _binConfigPatches select _i;
		if(isClass _patchEntry) then {
			if(!((configName _patchEntry) in SPY_cfg_patchList)) then {
				_cfgPatches set[count _cfgPatches,(configName _patchEntry)];
			};
		};
	};

	copyToClipboard str(_cfgPatches);
	
	i.e
	["cba_xeh","Extended_EventHandlers","CBA_Extended_EventHandlers","JSRS_Environment","WarFXPE","cba_common","cba_events","cba_hashes","cba_network","cba_strings","cba_ui","cba_vectors","JSRS2_120mm_Cannon","JSRS2_127","JSRS2_155mm_AMOS",
	"JSRS2_230mm_Titan","JSRS2_30mm_Cannon","JSRS2_35mm_Autocannon","JSRS2_4Five45","JSRS2_ACPC","JSRS2_Autocannon","JSRS2_Bullethits","JSRS2_DAGR","JSRS2_DAR","JSRS2_EBR","JSRS2_Explosions","JSRS2_Explosives","JSRS2_Filters","JSRS2_FS2000",
	"JSRS2_Gatling","JSRS2_GMG20","JSRS2_GMG40","JSRS2_Khaybar","JSRS2_LMGRCWS","JSRS2_M134","JSRS2_M200","JSRS2_M320R","JSRS2_M6","JSRS2_Minigun","JSRS2_MX","JSRS2_NLAW","JSRS2_P07","JSRS2_PDW","JSRS2_Rahim","JSRS2_Rook40","JSRS2_RPG32",
	"JSRS2_Scorpian","JSRS2_SDAR","JSRS2_Skalpel_ATGM","JSRS2_Skyfire","JSRS2_Sonic_Cracks","JSRS2_Titan","JSRS2_TRG20","JSRS2_Vector","JSRS2_Veh_Titan","JSRS2_Zafir","JSRS2_Zubr45","Blastcore_VEP","cba_ai","cba_arrays","cba_diagnostic","cba_help",
	"cba_ui_helper","cba_versioning","JSRS2_Movement","JSRS2_Silencers","cba_main","cba_main_a3","JSRS2_2S9_Sorcher","JSRS2_AFV4_Gorgon","JSRS2_AH99_Blackfoot","JSRS2_AH9_Pawnee","JSRS2_AMV7_Marshal","JSRS2_BTRK_Kamysh","JSRS2_CH49_Mohawk","JSRS2_Distance",
	"JSRS2_FighterPlane3","JSRS2_FV720_Mora","JSRS2_Hunter","JSRS2_Ifrit","JSRS2_IFV6a_Cheetah","JSRS2_IFV6c_Panther","JSRS2_M2A1_Slammer","JSRS2_M4_Scorcher","JSRS2_M5_Sandstorm","JSRS2_MBT52_Kuma","JSRS2_Mi48_Kajman","JSRS2_MSE3_Marid","JSRS2_Offroad",
	"JSRS2_Po30_Orca","JSRS2_Strider","JSRS2_SUV","JSRS2_T100_Varsuk","JSRS2_Truck1","JSRS2_Truck2","JSRS2_UAV_1","JSRS2_UH80_GhostHawk","JSRS2_Van","JSRS2_WY55_Hellcat","JSRS2_ZSU39_Tigris","cba_xeh_a3"]
*/
	
_patchList = ["NiiRoZz_Escobar_Shop","aurore_data2","A3Data","A3_BaseConfig_F","A3_Dubbing_Radio_F","A3_Functions_F","A3_Functions_F_EPA","A3_Functions_F_EPC","Map_VR","A3_Map_VR_Scenes","A3L_Billboards","A3L_HospitalBed","A3L_PaintBallHelmet","A3L_PaintBallObjects","aurore_data","aurore_soft1","cl3_Orca","CL3_Animals_Shark1","CALanguageCL3","CL3_MB","CL3MOD_nvgbrightness","CL3_Data_F_AdminBot","CL3_Underwear","cl3_custom_bombs","cl_FlashLight","cl3_fingerprintscanner","CL3_ChemLightsSilent","CL3_SmokeShellSilent","CL3_TazerM26","CL3_Utilities","dar_ilpdn","GNT_C185","Bravo93_Balaclava","IVORY_CRJ200","Niko_USA","Niko_USA_cfg","santahat","cba_xeh","Extended_EventHandlers","CBA_Extended_EventHandlers","A3_Data_F","A3_Data_F_Hook","A3_Data_F_ParticleEffects","A3_Data_F_Bootcamp","A3_Data_F_Kart_ParticleEffects","A3_Editor_F","A3_Functions_F_Bootcamp","A3_Functions_F_Curator","A3_Functions_F_Heli","A3_Language_F","A3_Language_F_Beta","A3_Language_F_Curator","A3_Language_F_EPA","A3_Language_F_EPB","A3_Language_F_EPC","A3_Language_F_Gamma","A3_Language_F_Heli","A3_Language_F_Kart","A3_LanguageMissions_F","A3_LanguageMissions_F_Beta","A3_LanguageMissions_F_Gamma","A3_LanguageMissions_F_Kart","A3_Misc_F","A3_Misc_F_Helpers","A3_Modules_F","A3_Modules_F_DynO","A3_Modules_F_Effects","A3_Modules_F_Events","A3_Modules_F_GroupModifiers","A3_Modules_F_HC","A3_Modules_F_Intel","A3_Modules_F_LiveFeed","A3_Modules_F_Marta","A3_Modules_F_Misc","A3_Modules_F_Multiplayer","A3_Modules_F_ObjectModifiers","A3_Modules_F_Sites","A3_Modules_F_Skirmish","A3_Modules_F_StrategicMap","A3_Modules_F_Supports","A3_Modules_F_UAV","A3_Modules_F_Beta","A3_Modules_F_Beta_FiringDrills","A3_Modules_F_EPB","A3_Modules_F_EPB_Misc","A3_Modules_F_Heli","A3_Modules_F_Heli_SpawnAi","A3_Music_F","A3_Music_F_Bootcamp","A3_Music_F_EPA","A3_Music_F_EPB","A3_Music_F_EPC","A3_Music_F_Heli","A3_Roads_F","A3_Rocks_F","A3_Sounds_F","A3_Sounds_F_Bootcamp","A3_Sounds_F_EPB","A3_Sounds_F_EPC","A3_Structures_F","A3_Structures_F_Bridges","A3_Structures_F_Civ","A3_Structures_F_Civ_Accessories","A3_Structures_F_Civ_Ancient","A3_Structures_F_Civ_BellTowers","A3_Structures_F_Civ_Calvaries","A3_Structures_F_Civ_Camping","A3_Structures_F_Civ_Chapels","A3_Structures_F_Civ_Constructions","A3_Structures_F_Civ_Dead","A3_Structures_F_Civ_Garbage","A3_Structures_F_Civ_Graffiti","A3_Structures_F_Civ_InfoBoards","A3_Structures_F_Civ_Kiosks","A3_Structures_F_Civ_Lamps","A3_Structures_F_Civ_Market","A3_Structures_F_Civ_Offices","A3_Structures_F_Civ_Pavements","A3_Structures_F_Civ_PlayGround","A3_Structures_F_Civ_SportsGrounds","A3_Structures_F_Civ_Statues","A3_Structures_F_Civ_Tourism","A3_Structures_F_Dominants","A3_Structures_F_Dominants_Amphitheater","A3_Structures_F_Dominants_Castle","A3_Structures_F_Dominants_Church","A3_Structures_F_Dominants_Hospital","A3_Structures_F_Dominants_Lighthouse","A3_Structures_F_Dominants_WIP","A3_Structures_F_Furniture","A3_Structures_F_Households","A3_Structures_F_Households_Addons","A3_Structures_F_Households_House_Big01","A3_Structures_F_Households_House_Big02","A3_Structures_F_Households_House_Shop01","A3_Structures_F_Households_House_Shop02","A3_Structures_F_Households_House_Small01","A3_Structures_F_Households_House_Small02","A3_Structures_F_Households_House_Small03","A3_Structures_F_Households_Slum","A3_Structures_F_Households_Stone_Big","A3_Structures_F_Households_Stone_Shed","A3_Structures_F_Households_Stone_Small","A3_Structures_F_Households_WIP","A3_Structures_F_Ind","A3_Structures_F_Ind_AirPort","A3_Structures_F_Ind_Cargo","A3_Structures_F_Ind_CarService","A3_Structures_F_Ind_ConcreteMixingPlant","A3_Structures_F_Ind_Crane","A3_Structures_F_Ind_DieselPowerPlant","A3_Structures_F_Ind_Factory","A3_Structures_F_Ind_FuelStation","A3_Structures_F_Ind_FuelStation_Small","A3_Structures_F_Ind_Pipes","A3_Structures_F_Ind_PowerLines","A3_Structures_F_Ind_ReservoirTank","A3_Structures_F_Ind_Shed","A3_Structures_F_Ind_SolarPowerPlant","A3_Structures_F_Ind_Tank","A3_Structures_F_Ind_Transmitter_Tower","A3_Structures_F_Ind_WavePowerPlant","A3_Structures_F_Ind_Windmill","A3_Structures_F_Ind_WindPowerPlant","A3_Structures_F_Items","A3_Structures_F_Items_Documents","A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage","A3_Structures_F_Items_Medical","A3_Structures_F_Items_Military","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools","A3_Structures_F_Items_Valuables","A3_Structures_F_Items_Vessels","A3_Structures_F_Mil","A3_Structures_F_Mil_BagBunker","A3_Structures_F_Mil_BagFence","A3_Structures_F_Mil_Barracks","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Flags","A3_Structures_F_Mil_Fortification","A3_Structures_F_Mil_Helipads","A3_Structures_F_Mil_Offices","A3_Structures_F_Mil_Radar","A3_Structures_F_Mil_Shelters","A3_Structures_F_Mil_TentHangar","A3_Structures_F_Naval","A3_Structures_F_Naval_Buoys","A3_Structures_F_Naval_Fishing","A3_Structures_F_Naval_Piers","A3_Structures_F_Naval_RowBoats","A3_Structures_F_Research","A3_Structures_F_System","A3_Structures_F_Training","A3_Structures_F_Training_InvisibleTarget","A3_Structures_F_Walls","A3_Structures_F_Bootcamp_Ind_Cargo","A3_Structures_F_Bootcamp_Items_Sport","A3_Structures_F_Bootcamp_System","A3_Structures_F_Bootcamp_Training","A3_Structures_F_Bootcamp_VR_Blocks","A3_Structures_F_Bootcamp_VR_CoverObjects","A3_Structures_F_Bootcamp_VR_Helpers","A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPA_Civ_Constructions","A3_Structures_F_EPA_Items_Electronics","A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels","A3_Structures_F_EPA_Walls","A3_Structures_F_EPB_Civ_Accessories","A3_Structures_F_EPB_Civ_Camping","A3_Structures_F_EPB_Civ_Dead","A3_Structures_F_EPB_Civ_Garbage","A3_Structures_F_EPB_Civ_Graffiti","A3_Structures_F_EPB_Civ_PlayGround","A3_Structures_F_EPB_Furniture","A3_Structures_F_EPB_Items_Documents","A3_Structures_F_EPB_Items_Luggage","A3_Structures_F_EPB_Items_Military","A3_Structures_F_EPB_Items_Vessels","A3_Structures_F_EPB_Naval_Fishing","A3_Structures_F_EPC_Civ_Accessories","A3_Structures_F_EPC_Civ_Camping","A3_Structures_F_EPC_Civ_Garbage","A3_Structures_F_EPC_Civ_InfoBoards","A3_Structures_F_EPC_Civ_Kiosks","A3_Structures_F_EPC_Civ_PlayGround","A3_Structures_F_EPC_Civ_Tourism","A3_Structures_F_EPC_Dominants_GhostHotel","A3_Structures_F_EPC_Dominants_Stadium","A3_Structures_F_EPC_Furniture","A3_Structures_F_EPC_Items_Documents","A3_Structures_F_EPC_Items_Electronics","A3_Structures_F_EPC_Walls","A3_Structures_F_Heli_Civ_Accessories","A3_Structures_F_Heli_Civ_Constructions","A3_Structures_F_Heli_Civ_Garbage","A3_Structures_F_Heli_Civ_Market","A3_Structures_F_Heli_Furniture","A3_Structures_F_Heli_Ind_AirPort","A3_Structures_F_Heli_Ind_Cargo","A3_Structures_F_Heli_Ind_Machines","A3_Structures_F_Heli_Items_Airport","A3_Structures_F_Heli_Items_Luggage","A3_Structures_F_Heli_Items_Sport","A3_Structures_F_Heli_Items_Tools","A3_Structures_F_Heli_VR_Helpers","A3_Structures_F_Kart_Civ_SportsGrounds","A3_Structures_F_Kart_Mil_Flags","A3_UIFonts_F","cl3_mod_client","cl3_ship","clbm","cl3_liferaft_F","cl3_phoenixyacht_F","cl3_workboat_F","cl_speedboat","CL3_Basic_Fishing_F","cl3_sounds","cl3_sounds_env","cl3_vehiclefunctions","cl3_weapons","cl_flashbang","CL3_Data_F_Curator_Lightning","CL3_Paintballcal68w","cl3_wheeled","cl3mod_A3VehicleSkin","cl3mod_A3VehicleSkinRubberboat","cl3mod_A3VehicleSkinHatchback","cl3mod_A3VehicleSkinOffroad","cl3mod_A3VehicleSkinQuad","CAWheeled3_cl_skate","CL3_cargoposes","cl3_wheeled_classic","cl3_wheeled_custom","cl3_wheeled_luxury","cl3_wheeled_racing","cl3_wheeled_sport","cl3_wheeled_truck","cba_common","cba_events","cba_hashes","cba_network","cba_strings","cba_vectors","A3_Animals_F","A3_Animals_F_AnimConfig","A3_Animals_F_Fishes","A3_Animals_F_Kestrel","A3_Animals_F_Rabbit","A3_Animals_F_Seagull","A3_Animals_F_Snakes","A3_Animals_F_Turtle","A3_Animals_F_Chicken","A3_Animals_F_Dog","A3_Animals_F_Goat","A3_Animals_F_Sheep","A3_Anims_F","A3_Anims_F_Config_Sdr","A3_Anims_F_EPA","A3_Anims_F_EPC","A3_Anims_F_Kart","A3_Language_F_Bootcamp","A3_Map_Data","A3_Map_Stratis","A3_Map_Stratis_Scenes","A3_Plants_F_Bush","A3_Signs_F","A3_Signs_F_AD","A3_Structures_F_Signs_Companies","A3_Structures_F_Bootcamp_Civ_Camping","A3_Structures_F_Bootcamp_Civ_SportsGrounds","A3_Structures_F_Bootcamp_Items_Electronics","A3_Structures_F_Bootcamp_Items_Food","A3_Structures_F_Heli_Items_Electronics","A3_Structures_F_Heli_Items_Food","A3_Structures_F_Kart_Signs_Companies","A3_UI_F","A3_UI_F_Curator","A3_UI_F_Kart","A3_Weapons_F","A3_Weapons_F_NATO","A3_Weapons_F_CSAT","A3_Weapons_F_AAF","A3_weapons_F_FIA","A3_Weapons_F_ItemHolders","A3_Weapons_F_Headgear","A3_Weapons_F_Uniforms","A3_Weapons_F_Vests","A3_Weapons_F_Ammoboxes","A3_Weapons_F_DummyWeapons","A3_Weapons_F_Explosives","A3_Weapons_F_Items","A3_Weapons_F_Launchers_NLAW","A3_Weapons_F_Launchers_LAW","A3_Weapons_F_Launchers_Titan","A3_Weapons_F_EPA_LongRangeRifles_DMR_01","A3_Weapons_F_EBR","A3_Weapons_F_LongRangeRifles_GM6","A3_Weapons_F_LongRangeRifles_M320","A3_Weapons_F_Machineguns_M200","A3_Weapons_F_Machineguns_Zafir","A3_Weapons_F_Pistols_ACPC2","A3_Weapons_F_Pistols_P07","A3_Weapons_F_Pistols_Pistol_heavy_01","A3_Weapons_F_Pistols_Pistol_heavy_02","A3_Weapons_F_Pistols_Rook40","A3_Weapons_F_Rifles_Khaybar","A3_Weapons_F_Rifles_Mk20","A3_Weapons_F_Rifles_MX","A3_Weapons_F_EPB_Rifles_MX_Black","A3_Weapons_F_Rifles_SDAR","A3_Weapons_F_Rifles_TRG20","A3_Weapons_F_Pistols_PDW2000","A3_Weapons_F_Rifles_Vector","a3_weapons_f_rifles_SMG_02","A3_Weapons_F_beta","A3_Weapons_F_Beta_Ammoboxes","A3_Weapons_F_beta_EBR","A3_Weapons_F_EPA_LongRangeRifles_GM6","A3_Weapons_F_EPB_LongRangeRifles_M320","A3_Weapons_F_beta_Rifles_Khaybar","A3_Weapons_F_beta_Rifles_MX","A3_Weapons_F_beta_Rifles_TRG20","A3_Weapons_F_Bootcamp_LongRangeRifles_GM6","A3_Weapons_F_Bootcamp_LongRangeRifles_M320","A3_Weapons_F_EPB_LongRangeRifles_GM3","A3_Weapons_F_gamma","A3_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_EPA_EBR","A3_Weapons_F_EPA_Rifles_MX","A3_Weapons_F_Kart_Pistols_Pistol_Signal_F","Test_weapon_F","cl3_air","CL3MOD_UAV","CL3_Air_strobe","cl3_animals","cl3_anims","cl3_anims_arrest","cl3_anims_bankanims","cl3_anims_beartrap","CL3_CarryInjured","cl3_anims_consumables","cl3_anims_copactions","cl3_anims_dance","cl3_anims_fishingrod","cl3_anims_gathering","cl3_anims_getmug","cl3_anims_halt","cl3_anims_HandsUp","cl3_anims_lockpick","cl3_anims_lunatic","cl3_anims_misc_laydown","cl3_anims_mugpis","cl3_anims_mugrif","cl3_anims_naturescall","cl3_anims_punch","cl3_anims_repair","cl3_anims_surrender","cl3_anims_ticket","cl3_anims_tools","cl3_anims_wank","cl3_images","cl3_company_images","cl3_mbikes","cl3_bikes","cl3_backpacks","CL3_Dive_Weapons_F","CL3_Weapons_F_Ammoboxes","CL3_Ammoboxes","cl3_crossbow","cl3_cl_camcorder","CL3_paintBall","CL3_droneterminal","CL3_dronebackpackd","DDOPP_taserPack","mas_weapons","mas_weapons_ak","mas_add_FlagCarriers","mas_weapons_m4","mas_weapons_nw","mas_weapons_pack","cba_ai","cba_arrays","cba_diagnostic","cba_help","cba_keybinding","cba_ui","cba_ui_helper","cba_versioning","A3_Anims_F_Heli","A3_Characters_F","A3_Characters_F_BLUFOR","A3_Characters_F_Civil","A3_Characters_F_Heads","A3_Characters_F_OPFOR","A3_Characters_F_Proxies","A3_Characters_F_Beta","A3_Characters_F_INDEP","A3_Characters_F_Bootcamp","A3_Characters_F_EPB_Heads","A3_Characters_F_Gamma","A3_Data_F_Curator","A3_Data_F_Curator_Eagle","A3_Data_F_Curator_Intel","A3_Data_F_Curator_Misc","A3_Data_F_Curator_Respawn","A3_Data_F_Kart","A3_UAV_F_Characters_F_Gamma","A3_UAV_F_Weapons_F_Gamma_Ammoboxes","A3_Weapons_F_gamma_Items","A3_Map_Altis","A3_Map_Altis_Scenes","A3_Missions_F","A3_Missions_F_Beta","A3_Missions_F_Gamma","A3_Missions_F_Kart","A3_Modules_F_Bootcamp","A3_Modules_F_Curator","A3_Modules_F_Curator_Animals","A3_Modules_F_Curator_CAS","A3_Modules_F_Curator_Curator","A3_Modules_F_Curator_Effects","A3_Modules_F_Curator_Environment","A3_Modules_F_Curator_Flares","A3_Modules_F_Curator_Intel","A3_Modules_F_Curator_Lightning","A3_Modules_F_Curator_Mines","A3_Modules_F_Curator_Misc","A3_Modules_F_Curator_Multiplayer","A3_Modules_F_Curator_Objectives","A3_Modules_F_Curator_Ordnance","A3_Modules_F_Curator_Respawn","A3_Modules_F_Curator_Smokeshells","A3_Modules_F_Kart","A3_Modules_F_Kart_TimeTrials","A3_Static_F","A3_Static_F_Mortar_01","A3_Static_F_Beta_Mortar_01","A3_Static_F_Gamma","A3_Static_F_Gamma_Mortar_01","A3_Supplies_F_Heli","A3_Supplies_F_Heli_Bladders","A3_Supplies_F_Heli_CargoNets","A3_Supplies_F_Heli_Fuel","A3_Supplies_F_Heli_Slingload","A3_UI_F_Bootcamp","A3_UI_F_Heli","A3_Weapons_F_Acc","A3_Weapons_F_Beta_Acc","A3_Weapons_F_Bootcamp_Ammoboxes","A3_Weapons_F_EPA","A3_Weapons_F_EPA_Acc","A3_Weapons_F_EPA_Ammoboxes","A3_Weapons_F_EPB","A3_Weapons_F_EPB_Acc","A3_Weapons_F_EPB_Ammoboxes","A3_Weapons_F_EPC","A3_Weapons_F_gamma_Acc","A3_Weapons_F_Kart","Test_Character_F","A3L_Client2","asdg_jointrails","asdg_jointrails_mas_weapons","CL3_Outfits_Vest","CCT_Fardas","CL3_Characters_Outfits","CL3_Characters_F_Beta","CL3_Outfits_headgear","cl3_b_soldier_F_uniform","cl3_c_citizen1_uniform","cl3_c_hunter_f_uniform","cl3_c_poloshirt_uniform","cl3_c_poloshirtpants_uniform","CL3_SmokeShellSilentThrow","Bravo93_IRA_Soldier4","Bravo93_IRA_Soldier1","Bravo93_IRA_Soldier3","Bravo93_IRA_Soldier2","Bravo93_IRA_Soldier5","Bravo93_IRA_Soldier6","Bravo93_IRA_Soldier7","Bravo93_IRA_Soldier8","Orel_Characters","Orel_Data_F","Orel_Objects","Orel_Soft","Orel_Soft_G1","Orel_Structures","Orel_Weapons","prpl_famas_wps","gign_shield","Bravo93_UVF_Soldier2","Bravo93_UVF_Soldier1","Bravo93_UVF_Soldier3","Bravo93_UVF_Soldier4","Bravo93_UVF_Soldier6","Bravo93_UVF_Soldier5","cba_main","cba_main_a3","A3_Air_F","A3_Air_F_Heli_Light_01","A3_Air_F_Heli_Light_02","A3_Air_F_Beta","A3_Air_F_Beta_Heli_Attack_01","A3_Air_F_Beta_Heli_Attack_02","A3_Air_F_Beta_Heli_Transport_01","A3_Air_F_Beta_Heli_Transport_02","A3_Air_F_Beta_Parachute_01","A3_Air_F_Beta_Parachute_02","A3_Air_F_EPB_Heli_Light_03","A3_Air_F_EPC_Plane_CAS_01","A3_Air_F_EPC_Plane_CAS_02","A3_Air_F_Gamma_Plane_Fighter_03","A3_Air_F_Heli","A3_Air_F_Heli_Heli_Attack_01","A3_Air_F_Heli_Heli_Attack_02","A3_Air_F_Heli_Heli_Light_01","A3_Air_F_Heli_Heli_Light_02","A3_Air_F_Heli_Heli_Light_03","A3_Air_F_Heli_Heli_Transport_01","A3_Air_F_Heli_Heli_Transport_02","A3_Air_F_Heli_Heli_Transport_03","A3_Air_F_Heli_Heli_Transport_04","A3_Armor_F","A3_armor_f_beta","A3_Armor_F_Panther","A3_armor_f_beta_APC_Tracked_02","A3_Armor_F_EPB_APC_tracked_03","A3_Armor_F_EPB_MBT_03","A3_Armor_F_Slammer","A3_Armor_F_T100K","A3_Boat_F","A3_Boat_F_Boat_Armed_01","A3_Boat_F_Boat_Transport_01","A3_Boat_F_Beta_Boat_Armed_01","A3_Boat_F_Beta_Boat_Transport_01","A3_Boat_F_SDV_01","A3_Boat_F_EPC_Submarine_01_F","A3_Boat_F_Civilian_Boat","A3_Boat_F_Trawler","A3_Boat_F_Gamma_Boat_Transport_01","A3_Boat_F_Heli_Boat_Armed_01","A3_Boat_F_Heli_SDV_01","A3_Characters_F_Common","A3_Characters_F_Bootcamp_Common","A3_Characters_F_EPA","A3_Characters_F_EPB","A3_Characters_F_EPC","A3_Characters_F_Kart","A3_Data_F_Curator_Characters","A3_Data_F_Curator_Virtual","A3_Data_F_Heli","A3_Air_F_Gamma_UAV_01","A3_Air_F_Gamma_UAV_02","A3_Missions_F_Bootcamp","A3_Missions_F_Curator","A3_Missions_F_EPA","A3_Missions_F_EPB","A3_Missions_F_EPC","A3_Missions_F_Heli","A3_Modules_F_Bootcamp_Misc","A3_Modules_F_Curator_Chemlights","A3_Soft_F","A3_Soft_F_MRAP_01","A3_Soft_F_MRAP_02","A3_Soft_F_Offroad_01","A3_Soft_F_Quadbike","A3_Soft_F_MRAP_03","A3_Soft_F_Beta_Quadbike","A3_Soft_F_HEMTT","A3_Soft_F_TruckHeavy","A3_Soft_F_EPC_Truck_03","A3_Soft_F_Car","A3_Soft_F_Gamma_Offroad","A3_Soft_F_Gamma_Quadbike","A3_Soft_F_SUV","A3_Soft_F_Gamma_HEMTT","A3_Soft_F_Gamma_TruckHeavy","A3_Soft_F_Truck","A3_Soft_F_Heli_Car","A3_Soft_F_Heli_MRAP_01","A3_Soft_F_Heli_MRAP_02","A3_Soft_F_Heli_MRAP_03","A3_Soft_F_Heli_Quadbike","A3_Soft_F_Heli_SUV","A3_Soft_F_Heli_Truck","A3_Soft_F_Kart_Kart_01","A3_Static_F_Gamma_AA","A3_Static_F_Gamma_AT","A3_Structures_F_Mil_Scrapyard","A3_Structures_F_Wrecks","A3_Structures_F_EPA_Mil_Scrapyard","A3_Weapons_F_Bootcamp","A3L_Challenger","A3L_Charger","A3L_CVPI_F","A3L_Dumptruck","A3L_Ambulance_F","A3L_EvoX_F","A3L_F350","A3L_Ferrari458","Test_car_F","A3L_GrandCaravan_F","A3L_Hyster60","A3L_Jeep","A3L_Ladders","A3L_LadderTruck","A3L_Taurus","A3L_Towtruck","A3L_VolksWagenGolfGTi","A3L_VolvoS60R","aurore_pickupv2","aurore_q7","aurore_suv_nanouv2","Aurore_escobar_hummingbird","Aurore_escobar_ifrit","Aurore_wp_suv","WP_Offroad","WP_SUV_01_F","cl3_mh9","cl3_eurocopter135","CL3_Air_F_EPB_Heli_Light_03","cl3_jetpack","cl3_ufo","CL3_EMT_mohawk","cl3_chopper","cl3_enduro","dbo_crosser","cl3_tronbike","cl3_xr_1000","cl3_c_citizen2_uniform","cl3_c_citizen3_uniform","cl3_c_citizen4_uniform","cl3_coveralls_uniform","cl3_wetsuit_uniform","cl3_HudLCD","cl3_lada","cl3_defender_110","cl3_suv","cl3_volha","CL3_Zamak_Transport","cl3_etu_ifrit","CL3_Soft_F_SUV","CL3_Soft_F_fuel_TruckHeavy","CL3_Van_01_F_Truck","cl3_dbs_volante","cl3_q7","cl3_q7_clpd","cl3_r8_spyder","cl3_s5","cl3_e60_m5","cl3_z4_2008","cl3_veyron","CL3_bus_cl","cl3_escalade","cl3_escalade_pd","cl3_arielatom","cl3_arielatom_race","cl3_f150repo","cl3_batmobile","cl3_challenger","cl3_challenger_2009","cl3_dodge_charger_2012","cl3_458","cl3_crown_victoria","clpd_mondeo","cl3_taurus","cl3_transit","cl3_ropedummyhelper","cl3_civic_vti","cl3_aventador_lp7004","cl3_lamborghini_gt1","cl3_murcielago","cl3_reventon","cl3_discovery","cl3_range_rover","cl3_e63_amg","cl3_440cuda","cl3_carrera_gt","cl3_impreza_rally","cl3_impreza_road","cl3_jeep_purge","cl3_dumper_truck","cl3_mackr","cl3_mackr_del","cl3_mackr_flat","cl3_insignia","cl3_golf_mk2","cl3_golf_learner","cl3_polo_gti","cl3_bounder","DAR_Challenger_F","DAR_Charger_F","DAR_CVPI_F","DAR_Explorer_F","DAR_Fusion_F","DAR_Impala_F","DAR_Tahoe_A","DAR_Tahoe_F","DAR_Impala_A","DAR_Taurus_F","demian2435_police_mod","Exxpensive_cops_dodge","exxpensive_audi_R8","exxpensive_BMWM3E46","exxpensive_bugatti_veyron","exxpensive_jaguar","exxpensive_mercedes_sls","exxpensive_ferrari_458","exxpensive_ford_raptor","exxpensive_aventador","exxpensive_mini_cooper","exxpensive_volvo_242","exxpensive_2cv","exxpensive_caddiac_sedan","exxpensive_chevrolet","exxpensive_config","exxpensive_laferrari","exxpensive_GOLF_IV","exxpensive_koenigsegg","exxpensive_m5_e34","exxpensive_chrysler_300c","exxpensive_aston_martin_volante","exxpensive_audi_Q7","exxpensive_porsche_911","exxpensive_porsche_panamera","exxpensive_Camion1","exxpensive_Camion2","ivory_b206","IVORY_PRIUS","IVORY_R8","IVORY_R8SPYDER","IVORY_REV","Jonzie_Ambulance","Jonzie_A3L_Car_Base","Jonzie_Forklift","Jonzie_Mini_Cooper","Jonzie_Viper","Orel_Airs","S_MclarenP1","S_PorscheRS","S_RangeRover","S_Skyline","SAL_77TRANSAM_A","SAL_Audi_A","SAL_IROC_A","CBS_K9N_WaterShadow730","cba_xeh_a3","A3_Air_F_EPC_Plane_Fighter_03","A3_Armor_F_AMV","A3_Armor_F_Marid","A3_Armor_F_EPC_MBT_01","A3_Armor_F_APC_Wheeled_03","A3_CargoPoses_F","A3_CargoPoses_F_Heli","A3_Soft_F_Crusher_UGV","A3_Soft_F_Bootcamp_Offroad_01","A3_Soft_F_Bootcamp_Quadbike","A3_Soft_F_Bootcamp_Truck","A3_Soft_F_Heli_Crusher_UGV","A3L_Punto","A3L_RX7","A3L_FordKa"];
uiNamespace setVariable["RscDisplayRemoteMissions",displayNull]; //For Spy-Glass..
uiNamespace setVariable["RscDisplayMultiplayer",displayNull];

_binConfigPatches = configFile >> "CfgPatches";
for "_i" from 0 to count (_binConfigPatches)-1 do {
	_patchEntry = _binConfigPatches select _i;
	if(isClass _patchEntry) then {
		if(!((configName _patchEntry) in _patchList)) exitWith {
			[[profileName,steamid,(configName _patchEntry)],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
			[[profileName,format["Unknown Addon Patch: %1",(configName _patchEntry)]],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
			[[SPY,[(format["Unknown Addon Patch: %1",(configName _patchEntry)])],profileName,steamid],"TON_fnc_logIt",false,false] call life_fnc_MP;
			sleep 0.5;
			failMission "SpyGlass";
		};
	};
};

//Check for copy-pasters of Dev-Con styled execution.
//Because I am nice, add these to the following below to allow CBA; "CBA_CREDITS_CONT_C","CBA_CREDITS_M_P
private["_children","_allowedChildren"];
_children = [configFile >> "RscDisplayMPInterrupt" >> "controls",0] call BIS_fnc_returnChildren;
_allowedChildren = [
"Title","MissionTitle","PlayersName","ButtonCancel","ButtonSAVE","ButtonSkip","ButtonRespawn","ButtonOptions",
"ButtonVideo","ButtonAudio","ButtonControls","ButtonGame","ButtonTutorialHints","ButtonAbort","DebugConsole",
"Version","TraffLight","Feedback","MessageBox","CBA_CREDITS_CONT_C","CBA_CREDITS_M_P"
];

{
	if(!((configName _x) in _allowedChildren)) exitWith {
		[[profileName,steamid,"Modified_MPInterrupt"],"SPY_fnc_cookieJar",false,false] spawn life_fnc_MP;
		[[profileName,"Devcon like executor detected"],"SPY_fnc_notifyAdmins",true,false] spawn life_fnc_MP;
		[[SPY,["Devcon like executor detected"],profileName,steamid],"TON_fnc_logIt",false,false] call life_fnc_MP;
		sleep 0.5;
		failMission "SpyGlass";
	};
} foreach _children;

/*
	Display Validator
	Loops through and makes sure none of the displays were modified..
	
	TODO: Run check every x minutes and validate all displays.
*/
{
	_onLoad = getText(configFile >> (_x select 0) >> "onLoad");
	_onUnload = getText(configFile >> (_x select 0) >> "onUnload");
	if(_onLoad != (_x select 1) OR _onUnload != (_x select 2)) exitWith {
		[[profileName,steamid,format["Modified_Method_%1",_x select 0]],"SPY_fnc_cookieJar",false,false] call life_fnc_MP;
		[[profileName,format["Modified Display Method %1 (Memory Edit)",_x select 0]],"SPY_fnc_notifyAdmins",true,false] call life_fnc_MP;
		[[SPY,[(format["Modified Display Method %1 (Memory Edit)",_x select 0])],profileName,steamid],"TON_fnc_logIt",false,false] call life_fnc_MP;
		sleep 0.5;
		vehicle player setVelocity[1e10,1e14,1e18]; //It's a surprise.
		sleep 3;
		preProcessFile "SpyGlass\endoftheline.sqf";
		sleep 2.5;
		failMission "SpyGlass";
	};
}
foreach [
	["RscDisplayMainMap","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayGetReady","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInventory","[""onLoad"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInventory"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayLoadMission","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInterrupt","[""onLoad"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInterrupt"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsVideo","[""onLoad"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsVideo"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptions","[""onLoad"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayAVTerminal","[""onLoad"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayAVTerminal"",'IGUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayConfigureAction","[""onLoad"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureAction"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayConfigureControllers","[""onLoad"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayConfigureControllers"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayControlSchemes","[""onLoad"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayControlSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayCustomizeController","[""onLoad"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayCustomizeController"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayDebriefing","[""onLoad"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayDebriefing"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayDiary","[""onLoad"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDiary"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayGameOptions","[""onLoad"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayGameOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayJoystickSchemes","[""onLoad"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayJoystickSchemes"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	//["RscDisplayLoading","[""onLoad"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayMicSensitivityOptions","[""onLoad"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayMicSensitivityOptions"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsAudio","[""onLoad"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsAudio"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayOptionsLayout","[""onLoad"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayOptionsLayout"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	//["RscDisplayStart","[2] call compile preprocessfilelinenumbers gettext (configfile >> 'CfgFunctions' >> 'init'); ['onLoad',_this,'RscDisplayLoading','Loading'] call (uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayLoading"",'Loading'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayVehicleMsgBox","[""onLoad"",_this,""RscDisplayVehicleMsgBox"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayVehicleMsgBox"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"],
	["RscDisplayInsertMarker","[""onLoad"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')","[""onUnload"",_this,""RscDisplayInsertMarker"",'GUI'] call 	(uinamespace getvariable 'BIS_fnc_initDisplay')"]
];

/* Forgot to include this but this is also also a popular method for "unreleased" stuff */
if(getText(configFile >> "CfgFunctions" >> "init") != "A3\functions_f\initFunctions.sqf") then {
	[[profileName,steamid,"Modified_Functions_Init"],"SPY_fnc_cookieJar",false,false] call life_fnc_MP;
	[[profileName,"Modified_Functions_Init"],"SPY_fnc_notifyAdmins",true,false] call life_fnc_MP;
	[[SPY,["Modified_Functions_Init"],profileName,steamid],"TON_fnc_logIt",false,false] call life_fnc_MP;
	sleep 0.5;
	vehicle player setVelocity[1e10,1e14,1e18]; //It's a surprise.
	sleep 3;
	preProcessFile "SpyGlass\endoftheline.sqf";
	sleep 2.5;
	failMission "SpyGlass";
};

[] execVM "SpyGlass\fn_cmdMenuCheck.sqf";
[] execVM "SpyGlass\fn_variableCheck.sqf";
[] execVM "SpyGlass\fn_menuCheck.sqf";
