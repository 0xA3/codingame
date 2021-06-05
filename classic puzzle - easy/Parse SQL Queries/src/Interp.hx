import Expr;
import haxe.macro.Expr.Case;

class Interp {

	public static function execute( commands:Array<Expr>, inputTable:Table ) {
		var table = inputTable;
		commands.sort(( a, b ) -> {
			final pA = getPriority( a );
			final pB = getPriority( b );
			if( pA < pB ) return -1;
			if( pA > pB ) return 1;
			return 0;
		});
		
		for( command in commands ) {
			switch command {
				case ESelect( columnNames ): table = table.select( columnNames );
				case EFrom( tableName ): // not used
				case EWhere( columnName, columnValue ): table = table.filter( columnName, columnValue );
				case EOrderBy( columnName, order ): table = table.orderBy( columnName, order );
			}
		}
		return table;
	}

	static function getPriority( e:Expr ) {
		switch e {
			case ESelect(_): return 3;
			case EFrom(_): return 0;
			case EWhere(_,_): return 1;
			case EOrderBy(_,_): return 2;
		}
	}

}
