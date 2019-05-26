/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {

		final n = Std.parseInt( CodinGame.readline() );
		final lines:Array<String> = [];
		for( i in 0...n ) {
			lines.push( CodinGame.readline());
		}
		// for( line in lines ) CodinGame.printErr( line );
		final people = getPeople( lines );

		final peopleWithNoParent = people.filter( person -> person.parent == "-" );
		if( peopleWithNoParent.length != 1 ) throw 'Error: Exactly on person should have no parent. With the current input there are ${peopleWithNoParent.length}';

		final tree = createBranch( peopleWithNoParent[0], people );
		final sortedPeople = unwrap( tree );

		final livingPeople = sortedPeople.filter( person -> person.death == "-" );
		final anglicanPeople = livingPeople.filter( person -> person.religion == "Anglican");
		// CodinGame.printErr( sortedPeople );

		for( person in anglicanPeople ) CodinGame.print( person.name );
	}

	static function getPeople( lines:Array<String> ):Array<Person> {

		final people = lines.map( line -> {
			final inputs = line.split(' ');
			final person = {
				name: inputs[0],
				parent: inputs[1],
				birth: Std.parseInt( inputs[2] ),
				death: inputs[3],
				religion: inputs[4],
				gender: inputs[5] == "M" ? Male : Female
			}
			return person;
		});

		return people;
	}

	static function createBranch( person:Person, family:Array<Person> ):Branch {
		
		final children = family.filter( familyMember -> familyMember.parent == person.name );
		final maleChildren = children.filter( child -> child.gender == Male ).map( child -> createBranch( child, family ));
		final femaleChildren = children.filter( child -> child.gender == Female ).map( child -> createBranch( child, family ));

		maleChildren.sort( branchSort );
		femaleChildren.sort( branchSort );

		return { person: person, maleChildren: maleChildren, femaleChildren: femaleChildren };
	}

	static function branchSort( a:Branch, b:Branch ):Int {
		if( a.person.birth < b.person.birth ) return -1;
		else if(a.person.birth > b.person.birth ) return 1;
		return 0;
	}

	static function unwrap( branch:Branch ):Array<Person> {
		return [[ branch.person ], branch.maleChildren.flatMap( branch -> unwrap( branch )), branch.femaleChildren.flatMap( branch -> unwrap( branch )) ].flatten();
	}
}

typedef Person = {
	final name:String;
	final parent:String;
	final birth:Int;
	final death:String;
	final religion:String;
	final gender:Gender;
}

enum abstract Gender(String) {
	var Male = "M";
	var Female = "F";
}

typedef Branch = {
	final person:Person;
	final maleChildren:Array<Branch>;
	final femaleChildren:Array<Branch>;
}