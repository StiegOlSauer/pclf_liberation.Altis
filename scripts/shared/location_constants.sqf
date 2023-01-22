private ["_location_exclusions", "_location_patches", "_altis_exclusions", "_altis_patches", "_altis_markers"];

LP_location_tiny = 0;
LP_location_village = 1;
LP_location_city = 2;
LP_location_capital = 3;
LP_location_outpost = 4;
LP_location_base_small = 5;
LP_location_base = 6;
LP_location_airfield = 7;
LP_location_radio = 8;
LP_location_factory = 9;

LP_locations_allTypes = [
    LP_location_tiny, LP_location_village, LP_location_city, LP_location_capital, LP_location_outpost,
    LP_location_base_small, LP_location_base, LP_location_airfield, LP_location_radio, LP_location_factory
];
LP_locations_military = [LP_location_outpost, LP_location_base_small, LP_location_base, LP_location_airfield];
LP_locations_civilian = [LP_location_tiny, LP_location_village, LP_location_city, LP_location_capital];
LP_location_words_military = ["military", "airbase", "Airbase", "Base", "Outpost"];
LP_location_words_factory = ["factory", "storage", "power plant", "quarry", "mine", "Powerplant", "Factory", "Dock"];

LP_location_type_icons = createHashMapFromArray [
    [LP_location_tiny, "n_unknown"],
    [LP_location_village, "n_art"],
    [LP_location_city, "n_recon"],
    [LP_location_capital, "n_med"],
    [LP_location_outpost, "loc_Ruin"], // FIXME
    [LP_location_base_small, "loc_Ruin"],
    [LP_location_base, "loc_Ruin"],
    [LP_location_airfield, "loc_Ruin"], // FIXME
    [LP_location_radio, "loc_Transmitter"],
    [LP_location_factory, "loc_Fuelstation"]
];

LP_location_props_varname = "LP_properties";
LP_location_spawned_groups_var = "LP_location_groups";
LP_location_spawned_vehs_var = "LP_location_vehs";
LP_location_spawned_civs_var = "LP_location_civs";
LP_active_markers = [];
LP_active_locations = [];

_location_exclusions = createHashMap;

_altis_exclusions = [
        // NameLocal
        "Location NameLocal at 2314, 9289",
        "Edoris",
        "Monisi",
        "Agios Kosmas",
        "Eginio",
        "Cape Makrinos",
        "Pyrgi",
        "Makrynisi",
        "Sagonisi",
        "Savri",
        "Cape Drakontas",
        "Agios Panagiotis",
        "Kavala Pier",
        "Location NameLocal at 4379, 12594", //quarry
        "Gori",
        "Cape Agrios",
        "Bomos",
        "Nychi",
        "Ochrolimni",
        "Sideras",
        "Polemistia",
        "Limnichori",
        "Limni",
        "Location NameLocal at 19566, 15617", // quarry
        "Cape Kategidis",
        "Livadi",
        "Trachia",
        "Atsalis",
        // Hill
        "Location Hill at 9186, 8388",
        "Location Hill at 10730, 7616",
        "Thronos" // castle
];
_location_exclusions set ["Altis", _altis_exclusions];

