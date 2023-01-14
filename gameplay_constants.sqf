GRLIB_save_key = "GREUH_LIBERATION_SAVEGAME";	// change this value if you want different savegames on different map

GRLIB_eligible_weapon_camo = ["desert", "woodland", "nocamo"];

GRLIB_side_friendly = WEST;
GRLIB_side_enemy = EAST;
GRLIB_side_resistance = RESISTANCE;
GRLIB_side_civilian = CIVILIAN;
GRLIB_respawn_marker = "respawn_west";
GRLIB_color_friendly = "ColorBLUFOR";
GRLIB_color_enemy = "ColorOPFOR";
GRLIB_color_enemy_bright = "ColorRED";

// LP = "Liberation Project", since Liberation is no longer related with GREUH exclusively
// but "LIB" is very generic prefix that could misguide contributors
LP_island = "Altis";
LP_unitcap_location = 30 * GRLIB_unitcap;
LP_allLocations = [];
LP_opfor_vehicle_roles = ["transport", "tank", "support", "ifv", "apc", "atgm", "artillery", "aa", "static"];
LP_group_assignment_var = "LP_location";

GRLIB_sector_size = 1000;
GRLIB_capture_size = 175;
GRLIB_radiotower_size = 2500;
GRLIB_recycling_percentage = 0.65;
GRLIB_endgame = 0;
GRLIB_vulnerability_timer = 1200;
GRLIB_defended_buildingpos_part = 0.4;
GRLIB_sector_military_value = 3;
GRLIB_secondary_objective_impact = 0.6;
GRLIB_blufor_cap = [100 * GRLIB_unitcap, 100] select (100 * GRLIB_unitcap > 100); // Don't forget that the human commander manages those, not the server
GRLIB_sector_cap = 180 * GRLIB_unitcap;
GRLIB_battlegroup_cap = 150 * GRLIB_unitcap;
GRLIB_patrol_cap = 150 * GRLIB_unitcap;
GRLIB_battlegroup_size = 6 * (sqrt GRLIB_unitcap) * (sqrt GRLIB_csat_aggressivity);
GRLIB_civilians_amount = 10 * GRLIB_civilian_activity;
GRLIB_fob_range = 125;
GRLIB_cleanup_delay = 1200;
GRLIB_surrender_chance = 75;
GRLIB_secondary_missions_costs = [ 10, 10, 10, 10, 10 ];
GRLIB_halo_altitude = 3000;
GRLIB_civ_killing_penalty = 20;

unitcap_respawns_limit = 25;
unitcap = unitcap_respawns_limit;

GRLIB_offload_diag = false;

GRLIB_terror_civilians = [];
GRLIB_terror_enabled = false;
GRLIB_tasksPenalty = 0;

GRLIB_curatorMenu = "";
GRLIB_curatorUnitSpawned = "";

GRLIB_markerToTask = [
["task_c_capture_13_1_2_26_12",		[0, "task_c_capture_13_1_2_26_12"]],						//Nidasos
["task_c_capture_13_1_2_26_27_1",	[8, "task_c_capture_13_1_2_26_27_1", "task_c_capture_13_1_2_26_27_1_r1", "task_c_capture_13_1_2_26_27_1_r2", "task_c_capture_13_1_2_26_27_1_r3", "task_c_capture_13_1_2_26_27_1_r4", "task_c_capture_13_1_2_26_27_1_r5"]],	//Sofia
["task_c_capture_13_1_2_26_27",		[0, "task_c_capture_13_1_2_26_27"]],						//Gatolia
["task_c_capture_13_1_2_26_15",		[5, "task_c_capture_13_1_2_26_15"]],						//Delfinaki
["task_c_capture_13_1_2_26_14",		[0, "task_c_capture_13_1_2_26_14"]],						//Ioannina
["task_c_capture_66",				[3, "task_c_capture_66"]],									//Pefkas
["task_c_capture_13_1_2_26_19",		[0, "task_c_capture_13_1_2_26_19"]],						//Iraklia
["task_c_capture_13_1_2_26_5_1",	[4, "task_c_capture_13_1_2_26_5_1"]],						//Thelos
["task_c_capture_13_1_2_26_5",		[6, "task_c_capture_13_1_2_26_5", "task_c_capture_13_1_2_26_5_r1", "task_c_capture_13_1_2_26_5_r2", "task_c_capture_13_1_2_26_5_r3"]],	//Kalochori
["task_c_capture_67",				[1,"task_c_capture_67", "task_c_capture_67_r1"]],			//Almyra
["task_c_capture_13_1_2_19",		[3, "task_c_capture_13_1_2_19"]],							//Nifi
["task_c_capture_13_1_2_18",		[2, "task_c_capture_13_1_2_18"]],							//Rodopoli
["task_c_capture_68",				[0, "task_c_capture_68"]],									//Kategidis
["task_c_capture_13_1_2_20",		[5, "task_c_capture_13_1_2_20"]],							//Dorida
["task_c_capture_13_1_2_26_5_1_2",	[1, "task_c_capture_13_1_2_26_5_1_2", "task_c_capture_13_1_2_26_5_1_2_r1"]],			//Chalkeia
["task_c_capture_13_1_2_26_7",		[0, "task_c_capture_13_1_2_26_7"]],							//Aktinarki
["task_c_capture_13_1_2_26_10",		[3, "task_c_capture_13_1_2_26_10"]],						//Feres
["task_c_capture_13_1_2_26_8",		[2, "task_c_capture_13_1_2_26_8"]],							//Panagia
["task_c_capture_13_1_2_13_1",		[4, "task_c_capture_13_1_2_13_1"]],							//Faronaki
["task_c_capture_13_1_2_26_11",		[0, "task_c_capture_13_1_2_26_11"]],						//Selakarno
["task_c_capture_13_1_2_4",			[7, "task_c_capture_13_1_2_4", "task_c_capture_13_1_2_4_r1", "task_c_capture_13_1_2_4_r2",
									"task_c_capture_13_1_2_4_r3", "task_c_capture_13_1_2_4_r4"]],//Charkia
["task_c_capture_13_1_2_17",		[9, "task_c_capture_13_1_2_17", "task_c_capture_13_1_2_17_r1", "task_c_capture_13_1_2_17_r2"]] //Kalithea
];

