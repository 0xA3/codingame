package ai.data;

enum Task {
	Chop( player:Player );
	Drop;
	Harvest( fruit:TFruit );
	Mine;
	Nothing;
	Plant( fruit:TFruit );
}