package ai.data;

enum Task {
	Wait;
	Harvest( fruit:TFruit );
	Plant( fruit:TFruit );
	Chop( player:Player );
	Mine;
}