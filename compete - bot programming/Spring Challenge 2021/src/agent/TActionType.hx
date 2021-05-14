package agent;

enum TActionType {
	Grow;
	Seed;
	Complete( id:Int );
	Wait;
}