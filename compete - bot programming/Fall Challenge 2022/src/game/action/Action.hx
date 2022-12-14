package game.action;

import game.Coord;

enum Action {
	Build( pos:Coord );
	Message( text:String );
	Move( amount:Int, from:Coord, to:Coord );
	Spawn( amount:Int, pos:Coord );
	Wait;
	Warp( amount:Int, from:Coord, to:Coord );
}