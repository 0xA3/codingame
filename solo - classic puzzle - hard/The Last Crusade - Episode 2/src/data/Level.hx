package data;

import data.RockLocation;

typedef Level = {
	final width:Int;
	final height:Int;
	final cells:Array<Int>;
	final locked:Array<Bool>;
	final exit:Int;
	final indy:Location;
	final rocks:Array<RockLocation>;
}