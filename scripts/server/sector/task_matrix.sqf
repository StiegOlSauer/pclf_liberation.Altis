if (!isServer) exitWith {};

/*
Town task types.

1. Deliver
	1) Ammo truck (will not despawn truck but cost 10 ammo instead)
	2) Repair truck (will despawn it)
	3) Fuel truck (will despawn it)
	4) Food (side mission required to obtain food boxes)
	5) vehicle (civilian or light armoured)
	
2. Maintenance:
	1) Deploy FOB nearby
	2) Repair vehicle
	3) Build something (generator, fence, water pump...)

3. Eliminate:
	1) All enemies
	2) Kill officer
	3) Local gang in nearby city

4. Search:
	1) Someone kidnapped town elder, find the car, rescue the elder
	2) Someone robbed local bank, find suitcase with money

5. Camps:
	1) Independents captured civilians and relocated them to camp nearby, rescue them
	2) Military camp nearby
	3) Suicide bomber training base nearby

6. Help:
	1) Lost cargo. Help to retrieve cargo from abmushed convoy and deliver it back to town
	
7. Capture:
	1) Power plant nearby
	2) Town nearby

Military base task types.

1. Eliminate:
	1) All enemies
	2) big brass in heavy armoured vehicle
	
 2. Destroy:
	1) Helipad nearby
	2) Repair base nearby
	3) Tank platoon
	4) Helicopter that fell down nearby

3. Build:
	1) Comm array
	2) Helipad
	
4. Deliver:
	1) Ammo truck (20 ammo)
	2) Vehicle (armoured)
	
5. Retrieve:
	1) information from crashed UAV
	
Factory task types.

1. Deliver:
	1) Repair truck
	2) Fuel truck
	
2. Build:
	1) Generator
	2) Fuel tank
*/

tasks_matrix = [];