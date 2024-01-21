package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( "15" ).should.be( "12" ));
			it( "Test 2", Main.process( "666" ).should.be( "aaa" ));
			it( "Test 3", Main.process( "aaa" ).should.be( "aaa" ));
			it( "Test 4", Main.process( "babe"  ).should.be( "Not a number" ));
			it( "Test 5", Main.process( "1aaa1"  ).should.be( "16661" ));
			it( "Test 6", Main.process( "555689abde1222"  ).should.be( "55519bd6e8a222" ));
			it( "Test 7", Main.process( "23456789abcdef01"  ).should.be( "23456789abcdef01" ));
			it( "Test 8", Main.process( "125689ae0ea986521"  ).should.be( "152a8e69096e8a251" ));
			it( "Test 9", Main.process( readFile( "test/test_09.txt" )).should.be( readFile( "test/result_09.txt" ) ));
			it( "Test 10", Main.process( readFile( "test/test_10.txt" )).should.be( readFile( "test/result_10.txt" ) ));
			it( "Test 11", Main.process( readFile( "test/test_11.txt" )).should.be( readFile( "test/result_11.txt" ) ));
			it( "Test 12", Main.process( readFile( "test/test_12.txt" )).should.be( readFile( "test/result_12.txt" ) ));
		});
	}
}