_altis_patches = createHashMapFromArray [
    [
        "Iraklia", createHashMapFromArray [
            ["type", LP_location_village],
            ["name", "Iraklia resorts"],
            ["size", 1200],
            ["garrison", 24],
            ["garrison_max", 36]
        ]
    ],
    [
        "Kastro", createHashMapFromArray [
            ["type", LP_location_radio],
            ["name", "Kastro Array"],
            ["garrison", 8],
            ["garrison_max", 12]
        ]
    ],
    [
        "Cape Zefyris", createHashMapFromArray [
            ["type", LP_location_base_small],
            ["name", "Zefyris Old Base"],
            ["garrison", 12],
            ["garrison_max", 24],
            ["composition", "base_small1"]
        ]
    ],
    [
        "Agios Petros", createHashMapFromArray [
            ["type", LP_location_tiny],
            ["garrison", 12],
            ["garrison_max", 18]
        ]
    ],
    [
        "Agios Georgios", createHashMapFromArray [
            ["type", LP_location_outpost],
            ["garrison", 10],
            ["garrison_max", 18],
            ["composition", "outpost_hill"]
        ]
    ],
    [
        "Location NameLocal at 23496, 18393", createHashMapFromArray [ // Almyra lake airfield
            ["name", "Almyra airfield"],
            ["type", LP_location_airfield],
            ["garrison", 16],
            ["garrison_max", 30],
            ["composition", "airfield_unpaved_small"]
        ]
    ],
    [
        "Molos Airfield", createHashMapFromArray [
            ["type", LP_location_airfield],
            ["garrison", 20],
            ["garrison_max", 30],
            ["composition", "airfield_unpaved"]
        ]
    ],
    [
        "Cape Strigla", createHashMapFromArray [
            ["type", LP_location_base_small],
            ["garrison", 24],
            ["garrison_max", 60],
            ["composition", "base_tent1"]
        ]
    ],
    [
        "Cape Thelos", createHashMapFromArray [
            ["type", LP_location_base_small],
            ["garrison", 24],
            ["garrison_max", 48],
            ["composition", "base_big1"]
        ]
    ],
    [
        "Location NameLocal at 18261, 15551", createHashMapFromArray [ // Charkia factory
            ["type", LP_location_factory],
            ["garrison", 32],
            ["garrison_max", 80]
        ]
    ],
    [
        "Location NameLocal at 18435, 14302", createHashMapFromArray [ // Charkia mine
            ["type", LP_location_factory],
            ["garrison", 16],
            ["garrison_max", 28]
        ]
    ],
    [
        "Chelonisi", createHashMapFromArray [
            ["type", LP_location_radio],
            ["name", "Chelonisi comm center"],
            ["garrison", 10],
            ["garrison_max", 16]
        ]
    ],
    [
        "Location NameLocal at 17061, 11339", createHashMapFromArray [ // Pyrgos quarry
            ["type", LP_location_factory],
            ["garrison", 12],
            ["garrison_max", 24],
            ["composition", "base_small1"]
        ]
    ],
    [
        "Mazi", createHashMapFromArray [
            ["type", LP_location_tiny],
            ["garrison", 12],
            ["garrison_max", 20],
            ["composition", "camp_small1"]
        ]
    ],
    [
        "Location NameLocal at 4164, 15047", createHashMapFromArray [ // Kavala Powerplant
            ["type", LP_location_factory],
            ["garrison", 32],
            ["garrison_max", 64]
        ]
    ],
    [
        "Location NameLocal at 11461, 11662", createHashMapFromArray [ // Therisa Airfield
            ["type", LP_location_airfield],
            ["name", "Therisa airfield"],
            ["garrison", 20],
            ["garrison_max", 32],
            ["composition", "airfield_unpaved"]
        ]
    ]
];

_location_patches = createHashMap;
_location_patches set ["Altis", _altis_patches];

