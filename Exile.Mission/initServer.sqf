#include "AL_flamer\functions_flame.hpp"

//Below is an example of how to run Alias' scripts at night :) cheers aussie.
// If you like the scripts you can support Alias at https://www.patreon.com/aliascartoons 
/*
 private["_fnc_Alias"];

_fnc_Alias =
{
    switch (true) do
    {
            if (daytime >= 19 || daytime < 6) then   // after 7pm and before 6am run Alias' scripts
            {
                [] execVM "\x\addons\a3_exile_occupation\scripts\occupationFlamer.sqf";
            }
            else
            {
            };
    };
    true
};
if!(isNil 'Fnc_AliasThread') then { [Fnc_AliasThread] call ExileServer_system_thread_removeTask; };
Fnc_AliasThread = [60, _fnc_Alias, [], true] call ExileServer_system_thread_addtask;      
//change 60 seconds to the amount of seconds it takes for night to start on your server
*/