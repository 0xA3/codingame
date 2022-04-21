package agent;

enum TSpell {
	Wind( x:Int, y:Int );
	Shield( entityId:Int );
	Control( entityId:Int, x:Int, y:Int );
}