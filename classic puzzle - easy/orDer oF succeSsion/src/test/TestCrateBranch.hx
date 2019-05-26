package test;

using buddy.Should;

@:access(Main)
class TestCrateBranch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test GetPersons", {
			
			final family = [ "Elizabeth - 1926 - Anglican F", "Charles Elizabeth 1948 - Anglican M", "William Charles 1982 - Anglican M", "George William 2013 - Anglican M", "Charlotte William 2015 - Anglican F", "Henry Charles 1984 - Anglican M" ];
			
			final personsOfFamily =  Main.getPersons( family );
			
			it( "First Persons Name", {
				personsOfFamily[0].name.should.be( "Elizabeth" );
			});
			
			it( "First Persons Parent", {
				personsOfFamily[0].parent.should.be( "-" );
			});
			
			it( "Second Persons Parent", {
				personsOfFamily[1].parent.should.be( "Elizabeth" );
			});
			
			it( "Number of persons with no parent", {
				personsOfFamily.filter( person -> person.parent == "-" ).length.should.be( 1 );
			});
			
		});

	   describe( "Test create tree", {
			
			final family = [ "Elizabeth - 1926 - Anglican F", "Charles Elizabeth 1948 - Anglican M" ];
			
			final personsOfFamily =  Main.getPersons( family );
			final tree = Main.createBranch( personsOfFamily[0], personsOfFamily );

			it( "Root Name", {
				tree.person.name.should.be( "Elizabeth" );
			});
			
			it( "Male Children", {
				tree.maleChildren.length.should.be( 1 );
			});

			it( "Female Children", {
				tree.femaleChildren.length.should.be( 0 );
			});

		});

	}
}