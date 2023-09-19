package test;

import CompileTime.parseJsonFile;
import Main.mergeFiles;

using StringTools;
using buddy.Should;

class TestMergeFiles extends buddy.BuddySuite{

	public function new() {

		describe( "Test mergeFiles", {
			it( "Example", { mergeFiles( parseJsonFile( "test/Test_1_input.txt" )).should.be( parseJsonFile( "test/Test_1_output.txt" )); });
			it( "Simple", { mergeFiles( parseJsonFile( "test/Test_2_input.txt" )).should.be( parseJsonFile( "test/Test_2_output.txt" )); });
			it( "Not always sorted", { mergeFiles( parseJsonFile( "test/Test_3_input.txt" )).should.be( parseJsonFile( "test/Test_3_output.txt" )); });
			it( "Passwords", { mergeFiles( parseJsonFile( "test/Test_4_input.txt" )).should.be( parseJsonFile( "test/Test_4_output.txt" )); });
			it( "Redundancy", { mergeFiles( parseJsonFile( "test/Test_5_input.txt" )).should.be( parseJsonFile( "test/Test_5_output.txt" )); });
			it( "Single unsorted file", { mergeFiles( parseJsonFile( "test/Test_6_input.txt" )).should.be( parseJsonFile( "test/Test_6_output.txt" )); });
			it( "Name not first", { mergeFiles( parseJsonFile( "test/Test_7_input.txt" )).should.be( parseJsonFile( "test/Test_7_output.txt" )); });
			it( "Strange", { mergeFiles( parseJsonFile( "test/Test_8_input.txt" )).should.be( parseJsonFile( "test/Test_8_output.txt" )); });
			it( "Single mutant", { mergeFiles( parseJsonFile( "test/Test_9_input.txt" )).should.be( parseJsonFile( "test/Test_9_output.txt" )); });
			it( "Names only", { mergeFiles( parseJsonFile( "test/Test_10_input.txt" )).should.be( parseJsonFile( "test/Test_10_output.txt" )); });
		});
	}
}
