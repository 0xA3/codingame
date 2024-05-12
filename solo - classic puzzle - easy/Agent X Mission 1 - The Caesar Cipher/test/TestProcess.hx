package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test CaesarShift", {
			it( "awx!, AW~  key 3", Main.caesarShift( "awx!, AW~", 3 ).should.be( "dz{$/#DZ\"" ));
			it( "dz{$/#DZ\" key -3", Main.caesarShift( "dz{$/#DZ\"", -3 ).should.be( "awx!, AW~" ));
		});

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.ciphertext, ip.word ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.ciphertext, ip.word ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.ciphertext, ip.word ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.ciphertext, ip.word ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.ciphertext, ip.word ).should.be( test5Result );
			});
			it( "Word in start", {
				final ip = wordInStart;
				Main.process( ip.ciphertext, ip.word ).should.be( wordInStartResult );
			});
			it( "Some interference (Word in middle)", {
				final ip = someInterference;
				Main.process( ip.ciphertext, ip.word ).should.be( someInterferenceResult );
			});
			it( "Word in the end", {
				final ip = wordInTheEnd;
				Main.process( ip.ciphertext, ip.word ).should.be( wordInTheEndResult );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.ciphertext, ip.word ).should.be( test9Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
			
		return { ciphertext: lines[0], word: lines[1] };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"Whvw/#whvw/#khoor$
		test" );

	final test1Result = parseResult(
		"3
		Test, test, hello!" );
	
	final test2 = parseInput(
		"!WO9FLWLOGWH9KKW9FWAEHGJL9FLWE=KK9?=
		pass" );

	final test2Result = parseResult(
		"55
		I want two pass an important message" );
	
	final test3 = parseInput( readFile( "test/Test_3_input.txt" ));
	
	final test3Result = parseResult(
		"8
		i receive you, have you found the traces of agent X." );
	
	final test4 = parseInput( readFile( "test/Test_4_input.txt" ));
	
	final test4Result = parseResult(
		"32
		Yes, I found this trace, I think it's almost the end for him, what's the idea of getting mixed up with us?" );
	
	final test5 = parseInput( readFile( "test/Test_5_input.txt" ));
	
	final test5Result = parseResult(
		"77
		I've found him, prepare him for capture, we need him alive, he holds information too important to die for, to all units, go!" );
	
	final wordInStart = parseInput(
		"vM6/D3MB63M7;>@3AA7=<MB6/BM1=;;C<71/B7=<M7AM<=M:=<53@M>=AA70:3M/<2MvT;M/4@/72MvME=<TBM03M/0:3MB=M1=;;C<71/B3M4=@MB63MB7;3M037<5[
		have" );
	
	final wordInStartResult = parseResult(
		"45
		I have the impression that communication is no longer possible and I'm afraid I won't be able to communicate for the time being." );
	
	final someInterference = parseInput( readFile( "test/Some_Interference_input.txt" ));
	
	final someInterferenceResult = parseResult(
		"49
		YbaSyME.snYoyUKyv;ZolVXNc fXWNFsIEb:OFceiTeklE?hQzELyLIv,UJEqRaR:yaYQeWwDZS:ONwbZsw.hSzxhYYCC:koOjJOtM,fPCloiTL NrvzLZZaVY;LxwcCCP!bCSpNaKz!tVtqCHiq:iQPPtDLT.khuEmNP;HNuvWSmP lbHNMaut,jXQNnFvDnX:RWJJzhHjf.aThyTXJ,TLlZZUKhdR.IYILMTVbW;qbkFYwShEu:rwlDOxJHK:hrMVYJSM;QczTWPPBqZ;jLrnBwZGU,HbYSEDhrgG!UcZswHL,xcdGBQG QAxLHGyExb.leDiprFptN?kojiqzFpe,KdsjGYap:nwPxWgAj,ZdtMIUd:WngOFdhI,okvUJUCgyL.LPDVJya?zWEnjbBlH,utBtaVi!BCSDekY:SGGawMwKTT.HIfoDhAGp!ZSwhjdZcL?GstkBmJz.PTIsnzq,BxHysQq!mtjYjMr;JWdUQynrt?KfAUmNXJzv?XRCtwJS XAAAhoXlNC GsthiwISj;OjOjkpEh,YXHyAIN juxPMzzR;TlVrsKHTIG DALOpYLEhs;UZQRGkAWW?HPTzdoHEGx.JinptLSd,nfSvPNxx fDwRRmQsN.HEMqjrgu;neuidGFAY!smKxIVkUEY?aaQFSVHMnE:ufXsggQP?HLgjrBr:nZeCKrP?oHIUtRs;LWtolvDiLH!tharBpKSGD;JzAwJYjEdI,AKFgheesKw:XOnUrVlx,UlajMtC.OWBCIieSq?xgxiEsHBLa?pmYjkIo,FgZGtsjjHQ,DsjWDCAXo:zJTIaphoG?JeQhTASsi:tFfBshkO?PJsAEWBOcf,FWduuKH!TeYeVyksCl:LgiAtlfn SUFdJnqYz!HggxNxwVT;pTSQPMReL,zDBedkni!AhobtzsSN!LsMMLHXfbX;NEqvnMJ" );
	
	final wordInTheEnd = parseInput( readFile( "test/Word_in_the_end_input.txt" ));
	
	final wordInTheEndResult = parseResult(
		"71
		I'm hearing interference and I'm afraid we're no longer communicating. In any case, if you hear me, don't abandon the mission, continue whatever the cost." );
	
	final test9 = parseInput(
		"?eclr}V}f_b}rm}osgaijw}dglb}amtcp}`cfglb}_}j_pec}ngjj_p}_q}esldgpc}cpsnrcb}_pmslb}fgk,}Fc}bcqapg`cb}fgq}qsppmslbgleq}rm}fc_bos_prcpq}gl}_}fsqfcb}rmlc*}lmrgle}rfc}a_lbjcfmjbcp}ml}rfc}_bh_aclr}r_`jc}_q}_}nmrclrg_j}k_icqfgdr}uc_nml,
		had" );
	
	final test9Result = parseResult(
		"93
		Agent X had to quickly find cover behind a large pillar as gunfire erupted around him. He described his surroundings to headquarters in a hushed tone, noting the candleholder on the adjacent table as a potential makeshift weapon." );
}
