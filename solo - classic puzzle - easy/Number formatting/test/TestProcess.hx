package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Only digits", Main.process( "200,000,000.000.002" ).should.be( "100,000,000.000.001" ));
			it( "Same number of digits", Main.process( "xxx,xxx,250.22x.xxx" ).should.be( "xxx,xxx,125.11x.xxx" ));
			it( "Integer", Main.process( "xxx,x24,238.xxx.xxx" ).should.be( "xxx,x12,119.xxx.xxx" ));
			it( "Right side shift", Main.process( "xxx,x23,150.120.1xx" ).should.be( "xxx,x11,575.060.05x" ));
			it( "Up to the last", Main.process( "xxx,xx1,111.130.29x" ).should.be( "xxx,xxx,555.565.145" ));
			it( "Both sides shift", Main.process( "xxx,xx1,111.130.1xx" ).should.be( "xxx,xxx,555.565.05x" ));
			it( "One", Main.process( "xxx,xxx,xx1.xxx.xxx" ).should.be( "xxx,xxx,xxx.5xx.xxx" ));
			it( "Zero", Main.process( "xxx,xxx,xxx.xxx.xxx" ).should.be( "xxx,xxx,xxx.xxx.xxx" ));
		});
	}
}