_altis_markers = createHashMapFromArray [
    [
        "NameLocal",
        [
            // Places
            ["Agios Minas", "capture_63"],
            ["Almyra", "capture_67"],
            ["Kategidis", "capture_68"],
            ["Pyrsos", "capture_64"],
            // Bases
            ["Zaros Base", "military8"],
            ["Edessa Base", "military8_1"],
            ["Vikos Base", "military8_2"],
            ["Sagonisi Base", "military19"],
            ["Stavros Base", "military25"],
            ["Galati Base", "military13"],
            ["Frini Base", "military14"],
            ["Zeloran Base", "military20"],
            ["Military Lab Base", "military"],
            ["Pyrgos Base", "military4"],
            ["Selakano Base", "military6"],
            ["Feres Base", "military7"],
            ["Negades Base", "military10"],
            // Airfields
            ["Abdera Airbase", "factory155"],
            ["Selakano Airbase", "factory11111"],
            // Factories
            ["Iremi Dock", "factory5645_1"],
            ["Alikampos Factory", "factory6"],
            ["Airport Dock", "factory_13_1_2_2"],
            ["Valley Factory", "factory7_2"],
            ["Topolia Factory", "factory7_1"],
            ["Gori Factory", "factory10"],
            ["Kalochori Powerplant", "factory55577"],
            ["Gatolia Powerplant", "factory555"],
            ["Panagia Factory", "factory12_1_1"],
            ["Oreokastro Powerplant", "factory54132"],
            ["Zaros Factory", "factory5"]
        ]
    ],
    [
        "NameVillage",
        [
            ["Alikampos Hotel", "capture_7_1"],
            ["Pefkas", "capture_66"],
            ["Thelos", "capture_13_1_2_26_5_1"],
            ["Abdera Compound", "capture_13_1_2_21_1"]
        ]
    ],
    [
        "NameCity",
        [
            ["Drakontas", "capture_1_2"]
        ]
    ],
    [
        "Hill",
        [
            ["Comms Array 032099", "tower"],
            ["Comms Array 112087", "tower_1"],
            ["Comms Array 040144", "tower_1_1"],
            ["Comms Array 076135", "tower_1_1_2"],
            ["Comms Array 050198", "tower_1_1_3"],
            ["Comms Array 054158", "tower_1_1_6"],
            ["Comms Array 121185", "tower_1_1_7_2"],
            ["Comms Array 161181", "tower_1_1_7_1_2"],
            ["Comms Array 160163", "tower_1_1_7_3"],
            ["Comms Array 198179", "tower_1_1_7_1_5_1"],
            ["Comms Array 220195", "tower_1_1_7_1_6"],
            ["Comms Array 194145", "tower_1_1_7_1_5"],
            ["Comms Array 226078", "tower_1_1_7_1_5_2"],
            ["Comms Array 096156", "tower_1_1_8"]
        ]
    ]
];

_location_markers = createHashMap;
_location_markers set ["Altis", _altis_markers];

/* Locations that exist as markers in Liberation Mission map, but do not have auto locations - should not be removed
 * * Hills
 * RadioTower 050198 tower_1_1_3
 * RadioTower 054158 tower_1_1_6
 * RadioTower 040144 tower_1_1
 * RadioTower 032099 tower
 * RadioTower 112087 tower_1
 * RadioTower 076135 tower_1_1_2
 * RadioTower 096156 tower_1_1_8
 * RadioTower 090178 tower_1_1_4
 * RadioTower 121185 tower_1_1_7_2
 * RadioTower 161181 tower_1_1_7_1_2
 * RadioTower 160163 tower_1_1_7_3
 * RadioTower 198179 tower_1_1_7_1_5_1
 * RadioTower 220195 tower_1_1_7_1_6
 * RadioTower 194145 tower_1_1_7_1_5
 * RadioTower 226078 tower_1_1_7_1_5_2
 *
 * * Cities/Villages
 * Drakontas
 * Alikampos hotel
 * Agios Minas
 * Abdera Compound
 * Pefkas
 * Almyra
 * Thelos
 * Kategidis
 * Pyrsos
 *
 *
 * * Bases
 * Zaros Base
 * Edessa Base
 * Vikos Base
 * Sagonisi Base
 * Stavros Base
 * Galati Base
 * Frini Base
 * Zeloran Base
 * Military Lab Bravo
 * Pyrgos Base
 * Selakano Base
 * Feres Base
 * Negades Base
 *
 *
 * * Factories
 * Iremi Dock
 * Alikampos Factory
 * Airport Dock
 * Valley Factory
 * Topolia Factory
 * Gori Factory
 * Abdera airfield
 * Kalochori Powerplant
 * Gatolia Powerplant
 * Selakano Airfield
 * Panagia Factory
 * Oreokastro Powerplant
 * Zaros Factory
 *
 *
*/

[_location_exclusions, _location_patches, _location_markers]
