package test;

import MainDrobor.mixWishes;
import haxe.Json;

using buddy.Should;

class TestMixWishesDrobor extends buddy.BuddySuite{

	public function new() {

		describe( "Test mixWishes Drobor", {
			it( "Example", { mixWishes( "laser eyes", "telepathy" )
			.should.be( "telasepart heyes" ); });
			
			it( "Polite", { mixWishes( "i wish for laser eyes please", "i wish for telepathy please" )
			.should.be( "i wish for telasepart heyes please" ); });
			
			it( "Global ideal", { mixWishes( "solve world hunger", "peace in the world" )
			.should.be( "solpveace in the world hunger" ); });
			
			it( "Beep Boop", { mixWishes( "beep", "boop" )
			.should.be( "boeoep" ); });
			
			it( "Wasted", { mixWishes( "oh i only wanted one wish", "oh i only wanted one wish" )
			.should.be( "oh i only wanted one wish" ); });
			
			it( "No overlap", { mixWishes( "nothing in common", "always" )
			.should.be( "nothing in aclowmamyosn" ); });
			
			it( "Rule breaker", { mixWishes( "my first wish is to have infinite wishes", "oh no it is not allowed i wasted my wish" )
			.should.be( "omhy no first wish inso to hallowved in fwiansited my wishes" ); });
			
			it( "Programmer's dream", { mixWishes( "i want to understand what dynamic programming is", "i wish to get better at competitive coding" )
			.should.be( "i wiasnht to ungderstand betterw hat dycnoampetitivec pcrogramdming is" ); });
			
			it( "Bug", { mixWishes( "bzzzzzzzzzzzbzt krrbrrrrzzbrt system error", "oh no lets reboot brrkzzbrrrt bzzzzzkzzt" )
			.should.be( "bzzzzzozhz znzoz zlbezts krerboot brrrkrzzbrrrt bzzzzzkszyzstem error" ); });
			
			it( "Congratulations", { mixWishes( "congratulations the wish mixer seems to work well", "you really are a master of competitive programming" )
			.should.be( "ycoun greatulatiolnys atrhe wisah masitxer of compsetitivems prto wgorakm mwienlgl" ); });
		});
	}
}
