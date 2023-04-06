package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "1 Starters", {
				final ip = starters;
				Main.process( ip.original, ip.words ).should.be( startersResult );
			});
			it( "2 Prefix letter", {
				final ip = prefixLetter;
				Main.process( ip.original, ip.words ).should.be( prefixLetterResult );
			});
			it( "3 Suffix letter", {
				final ip = suffixLetter;
				Main.process( ip.original, ip.words ).should.be( suffixLetterResult );
			});
			it( "4 Prefix words", {
				final ip = prefixWords;
				Main.process( ip.original, ip.words ).should.be( prefixWordsResult );
			});
			it( "5 Suffix words", {
				final ip = suffixWords;
				Main.process( ip.original, ip.words ).should.be( suffixWordsResult );
			});
			it( "6 Repeated", {
				final ip = repeated;
				Main.process( ip.original, ip.words ).should.be( repeatedResult );
			});
			it( "7 Combo", {
				final ip = combo;
				Main.process( ip.original, ip.words ).should.be( comboResult );
			});
			it( "8 Unsolvable", {
				final ip = unsolvable;
				Main.process( ip.original, ip.words ).should.be( unsolvableResult );
			});
			it( "9 Actually solvable", {
				final ip = actuallySolvable;
				Main.process( ip.original, ip.words ).should.be( actuallySolvableResult );
			});
			it( "10 Actually solvable 2", {
				final ip = actuallySolvable2;
				Main.process( ip.original, ip.words ).should.be( actuallySolvable2Result );
			});
			it( "11 Actually solvable 3", {
				final ip = actuallySolvable3;
				Main.process( ip.original, ip.words ).should.be( actuallySolvable3Result );
			});
			it( "12 Actually solvable 4", {
				final ip = actuallySolvable4;
				Main.process( ip.original, ip.words ).should.be( actuallySolvable4Result );
			});
			it( "13 Actually solvable 5", {
				final ip = actuallySolvable5;
				Main.process( ip.original, ip.words ).should.be( actuallySolvable5Result );
			});
			it( "14 Performance 1 (70 words)", {
				final ip = performance1;
				Main.process( ip.original, ip.words ).should.be( performance1Result );
			});
			it( "15 Performance 2 (140 words)", {
				final ip = performance2;
				Main.process( ip.original, ip.words ).should.be( performance2Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final original = lines[0];
		final words = lines[1].split(" ");
	
		return { original: original, words: words };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final starters = parseInput(
		"ABCDEFGHIJ
		DEF J ABC GHI" );

	final startersResult = parseResult(
		"ABC DEF GHI J" );

	final prefixLetter = parseInput(
		"ABCAFEAHI
		AHI AFE ABC" );
	
	final prefixLetterResult = parseResult(
		"ABC AFE AHI" );
	
	final suffixLetter = parseInput(
		"ABCDFCGHC
		ABC GHC DFC" );
	
	final suffixLetterResult = parseResult(
		"ABC DFC GHC" );
		

	final prefixWords = parseInput(
		"ABCDEABABCABCD
		ABCD AB ABC ABCDE" );
	
	final prefixWordsResult = parseResult(
		"ABCDE AB ABC ABCD" );

	final suffixWords = parseInput(
		"ABCDBCDCD
		CD ABCD BCD" );
	
	final suffixWordsResult = parseResult(
		"ABCD BCD CD" );
	
	final repeated = parseInput(
		"ABCEDFEDFABC
		EDF EDF ABC ABC" );
	
	final repeatedResult = parseResult(
		"ABC EDF EDF ABC" );
	
	final combo = parseInput(
		"ABABCDCDEABCDEABCD
		CDE AB ABCD CDE AB ABCD" );
	
	final comboResult = parseResult(
		"AB ABCD CDE AB CDE ABCD" );
	
	final unsolvable = parseInput(
		"STARSTARSTAR
		STARS TAR STAR" );
	
	final unsolvableResult = parseResult(
		"Unsolvable" );
	
	final actuallySolvable = parseInput(
		"SAPIENSAPIENPURUSPURUS
		PURUS SAPIEN SAPIENPURUS" );
	
	final actuallySolvableResult = parseResult(
		"SAPIEN SAPIENPURUS PURUS" );
	
	final actuallySolvable2 = parseInput(
		"ABCABABC
		AB ABC CAB" );
	
	final actuallySolvable2Result = parseResult(
		"AB CAB ABC" );
	
	final actuallySolvable3 = parseInput(
		"AABABA
		AB A ABA" );
	
	final actuallySolvable3Result = parseResult(
		"A AB ABA" );
	
	final actuallySolvable4 = parseInput(
		"ABABABA
		BA AB ABA" );
	
	final actuallySolvable4Result = parseResult(
		"AB ABA BA" );
	
	final actuallySolvable5 = parseInput(
		"ABABABA
		ABA ABA B" );
	
	final actuallySolvable5Result = parseResult(
		"ABA B ABA" );
	
	final performance1 = parseInput(
		"LOREMIPSUMDOLORSITAMETCONSECTETURADIPISCINGELITSEDDOEIUSMODTEMPORINCIDIDUNTUTLABOREETDOLOREMAGNAALIQUAUTENIMADMINIMVENIAMQUISNOSTRUDEXERCITATIONULLAMCOLABORISNISIUTALIQUIPEXEACOMMODOCONSEQUATDUISAUTEIRUREDOLORINREPREHENDERITINVOLUPTATEVELITESSECILLUMDOLOREEUFUGIATNULLAPARIATUREXCEPTEURSINTOCCAECATCUPIDATATNONPROIDENTSUNTINCULPAQUIOFFICIADESERUNTMOLLITANIMIDESTLABORUM
		QUI IN CILLUM AUTE ULLAMCO ESSE INCIDIDUNT EA LABORUM ET NULLA ELIT MINIM IN EIUSMOD ALIQUA DESERUNT QUIS VOLUPTATE MOLLIT DOLOR OFFICIA UT ANIM DOLORE TEMPOR EU UT LABORIS SIT UT VENIAM PARIATUR SUNT CUPIDATAT CONSEQUAT CONSECTETUR OCCAECAT ENIM CULPA IPSUM AMET EXCEPTEUR EXERCITATION ADIPISCING COMMODO LOREM FUGIAT MAGNA NON VELIT AD PROIDENT LABORE DOLOR EST NOSTRUD DUIS SED IRURE NISI ALIQUIP IN DO ID EX DOLORE SINT REPREHENDERIT" );
	
	final performance1Result = parseResult(
		"LOREM IPSUM DOLOR SIT AMET CONSECTETUR ADIPISCING ELIT SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA UT ENIM AD MINIM VENIAM QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT DUIS AUTE IRURE DOLOR IN REPREHENDERIT IN VOLUPTATE VELIT ESSE CILLUM DOLORE EU FUGIAT NULLA PARIATUR EXCEPTEUR SINT OCCAECAT CUPIDATAT NON PROIDENT SUNT IN CULPA QUI OFFICIA DESERUNT MOLLIT ANIM ID EST LABORUM" );
	
	final performance2 = parseInput(
		"LOREMIPSUMDOLORSITAMETCONSECTETURADIPISCINGELITSEDDOEIUSMODTEMPORINCIDIDUNTUTLABOREETDOLOREMAGNAALIQUAESTLIBEROMOLESTIEACCUMSANDUIACRISUSINCEPTOSHABITASSEHABITASSEFINIBUSAORNAREINTERDUMVITAEHIMENAEOSAUGUEPHASELLUSSAPIENSITSOCIOSQUPHARETRAFINIBUSMORBIALIQUETTINCIDUNTCLASSESTDIAMHABITASSEFEUGIATMAGNAPROINMAURISVIVAMUSTINCIDUNTALIQUETNIBHALIQUAMACUBILIATELLUSLEOFELISALIQUAMVOLUTPATANTENAMVITAEDOLORPRETIUMTELLUSGRAVIDACONGUEALIQUETFAMESCONDIMENTUMNUNCNULLADIAMPRAESENTEGESTASTORTORALIQUETCONDIMENTUMFUSCEVULPUTATEPURUSINTERDUMMAURISULTRICESPULVINARFINIBUSNEQUELIGULALUCTUSNULLAMDAPIBUSBLANDITACDOLORVEHICULAMOLESTIELAOREETPLATEATINCIDUNTSAPIENPURUSNISLMOLLISIPSUMMINISIVELITHENDRERITSEDELEMENTUMCURABITURMAURISPHARETRAUTARCUSUSCIPITQUISVENENATISFAMESFEUGIATVELITNETUSBLANDITCONUBIAVELPROINPOSUEREVEHICULALAOREETCRASSEMPERMAXIMUSFINIBUS
		PRETIUM DOLORE VEHICULA FINIBUS ET ALIQUAM VELIT MOLESTIE ALIQUET CONDIMENTUM MAURIS CONDIMENTUM PROIN LIBERO CRAS MI AC TINCIDUNT NISL HABITASSE VITAE EST MOLESTIE VEHICULA MOLLIS FAMES AMET NAM UT CLASS ANTE HIMENAEOS DIAM NUNC BLANDIT NETUS NIBH IPSUM SED A QUIS NEQUE SAPIENPURUS ULTRICES AC LOREM FAMES UT LAOREET SUSCIPIT ALIQUET VULPUTATE SEMPER ALIQUAM FELIS TELLUS NULLA TINCIDUNT INTERDUM CONGUE ALIQUET MAXIMUS NISI LEO POSUERE LIGULA FEUGIAT HABITASSE RISUS TEMPOR INTERDUM PROIN ADIPISCING FINIBUS PHARETRA TORTOR ELEMENTUM VELIT INCEPTOS VEL ELIT DOLOR A DO CONSECTETUR LUCTUS BLANDIT VENENATIS FEUGIAT MAGNA TELLUSGRAVIDA MAURIS VITAE PHARETRA SAPIEN ALIQUA CUBILIA DOLOR PULVINAR DUI LAOREET FINIBUS PURUS DIAM MORBI EIUSMOD PLATEA MAGNA CURABITUR ORNARE PRAESENT DOLOR NULLAM EGESTAS TINCIDUNT LABORE IPSUM CONUBIA FUSCE INCIDIDUNT SIT FINIBUS MAURIS VOLUTPAT ARCU AUGUE HENDRERIT SOCIOSQU HABITASSE SIT EST ACCUMSAN PHASELLUS SED ALIQUET VIVAMUS DAPIBUS" );
	
	final performance2Result = parseResult(
		"LOREM IPSUM DOLOR SIT AMET CONSECTETUR ADIPISCING ELIT SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA EST LIBERO MOLESTIE ACCUMSAN DUI AC RISUS INCEPTOS HABITASSE HABITASSE FINIBUS A ORNARE INTERDUM VITAE HIMENAEOS AUGUE PHASELLUS SAPIEN SIT SOCIOSQU PHARETRA FINIBUS MORBI ALIQUET TINCIDUNT CLASS EST DIAM HABITASSE FEUGIAT MAGNA PROIN MAURIS VIVAMUS TINCIDUNT ALIQUET NIBH ALIQUAM A CUBILIA TELLUS LEO FELIS ALIQUAM VOLUTPAT ANTE NAM VITAE DOLOR PRETIUM TELLUSGRAVIDA CONGUE ALIQUET FAMES CONDIMENTUM NUNC NULLA DIAM PRAESENT EGESTAS TORTOR ALIQUET CONDIMENTUM FUSCE VULPUTATE PURUS INTERDUM MAURIS ULTRICES PULVINAR FINIBUS NEQUE LIGULA LUCTUS NULLAM DAPIBUS BLANDIT AC DOLOR VEHICULA MOLESTIE LAOREET PLATEA TINCIDUNT SAPIENPURUS NISL MOLLIS IPSUM MI NISI VELIT HENDRERIT SED ELEMENTUM CURABITUR MAURIS PHARETRA UT ARCU SUSCIPIT QUIS VENENATIS FAMES FEUGIAT VELIT NETUS BLANDIT CONUBIA VEL PROIN POSUERE VEHICULA LAOREET CRAS SEMPER MAXIMUS FINIBUS" );
}
