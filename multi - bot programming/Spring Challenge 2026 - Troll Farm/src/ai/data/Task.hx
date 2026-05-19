package ai.data;

enum Task {
	NoTask;
	Harvest( fruit:TFruit );
	Plant( fruit:TFruit );
	Chop( player:Player );
	Mine;
}