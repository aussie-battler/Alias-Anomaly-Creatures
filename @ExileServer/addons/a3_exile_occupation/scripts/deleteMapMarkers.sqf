
if (SC_occupyLootCratesMarkers) then
{
	// Delete the map marker on a loot crate when a player gets in range

	for "_i" from 1 to SC_numberofLootCrates do
	{
		_markerName = format ["SC_loot_marker_%1", _i];
		_pos = getMarkerPos _markerName;
		
		if(!isNil "_pos") then
		{
			
			if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then
			{ 
				deleteMarker _markerName; 
				_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
				[_logDetail] call SC_fnc_log;
			};
			
		};
	};						
};

/*
if (SC_occupyLootCratesMarkers) then
{
	// If you put this code in the Slimy Fart won't reappear when players reach the crate.

	for "_i" from 1 to SC_numberofLootCrates do
	{
		_markerName = format ["Toxic_%1", _i];
		_pos = getMarkerPos _markerName;
		
		if(!isNil "_pos") then
		{
			
			if([_pos, 10] call ExileClient_util_world_isAlivePlayerInRange) then
			{ 
				deleteMarker _markerName; 
				_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
				[_logDetail] call SC_fnc_log;
			};
			
		};
	};						
};
*/

if (SC_occupyLootCratesMarkers) then
{
	// Delete the map marker on a loot crate when a player gets in range

	for "_i" from 1 to SC_numberofLootCrates do
	{
		_markerName = format ["Screamer_%1", _i];
		_pos = getMarkerPos _markerName;
		
		if(!isNil "_pos") then
		{
			
			if([_pos, 10] call ExileClient_util_world_isAlivePlayerInRange) then
			{ 
				deleteMarker _markerName; 
				_logDetail =  format ["[OCCUPATION:LootCrates]:: marker %1 removed at %2",_markerName,time];
				[_logDetail] call SC_fnc_log;
			};
			
		};
	};						
};

if (SC_HeliCrashMarkers) then
{
	// Delete the map marker on a HeliCrash when a player gets in range

	for "_i" from 1 to SC_numberofHeliCrashes do
	{
		_markerName = format ["SC_helicrash_marker_%1", _i];
		_pos = getMarkerPos _markerName;
		
		if(!isNil "_pos") then
		{
			
			if([_pos, 15] call ExileClient_util_world_isAlivePlayerInRange) then
			{ 
				deleteMarker _markerName; 
				_logDetail =  format ["[OCCUPATION:HeliCrashes]:: marker %1 removed at %2",_markerName,time];
				[_logDetail] call SC_fnc_log;
			};
			
		};
	};						
};