//

GRLIB_taskDescriptions = [
["kill bandits", "Local town authority asked us to purge unclean in bandit's camp location nearby.", "Eliminate bandits camp"],
["destroy roadblock", "Town major notified us that OPFOR roadblock nearby causes heavy business losses to his town - road mostly closed for his drivers to pass government convoys. The best time to ambush something.", "Capture and ambush"],
["comm array", "People of nearby town are very unhappy of small military communications post situated near the town. It was illegally powered from city's electrical network causing major issues with network stabiliity inside the town and lots of burned toasters. Locals will be pleased if you solve this problem.", "Destroy communications post"],
["demolitions", "As town elder said, bunch of hobos turned peaceful area near his town into disgusting slums. Locals did their best to kick hobos off, but they always returned back. We were asked to blow off that place to hell. Elder notified us that his people saw a pistol under the jacket of one of hobos. We don't think they are armed, but you never know.", "Peaceful demolitions"],
["deliver wheels", "Today morning your usual routine of checking nearby towns requests was suddenly broken by rude man's voice, calling from a radio tuned on town major's frequency. 'Owner of this voice must be made of iron' - you thought - 'This request definitely needs some attention'.\n 'Hello, son. This is Tom... *cough* Corporal MacGrant speaking. Aside that your goddamn war is freaking out my citizens, it is messing with our business. You may think, rednecks like us don't have any obligations, but hell you are wrong. One of my trucks is out of duty because some goddamn cowboy shot two tyres and I don't have a spare. Thankfully, driver was not injured, he's a good fella.'\n Then iron man turned into Watto - junk dealer from Tatooine - and continued: 'So, could you be so kind and deliver 4 brand new truck wheels to my fellow town. You are not with army, I know you have new things all around. That small ddonation will help to arrange deal between us. MacGrant over.'", "Wheels of Freedom"],
["roadblock small", "We were tasked to eliminate roadblock near the town. Destroy all defenders and prevent OPFOR from restoring checkpoint functionality by destroying all fortifications.", "Destroy roadblock"],
["food order", "Local government in attempt to weak and frighten local cities cut food supplies from capitals. This is one of examples: the city is slowly dying without food and they need something bigger than our military rations. A government food storage nearby could solve their problems. The single obstackle that it is very well defended. Grab at least 5 food supplies and deliver to city center.", "Feed the city"],
["escape", "Help town elder's sons escape from Altis", "Running men"],
["revenge", "The Sun, that brigtly glared minutes ago making your wait very uncomfortable, now was hidden by thick layer of rainclouds. That was a sign of a gathering storm and something even worse. A stranger left his car - white pickup that definitely seen better days - and headed straightly towards you. You knew that he was a town elder and he was here to negotiate the cost of his town's rebellion. After short cold greeting he started: 'What kind of a man can kill a little boy and a woman with his bare hands and then continue with military inspection through Altis? I will show you one. He should never kill anyone else, he should never make other people suffer. He will be inspecting garrisson near the city soon. That is the cost.' Man turned around and walked to his jeep. So you were wrong - he came not for negotiations, and this was barely a job offer. You saw a wall of rain kilometer ahead of the stranger and you new that it will wash out all tracks of this meening. But it will not wash out his pain.", "Revenge!"],
["fuelwars", "Find oil refinery, blow it up, bring some fuel to the city.", "Interstate'76"]
];
