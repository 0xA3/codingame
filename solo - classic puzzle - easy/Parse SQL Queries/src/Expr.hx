enum Expr {
	ESelect( columnNames:Array<String> );
	EFrom( tableName:String );
	EWhere( columnName:String, columnValue:String );
	EOrderBy( columnName:String, order:Order );
}

