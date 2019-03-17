private ["_veh","_weed","_weed2","_weed3","_weed4","_weed5","_weed6","_group","_position"];

if (!isServer) exitWith {};

_logDetail = format ["[OCCUPATION:Spectre]:: Starting Occupation Spectre"];
[_logDetail] call SC_fnc_log;

_logDetail = format["[OCCUPATION:Spectre]:: worldname: %1 crates to spawn: %2",worldName,SC_numberofSpectres];
[_logDetail] call SC_fnc_log;
private _position = [0,0,0];

for "_i" from 1 to SC_numberofSpectres do
{
	_validspot 	= false;
	while{!_validspot} do 
	{
		sleep 0.2;
		if(SC_occupySpectreStatic) then
		{
			_tempPosition = SC_occupySpectreLocations call BIS_fnc_selectRandom;
			SC_occupySpectreLocations = SC_occupySpectreLocations - _tempPosition;
			
			_position = [_tempPosition select 0, _tempPosition select 1, _tempPosition select 2];
			if(isNil "_position") then
			{
				_position = [ false, false ] call SC_fnc_findsafePos;
			};
		}
		else
		{
			_position = [ false, false ] call SC_fnc_findsafePos;
		};
		
		_validspot	= true;
		
		//Check if near another crate site
		_nearOtherCrate = (nearestObjects [_position,["CargoNet_01_box_F"],500]) select 0;	
		if (!isNil "_nearOtherCrate") then { _validspot = false; };			
	};	
	
	_mapMarkerName = format ["Spectre_%1", _i];
	
	if (SC_occupySpectreMarkers) then 
	{		
		_event_marker = createMarker [_mapMarkerName, _position];
		_event_marker setMarkerColor "ColorBlack";
		_event_marker setMarkerAlpha 1;
		_event_marker setMarkerText "Spectre: bring grenades";
		_event_marker setMarkerType "KIA";
	};	

		null = [_mapMarkerName,200,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	//null = ["Spectre_2",200,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";
//	null = ["Spectre_2","H_PilotHelmetFighter_B",false,30,0.01,true,12] execVM "AL_farty\area_toxic_ini.sqf";	
	null = [_mapMarkerName,"H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";
	//null = ["Spectre_2","H_PilotHelmetFighter_B",false] execvm "AL_spark\al_sparky.sqf";	
	
	if (SC_SpawnSpectreGuards) then
	{
			//Infantry spawn using DMS
			_AICount = SC_SpectreCrateGuards;
			
			if(SC_SpectreCrateGuardsRandomize) then 
			{
				_AICount = 1 + (round (random (SC_SpectreCrateGuards-1)));    
			};

			if(_AICount > 0) then
			{
				_spawnPosition = [_position select 0, _position select 1, 0];
				
				_initialGroup = createGroup SC_BanditSide;
				_initialGroup setCombatMode "BLUE";
				_initialGroup setBehaviour "SAFE";
				
				for "_i" from 1 to _AICount do
				{		
					_customGearSet =
				[
					"srifle_DMR_05_hex_F",
					["muzzle_snds_93mmg","optic_Arco","bipod_02_F_blk"],
					[["10Rnd_93x64_DMR_05_Mag",4],["Titan_AT",1]],          
					"",
					[""],
					["Rangefinder","ItemGPS"],
					"launch_O_Titan_short_ghex_F",
					"H_PilotHelmetFighter_B", // helmet
					"U_I_GhillieSuit",  // uniform
					"V_PlateCarrierSpec_blk",  //vest
					"B_Carryall_ghex_F" //backpack
				];
					_unit = [_initialGroup,_spawnPosition,"custom","random","bandit","soldier",_customGearSet] call DMS_fnc_SpawnAISoldier; 
					_unitName = ["bandit"] call SC_fnc_selectName;
					if(!isNil "_unitName") then { _unit setName _unitName; }; 
					reload _unit;
				};
				
				// Get the AI to shut the fuck up :)
				enableSentences false;
				enableRadio false;

				  
				_group = createGroup SC_BanditSide;           
				_group setVariable ["DMS_LockLocality",nil];
				_group setVariable ["DMS_SpawnedGroup",true];
				_group setVariable ["DMS_Group_Side", SC_BanditSide];
				_group setVariable ["VCM_TOUGHSQUAD",true];
				_group setVariable ["VCM_NORESCUE",true];
				_group setVariable ["Vcm_Disable",true];
				
				{	
					_unit = _x;           
					[_unit] joinSilent grpNull;
					[_unit] joinSilent _group;
					_unit setCaptive false;                               
				}foreach units _initialGroup;  		
				deleteGroup _initialGroup;
				
									// add vehicle patrol and randomise a little - same for all levels (as it uses variable)
				_veh =
				[
					[
						[(_position select 0) -(35-(random 5)),(_position select 1) +(35+(random 5)),0]
					],
					_group,
					"assault",
					"hardcore",
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIVehicle;		
				
				[_group, _spawnPosition, 25] call bis_fnc_taskPatrol;
				_group setBehaviour "STEALTH";
				_group setCombatMode "RED";
				_group setVariable ["VCM_TOUGHSQUAD",true];
				_group setVariable ["VCM_NORESCUE",true];
				_group setVariable ["Vcm_Disable",true];				


				_logDetail = format ["[OCCUPATION:Spectre]::  Creating crate %3 at drop zone %1 with %2 guards",_position,_AICount,_i];
				[_logDetail] call SC_fnc_log;		
			};
	}
	else
	{
		_logDetail = format ["[OCCUPATION:Spectre]::  Creating crate %2 at drop zone %1 with no guards",_position,_i];
		[_logDetail] call SC_fnc_log;	
	};

	//_box = "CargoNet_01_box_F" createvehicle _position;
    _box = createVehicle ["CargoNet_01_box_F",[(_position select 0) -2.38818, (_position select 1) -3.37671,0],[], 0, "CAN_COLLIDE"];	
	clearMagazineCargoGlobal _box;
	clearWeaponCargoGlobal _box;
	clearItemCargoGlobal _box;
	
	_box enableRopeAttach SC_SpectreropeAttach; 	// Stop people airlifting the crate
	_box setVariable ["permaLoot",true]; 	// Crate stays until next server restart
	_box setVariable ["ExileMoney", (5000 + round (random (20000))),true];
	_box allowDamage false; 				// Stop crates taking damage

	{
		_item = _x select 0;
		_amount = _x select 1;
		_randomAmount = _x select 2;
		_amount = _amount + (random _randomAmount);
		_itemType = _x call BIS_fnc_itemType;
		
		
		if((_itemType select 0) == "Weapon") then
		{
			_box addWeaponCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Magazine") then
		{
			_box addMagazineCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Item") then
		{
			_box addItemCargoGlobal [_item, _amount];	
		};
		if((_itemType select 0) == "Equipment") then
		{
			_box addItemCargoGlobal [_item, _amount];	
		};	
		if((_itemType select 0) == "Backpack") then
		{
			_box addBackpackCargoGlobal [_item, _amount];	
		};			
	}forEach SC_SpectreItems;	
	
	
	_effect = "test_EmptyObjectForSmoke";	
	_wreckFire = _effect createVehicle (position _box);   
	_wreckFire attachto [_box, [0,0,-1]];
	

					["toastRequest", ["InfoTitleAndText", ["The Spectre is back!", "Better get some grenades and strap on your brown pants."]]] call ExileServer_system_network_send_broadcast;			

// mission objects
		private _objects = [
	["Land_Cargo_Tower_V1_No7_F",[-20.5029,-3.71802,0],180,[true,false]],
	["Land_Wreck_Slammer_F",[-17.8101,18.165,0],54.5956,[true,false]],
	["Land_Cargo_Tower_V1_No4_F",[-13.9272,-25.8135,0],131.964,[true,false]],
	["Land_Wreck_AFV_Wheeled_01_F",[20.1968,-3.86987,0],0,[true,false]],
	["CamoNet_BLUFOR_open_F",[-0.333496,4.74707,0],0,[true,false]],
	["Land_GarbagePallet_F",[-3.93164,11.4038,0],0,[true,false]],
	["Land_BagFence_Round_F",[5.11914,10.1406,0],222.035,[true,false]],
	["Land_BagFence_Long_F",[3.93164,12.5571,0],72.035,[true,false]],
	["Land_BagFence_Long_F",[7.62744,9.56226,0],177.035,[true,false]],
	["Land_BagFence_Long_F",[-3.9585,0.74707,0],165,[true,false]],
	["Land_BagFence_Long_F",[-1.4585,1.37207,0],165,[true,false]],
	["Land_BagFence_Long_F",[-10.2739,1.30029,0],289.451,[true,false]],
	["Land_BagFence_Long_F",[-5.9585,1.62183,0],75,[true,false]],
	["Land_PaperBox_closed_F",[12.7617,3.06885,0],150,[true,false]],
	["Land_PaperBox_closed_F",[11.3481,6.51489,0],0,[true,false]],
	["Land_BagFence_Short_F",[0.166504,0.62207,0],255,[true,false]],
	["Land_BagFence_End_F",[9.31787,9.38428,0],222.035,[true,false]],
	["Land_BagFence_End_F",[3.58008,14.2209,0],102.035,[true,false]],
	["Land_TouristShelter_01_F",[-2.2085,-3.50342,0],345,[true,false]],
	["Land_PowerGenerator_F",[6.81787,-0.286865,0],162.234,[true,false]],
	["Land_BagFence_Long_F",[2.1665,-1.50293,0],165,[true,false]],
	["Land_BagFence_Long_F",[-10.2612,-5.73511,0],255,[true,false]],
	["Land_BagFence_Long_F",[-1.77051,-8.82983,0],345,[true,false]],
	["Land_BagFence_Long_F",[3.35449,-6.70435,0],165,[true,false]],
	["Land_BagFence_Long_F",[0.979492,-8.07983,0],345,[true,false]],
	["Land_BagFence_Long_F",[-11.1362,-2.86011,0],75,[true,false]],
	["Land_BagFence_Short_F",[0.532227,-1.10156,0],255,[true,false]],
	["Land_BagFence_End_F",[2.10449,-7.57983,0],255,[true,false]],
	["Land_TTowerSmall_1_F",[0.916504,-0.628174,-4.76837e-007],345,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[2.04004,6.35327,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-3.78223,6.47998,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-23.5723,-4.33057,0],0,[true,false]],
	["CUP_A2_p_fiberplant_ep1",[-8.29297,-2.49756,0],0,[true,false]]
];

private _center = [_position select 0, _position select 1, 0];
{
	private _object = (_x select 0) createVehicle [0,0,0];
	_object setDir (_x select 2);
	_object setPosATL (_center vectorAdd (_x select 1));
	_object enableSimulationGlobal ((_x select 3) select 0);
	_object allowDamage ((_x select 3) select 1);
} forEach _objects;

					// add vehicle patrol and randomise a little - same for all levels (as it uses variable)
				_veh =
				[
					[
						[(_position select 0) -(34-(random 1)),(_position select 1) +(16+(random 5)),0]
					],
					_group,
					"assault",
					"hardcore",
					"bandit",
					"random"
				] call DMS_fnc_SpawnAIVehicle;		
				
				// add static guns - same for all levels
_staticGuns =
[
	[
		// make statically positioned relative to centre point and randomise a little
		[(_position select 0) -23.5229, (_position select 1) -3.97754,23.3],
		[(_position select 0) -(26-(random 1)),(_position select 1)+(15-(random 1)),0]
	],
	_group,
	"assault",
	"difficult",
	"bandit",
	"random"
] call DMS_fnc_SpawnAIStaticMG;

};


