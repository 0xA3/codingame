class Table {

	final personDatasets:Array<PersonDataset>;

	public function new( personDatasets:Array<PersonDataset> ) {
		this.personDatasets = personDatasets;
	}

	public static function create( persons:Array<String>, properties:Array<String> ) {
		final datasets = persons.map( person -> createDataset( person.split(" "), properties ));
		return new Table( datasets );
	}

	static function createDataset( personColumns:Array<String>, properties:Array<String> ) {
		final dataMap:Map<String, String> = [];
		for( i in 0...properties.length ) dataMap.set( properties[i], personColumns[i + 1] );

		final personDataset:PersonDataset = { name: personColumns[0], dataMap: dataMap }
		return personDataset;
	}

	public function filter( formula:Formula ) {
		var filtered = personDatasets;
		for( propertyValue in formula.propertyValues ) {
			final temp = filtered.filter( personDataset -> {
				if( !personDataset.dataMap.exists( propertyValue.property )) return false;
				if( personDataset.dataMap[propertyValue.property] == propertyValue.value ) return true;
				return false;
			});
			filtered = temp;
		}
		return filtered;
	}
}

