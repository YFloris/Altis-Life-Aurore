/*
	Show cop license to target player
*/

private["_target", "_message","_rank","_coplevel"];

_target = cursorTarget;

if(playerSide != west) exitWith
{
	hint "Tu n'es pas gendarme !";
};

if( isNull _target) then {_target = player;};

if( !(_target isKindOf "Man") ) then {_target = player;};

if( !(alive _target) ) then {_target = player;};

_rank = "Pas un gendarme !?";
_coplevel = call life_coplevel;

//Set rank
switch ( _coplevel ) do
{
	case 1: { _rank = "Recrue"; };
	case 2: { _rank = "Brigadier 2C"; };	
	case 3: { _rank = "Brigadier 1C"; };	
	case 4: { _rank = "Adjudant"; };
	case 5: { _rank = "Lieutenant"; };
	case 6: { _rank = "Capitaine"; };
	case 7: { _rank = "Colonel"; };
	case 8: { _rank = "Gouverneur"; };
	case 9: { _rank = "IGGN"; };
	default {_rank =  "Error";}; //Super Sergeant of Master Sergeants to the max
};

_rank = ["cop", _coplevel] call life_fnc_permLevelName;

//Compose message
//_message = composeText [ image "icons\insigne.paa", lineBreak, lineBreak, name player, lineBreak, "Gendarmerie Aurore" ];
_message = format["<img size='10' color='#FFFFFF' image='icons\insigne.paa'/><br/><br/><t size='2.5'>%1</t><br/><t size='1.5'>%2</t><br/><t size='1'>Aurore Gendarmerie</t>", name player, _rank];

//Show license to target player
[[player, _message],"life_fnc_copLicenseShown",_target,false] spawn life_fnc_MP;
//[[[_message],{ hintSilent (_this select 0); }],"BIS_fnc_call",_target,false] spawn life_fnc_MP;
//[_message,"hintSilent",_target,false] spawn BIS_fnc_MP;