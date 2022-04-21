package agent;

enum TActionType {
	Move( x:Int, y:Int );
	Spell( s:TSpell );
	Wait;
}