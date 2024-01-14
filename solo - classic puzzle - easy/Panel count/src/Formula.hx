class Formula {
	
	public final propertyValues:Array<PropertyValue>;

	public function new( propertyValues:Array<PropertyValue> ) {
		this.propertyValues = propertyValues;
	}

	public static function create( formulaInput:String ) {
		final connections = formulaInput.split( " AND " );
		final propertyValues = connections.map( p -> {
			final parts = p.split( "=" );
			final pv:PropertyValue = {
				property: parts[0],
				value: parts[1]
			}
			return pv;
		});

		return new Formula( propertyValues );
	}

	public function toString() return propertyValues.map( propertyValue -> '${propertyValue.property}=${propertyValue.value}' ).join( " AND " );
}