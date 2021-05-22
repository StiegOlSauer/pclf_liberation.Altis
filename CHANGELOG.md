#### Version 0.95.1 Arsenal release (internal)

Arsenal:
  * Introduced Arsenal - core module which provides complex faction configurator: from weapons used to squads and progression
  * Introduced progression for weapons and all sorts of equipment for BLUFOR and OPFOR
  * All faction weapons have been graded by rareness depending on their properties, so cooler guns will appear later as the game progresses
  * OPFOR squads now use faction-specific compositions and equipment preferences
  * OPFOR squads in sectors use sector-specific equipment and weaponry, so you'll find similarly equipped soldiers in each sector, but between sectors equipment will change
  * Share of more modern weaponry in OPFOR arsenal increases with combat readiness
  * Vehicles in sectors are spawned according to faction arsenal
  * Ammoboxes could be either recycled for Ammo resource, or collected for arsenal unlocks

Factions:
  * New faction: AFRF PMC - fictional mercenaries group heavily backed by Russian militaries and operating in Middle-East and Europe. Has access to Russian and E. European hardware, but use of heavy assets is limited due to PMC nature of organization
  * New faction: ISIS - fictional terrorist organization from the Middle-East. Uses military internal structure and has access to heavy assets, however the majority of equipment consists of rather dated models.

Sectors:
  * Reworked spawn of soldiers in buildings

Other major changes:
  * ACE auto-detection
  * Medical option in mission parameters: "forgiving" with lower importance of medic role suitable for action-backed gameplay or small squads, "realistic" - for immersive gameplay and bigger squads
  * OPFOR/BLUFOR factions setup in mission parameters

Minor changes:
  * Respawn loadout is auto-saved upon exiting the BI arsenal
  * Resources bar is not shown outside of bases
  * Enabled in-engine garbage collector for bodies instead of scripted one
  * Enabled in-engine or ACE (depending on enabled mods) revive in favor of FAR revive
  * Optimization pass on sectors spawning and scheduled scripts
