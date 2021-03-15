package data;

typedef Level = {
	final width:Int;
	final height:Int;
	final cells:Array<Int>;
	final locked:Array<Bool>;
	final exit:Int;
	final indy:Location;
}