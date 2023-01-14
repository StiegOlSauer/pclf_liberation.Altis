[] call compile preprocessFileLineNumbers "scripts\compositions\composition_functions.sqf";

/*
 * Radio towers
 */
private _radioTowers = createHashMapFromArray [
    [
        "compact",
        createHashMapFromArray [
            ["tent1", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tent_compact_1.sqf")]
        ]
    ],
    [
        "small",
        createHashMapFromArray [
            ["tower1", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_small_1.sqf")],
            ["tower2",([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_small_2.sqf")],
            ["tower3",([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_small_3.sqf")]
        ]
    ],
    [
        "med",
        createHashMapFromArray [
            ["tower1", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_med_1.sqf")],
            ["tower2", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_med_2.sqf")],
            ["tower3", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_med_3.sqf")],
            ["tower_hq", ([] call compile preprocessFileLineNumbers "scripts\compositions\comms\tower_hq_med_1.sqf")]
        ]
    ]
];

/*
 * Fortifications
 */
private _fortifications = createHashMapFromArray [
    [
        "rooftop",
        createHashMapFromArray [
            ["rooftop_small", ([] call compile preprocessFileLineNumbers "scripts\compositions\fortifications\mg_roof_tent.sqf")]
        ]
    ]
];

LP_compositions = createHashMapFromArray [
    ["radios", _radioTowers],
    ["fortifications", _fortifications]
];
