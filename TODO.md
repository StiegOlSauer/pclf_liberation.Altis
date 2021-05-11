TODO:
1. Performance:
    * Replace BIS_fnc_MP to remoteExec / remoteExecCall
    [+] Replace FAR revive with BIS one
    * Replace GREUH squadmanagement with BIS_fnc_dynamicGroups
    * Get rid of while {true} wherever possible (there are 60 of them)
    * [!] Use CBA Custom Events for sector management instead of `while {true}` loops
    * Use Dynamic Simulation where possible - not possible due to engine limitations
    * Migrate to Simple Objects where possible
    * Use EDEN Garbage collection (corpse and wreck managers)
    * Check for possibility to use agents instead of AIs
    * Diag_log -> BIS_fnc_logError
    * Recalculate resources via addPublicVariableEventHandler when published (instead of `while {true}` loop)
    * [!] Check: use of "curatorGroupPlaced" scripted EH (https://community.bistudio.com/wiki/Arma_3:_Scripted_Event_Handlers) for rearming Zeus soldiers
    * Minors:
      * BIS_fnc_param -> `param` and `params`
      * BIS_fnc_selectRandom -> selectRandom
      * Determining vehicle type: `vehicle player == player` -> `isNull objectParent player`
      * Selecting elements by condition: `{if (_x % 2 == 0) then { result pushBack _x; };} forEach arrayOfNumbers;` -> `result = (arrayOfNumbers select { _x % 2 == 0 });`
      * nearestObjects -> nearEntities // nearEntities only searches for alive objects and on-foot soldiers. In-vehicle units, killed units, destroyed vehicles, static objects and buildings will be ignored
      * `array + array` -> `append []`, `pushBack x`, `deleteAt y`
      * Use new `for...from...to` syntax: `for [{_i = 0}, {_i < 100}, {_i = _i + 1}] do {}` -> `for "_i" from 0 to 10 do {}`
      * Declare and initialize at the same time: `private ["_a", "_b", "_c", "_d"]` -> `private _a = 1;`
      * typeName -> isEqualType
      * `isNil {varName}` -> isNil `"varName"`
      * Conditional selecting: `{exitwith} foreach` -> `findIf`
      * Lazy evaluation: `private _myVar = [33, 66] select (false)`
      * position -> getPosWorld
      * `in forEach` -> arrayIntersect
      * use `deleteGroupWhenEmpty` for scheduled deletion instead of explicit removal
      * `({(alive _x) and (side _x == west)}count playableUnits) < 1` -> `playableUnits findIf { alive _x && side _x == west } == -1`
2. QOL:
    [+] Auto-detect ACE, auto disable BIS revive in favor of ACE
    [+] Presets fo realism or action for both medical system
    * Hide resources UI outside of the FOBs/bases
    * Auto-save loadout as re-spawn loadout when player closes the arsenal (https://forums.bohemia.net/forums/topic/223619-what-exactly-are-scriptedeventhandlers-answered-but-still-very-instructive/?do=findComment&comment=3360271), remove button from UI
    * Migrate sectors ownership information from flat lists to hashmaps (needed for reinforcements and alerts)
    * Soft and Hard sector activation:
      * Any sector in viscinity of which players were spotted (> 3 secs) becomes soft-activated
      * In soft-activated sectors 1 group of soldiers and 1 vehicle is spawned (as agents or no-simulation units)
      * If after fixed timeout (8 secs?) players are still near sector, it becomes hard-activated
      * Hard-activated sectors start accumulating the alert level and do spawn units, comm-towers and fortifications
      * If there are no more players near soft-activated sector after timeout, everything is de-spawned
      * Hard-activated sectors must remember if their comm-tower was destroyed (and maybe restore it after some timeout)
      * Hard-activated sectors must check their soft-alert level and adjust starting conditions
    * Recycling of wrecks (friendly and enemy) with repair trucks for some resources.
    [+] Remove of auto-reward for killing enemy vehicle
    * Investigate: decorate contested sectors with simple objects to make them more alive and distinct
3. Content:
    * Create weapon presets for different sides of conflict
    * Streamline units lineups
    * Fortifications in sectors: roadblocks, firebases, bunkers
    * Utilize CBA state machine for determining AI behavior in specific situations:
      * Motorized platoon shall dismount the infrantry and support it with fire while infantry searches buildings and captures the objective
      * Tank platoon shall not go to the cities until infantry is there. Platoon should perform flanking/encircle maneuver instead.
    * Change patrol logic: bring smaller patrol squads instead of full, make them stop for a minute on the each patrol point
    * Utilize state machine to manage sector defenders squads:
      * They should counter-attack players if they don't see them as a threat
      * They should garrison city buildings if players are recognized as a threat
    * [?] Convert sectors from markers to locations:
      * Utilize 'setSide' to define sector's allegiance
      * Use set(get)Variable for storing HashMap with sector properties
      * [!] Idea: Utilize CBA state machine for operating the sectors
    * New side missions:
      * Attack on barracks/repair facility/heavy vehicles maintenance base - inflicts casulaties to currently available forces
      * Heavy vehicles convoy
      * Assassination of officer on his inspection of bigtown/military sector (should cycle between mil sector and nearby town)
      * PMC camp attack (hidden in the forest)
4. Improve meta:
    * Capturing big-cities:
      * This should be a separate "mini-mode" like original insurgency
      * Each capital city is divided on several sub-sectors. These are shown red/green on map depending on their capture state
      * Each sub-sector has either military outpost or ammobox emplacement somewhere in it
      * Capital is captured when all ammoboxes and outposts are destroyed along with capital defenders
    * Defenders may flee from sectors if casulaties are big and no support is sent
    * Remove Air vehicles from spawn routine completely. These should be called as support during battlegroup operations or military sector defence. Otherwise they are just useless.
    * AA emplacements:
      * Plan AA outposts with AAA and AAM
      * Several types of emplacements with different area of coverage
      * These deny HALO within their range until destroyed
    * High power units spawning restrictions:
      * Planes are spawnable only if FOB is located at the airfield
      * Helicopters are spawnable only if helipad is constructed or FOB is located at the airfield
      * Heavy armor is spawnable only if repair tent is built
    * New progression system:
      * There are no "traditional" unit unlocks on the map
      * For *PMC* factions:
        * You can only buy and spawn light units with no armament on the base (+ FOB, Quad-bike, Spawn-truck and Recycler by default)
        * Capturing the sectors may provide players with an ability to spawn one unit with armament on their FOB
        * This unit is added to special list of "unlocked" units and could be spawned for free anytime, but only once
        * One unit type could be granted several times by different sectors, it accumulates if unlocked and not spent
        * "Ammo" resource could be spent either on bying standard units (unarmed jeeps, FOBs, spawn-trucks, etc...) or on upgrading the standard unit
        * Upgraded standard unit might bear some armament. There could be several upgrade levels, each unlocks own unit type (i.e. Vodnik->Vodnik(w/PKM/AGS)->Vodnik(30mm))
        * Repair vehicle could recycle allied/enemy wrecks for ammo resource
        * "Ammo" could be spent on off-map support and locals reinforcements
        * Ammoboxed could be recycled either for ammo or for new equipment unlocks
      * For *bandit* factions:
        * Ammo resource is complemented by "parts" resource
        * You can only buy and spawn light units with no armament on the base for some ammo cost
        * Standard units could be upgraded to their armed versions by paying ammo cost. Bandits should have variety of upgrades due to their unit spawn limitations
        * By recycling enemy and allied vehicles/wrecks, BLUFOR collect "parts" instead of ammo. When X parts are collected, one random unit of chosen type could be spawned on base (i.e. 3 parts for jeep, 6 for APC, 12 for random tank)
        * There are two types of spare (salvaged) parts: wheeled and tracked parts. Each is used for corresponding unit types.
        * Different unit types produce different amount of parts when recycled
        * [!] bandits progression does not use 'local military' units for spawning. Instead, units of the chosen bandit faction are used
        * To gain 'local military' units, bandit faction should spare some tropheys (ammo) and 'civilian reception' resources to call local reinforcements and then (if needed) confiscate the vehicle
        * Bandit BLUFOR could "Raze" any captured non-military, non-capital sector any time via context action on spawn truck. This gives significant amount of ammo, but the sector no longer provides respawns and decreases 'civilian reception' resource
      * For *government* factions:
        * Ammo resource is replaced by "military budget"
        * Armed units are available for spawning on base. They cost some "budget".
        * [!] government's progression does not use 'local military' units for spawning. Instead, units of the chosen faction are used
        * When non-standard unit is spawned, countdown is started preventing more spawns of any non-standard units
        * However, if armed unit is spawned, lost and no sector is captured, budget is cut down
        * If armed unit(s) is spawned and no sectors are captured in some time (i.e. 2 unit count-downs), budget is cut down
        * Certain levels of budget unlock new units types (for "free"), but the higher tier of the unit, the more budget is cut down if it is lost or was ineffective
        * Players could decide whether recycle ammoboxes for new ammunition, or send trophies for budget
        * Budget is increased when sector is captured and decreased if sector is lost
        * Budget is decreased for destroying civilian buildings or killing civs
        * Enemy wrecks could be recycled for small increase of budget (i.e. they are sent for exhibition showing army's victories)
        * If allied wreck is despawned by the timer, budget is cut down (journalists had the pictures of destroyed allied vehicles and upset the ministry). Allied wrecks should be recycled to aboid this, but they do not increase budget.
    * Special counter-actions for chosen enemy faction:
      * PMC: could deploy ambushes on roads
      * Government: could deploy artillery emplacements and send fire-missions anywhere they want. Destroying artillery positions removes this ability for some time
      * Terrorists/bandits: employ IEDs and suicide bombers
    * Offmap support unlockable by conquering the sectors (resistance force attack on trucks, on IFVs, artillery strike, air support)
    * Comm-arrays in enemy sectors or nearby them allowing enemies to bring reinforcements (and for players - deny enemies from doing that)
      * Investigate: ability to silently take-down comm arrays without alerting enemies - check for groups awareness level or measure noise inside sectors to capture exposions and gunfire (via fired EH?)
      * If Radio-tower is up in the range of sector's comm-array, then alert is increased in the whole area radio-tower is covering
      * If comm-array is destroyed, no reinforcements could be called (but alerted nearby sectors may decide to reinforce attacked sector)
      * Implement alert level accumulating from 0 to 100 steadily during active battle for sector. Influnces adjacent sectors readiness and reinforcements timers/quantity
        * Alert increases rapidly if comm-tower is alive
        * Alert level stops increasing when enemy count in sector is 2x less that blufor count [!] OR see below
        * Alert increase rate is low until casulaties reach 30% of sector garrison
        * Alert increase rate is high for every casualty taken between 30 and 70% of sector garrison. Then increase rate is low again.
        * Alert does not increase (or even decrease) if blufor casulaties are high in this sector (i.e. player deaths count is more than 0.5 of enemy count or if any blufor vehicle is destroyed)
        * Alert level causes the following effects:
          * 25 - +1 squad to reinforcement setup;
          * 50 - +5% readiness;
          * 75 - +1 veh to reinforcement;
          * 100 - immediate reinforcement is triggered;
        * If sector has accumulated some alert and players left that sector (it left staus of hard-activated), it becomes soft-alerted
        * All adjacent sectors within 1000 meters become soft-alerted and start accumulating alert level, but much slower (since soft alert effects are harder)
        * Soft-alerted sectors store their alert in special array along with timestamp of last modification;
        * Comm-towers in soft-alerted sectors work the same way
        * Soft-alerted sectors have the following effects:
          * 25 - 1 more defending squad if hard-activated;
          * 50 - improved fortifications;
          * 75 - 1 more veh if hard-activated; (or immediately send reinforcements)
          * 100 - immediate reinforcement trigger to currently hard-activated sector (or immediately start an attack on nearest blufor sector)
        * Soft alert is managed by main sector routine and is lowered if it was not increased during the control timeout (35 sec?)
        * If soft-alerted sector becomes hard-activated, it applies soft-alert effects (additional squads and fortifications) and then transfers soft-alert level to its current alert level
    * Differentiate battlegroups by dynamically constructing them from pre-defined units, instead of adding random single vehicles:
      * Battlegroup is a logical container for units, which only:
        * Defines their route and movement on global map
        * Simulates reactions and overall strategic behavior
        * Their objectives (capture, reinforce, defend sector/FOB)
        * Keeps track of losses
      * There are two types of battlegroups sharing the same core mechanics, but with different behavior logic:
        * Reinforcements - smaller size units used to streighten garrisons or help to repel BLUFOR assault. Mostly motorized infrantry with light armor support, but could be virtually anything that could garrison sectors
        * Assault - bigger battlegroup usually with heavy armor support
        * QRF - fast reinforcement/support for major objectives consisting of special forces on light wheeled/helicopter platforms
      * There are several types of groups which could be used in battlegroups (since all battlegroup's infantry comes with transport, there are no solely inf. units):
        * Motorized infrantry: inf.squad on light carrier (truck, jeep) - armed or unarmed, may appear with additional light vehicle support
        * Mechanized infantry: inf.squad on armed APC/IFV
        * Tank platoon
        * Special forces squad
        * Artillery platoon (Mortars, towed artillery and SPG)
        * Helicopter squadron
    * Long-term: area lockdown and S&D algorithms for the enemy:
      * If alert level reaches some point in the area (usually, areas are defined by radio towers' coverage, but discussable), area is marked as locked down
      * Roadblocks are established on all roads leading from this area to enemy controlled sectors
      * Battlegroups are formed on roads near borders of locked area (max: 3 groups)
      * After that countdown is started. Countdown limit is defined by:
        * Amount of enemy garrisons in the nearby bases
        * New "resource" - "Perception by civilians" - if it is low, countdown is decreased since civs are spying against BLUFOR
        * Combat readiness (should not occur on CR<20%)
        * Difficulty
      * When countdown ends, position of BLUFOR FOB (if any) in the area is uncovered
      * Battlegroups start their advance to the area to the closest BLUFOR sector, then repeat.
      * Battlegroups try to reach BLUFOR FOB, but capturing all the sectors on their path
      * Lockdown is ended when either:
        * FOB is located and destroyed
        * All BLUFOR sectors are re-captured by OPFOR
        * Battlegroups lost at least 75% of their units
        * Any military base (outside of locked area) is captured by BLUFOR [?]
      * When area is unlocked, all roadblocks are removed
    * Long-term: total pool of reinforcing inf/vehicles available for enemy HQ:
      * Reinforcement manager and router routines operate with garrisons and en-route reinforcement squads:
        * Manager checks sector statuses every 10 minutes (or according to diff.level):
          * Fortified sectors are reinforced from the military base or random non-fortified sector within 2000m, or the closest military base if there are no sectors within 2000m until all reinforcement slots are filled
          * There is a limit of 20 fortified sectors. When reached, FIFO sector looses "fortified" status
          * Non-fortified sectors are reinforced from the closest military base up to x% of reinforcements (based on readiness level)
          * When sector has excess of reinforcements (due to combat readiness decrease or losing fortified status), it distributes unwanted garrison units between nearest military bases
        * Router moves reinforcements markers for en-route reinforcements:
          * Each en-route reinforcement represents 1 "cap" and is "deployed" as invisible marker
          * Reinforcement route is plotted over the roads to the destination. Waypoint markers are placed each ~250 - 500m depending on particular squad speed
          * On each cycle router checks if reinforcement should reach next marker and marks it as current reinforcement position. Then ETA to next marker is calculated
          * If players appear in ~1000 - 1500m close to the current reinforcement marker, it is spawned (in safe location), teleported to current marker position, and its further markers are converted into waypoints
          * All reinforcements are guarded by 1-2 combat units depending on difficulty and Combat Readiness
          * Transport and guards vehicle types are determined by Combat Readiness
          * If players are no longer nearby, waypoints are removed and units are de-spawned
          * When reinforcement reaches destination, it adds 1 corrresponding amount of units to the garrison
      * Each sector has "base" garrison securing it from players
        * Town - 2 squads
        * Factory - 4 squads
        * Military base and Big city - 5 squads
      * Each sector can host several more units when reinforced by other sectors:
        * Town - up to 7 units: 3 squads, 2 fortifications, 2 vehs
        * Factory - 10 units: 6 squads, 2 fortifications, 2 vehs
        * Military base and Big city - 16 units: 10 squads, 2 fortifications, 4 vehs
      * At the start of the game, reinforcements are distributed equally according to difficulty settings
      * When players attack or capture a sector, it notifies sectors within 1500m range - these sectors become "fortified":
        * If sector's comm.tower is destroyed - nearby sectors are notified upon capture
        * If comm.tower is functional, nearby sectors are notified upon reaching 50% of alert level (see Alerts)
      * Players can build communications center to receive data about reinforced sectors within 4000m from FOB, spending 10 intel shows current reinforcements en-route
      * Reinforcements are regenerated on the military bases once per 6 reinforcements cycle ticks (60 minutes on normal difficulty):
        * Amount of regenerated reinforcements depends on count of captured big cities, factories and towns (in descending order)
        * Players can force skipping of reinforcements regen.tick by completing the side missions
        * Players can temporary decrease reinforcements regeneration rate by completing the side missions
    * [!] Idea: "features" assigned to every capturable sector in-game:
      * Examples:
        * Some may have increased/decreased infantry count;
        * An ambush of special forces instead of regular defenders
        * Additional intel/ammunition stowed in secret place
        * Have additional or no armour
        * May instantly start battlegroup counter-attack
        * May have one of high officers on a visit, so killing him will turn defenders to flee
      * These features are hidden from players by default
      * Players may spend some intel to uncover features of nearby sectors
      * Also, this may uncover vehicles that are granted for capturing the sector (for *PMC* progression) and garrison count.
    * Some, but not all sectors shall give players additional task before turning into BLUFOR sector (should be mission parameter, low priority):
      * New sector state: Neutral. Does not benefit BLUFOR and considered enemy for OPFOR
      * Capture sectors on usual conditions (all defenders are defeated), but do not provide resources until sector side-task is completed
      * Examples of such tasks:
        * Evacuate civilians out of the town before OPFOR battlegroup appears
        * Bring the lost post-car to the town
        * Help locals to arrange a deal with smugglers (which is happened to be an ambush)
        * Bus with hostages and tracking device. The idea is to get constantly moving towards the safe sector through roadblocks.
