package ai.data;

import xa3.math.Pos;

enum Task {
	Attack( priorities:Array<TResource> );
	Chop( player:Player, priorities:Array<TResource> );
	CoChop( tree:Tree );
	Drop;
	Harvest( fruit:TResource );
	Mine;
	Move( pos:Pos );
	Nothing;
	Plant( fruit:TResource );
}