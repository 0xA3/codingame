using Lambda;

function sum( a:Array<Int> ) return a.fold(( v, sum ) -> sum + v, 0 );