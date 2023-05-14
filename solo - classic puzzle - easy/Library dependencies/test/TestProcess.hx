package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "1. Successful compilation", {
				final ip = successfulCompilation;
				Main.process( ip.imports, ip.dependencies ).should.be( successfulCompilationResult );
			});
			it( "2. Fatal error", {
				final ip = fatalError;
				Main.process( ip.imports, ip.dependencies ).should.be( fatalErrorResult );
			});
			it( "3. Reordering", {
				final ip = reordering;
				Main.process( ip.imports, ip.dependencies ).should.be( reorderingResult );
			});
			it( "4. Reordering logic", {
				final ip = reorderingLogic;
				Main.process( ip.imports, ip.dependencies ).should.be( reorderingLogicResult );
			});
			it( "5. Not lexicographic order but no error", {
				final ip = notLexographicOrderButNoError;
				Main.process( ip.imports, ip.dependencies ).should.be( notLexographicOrderButNoErrorResult );
			});
			it( "6. Real fake test 15 libraries 1", {
				final ip = realFakeTest15Libraries1;
				Main.process( ip.imports, ip.dependencies ).should.be( realFakeTest15Libraries1Result );
			});
			it( "7. Real fake test 15 libraries 2 (fatal)", {
				final ip = realFakeTest15Libraries2;
				Main.process( ip.imports, ip.dependencies ).should.be( realFakeTest15Libraries2Result );
			});
			it( "8. Real fake test 15 libraries 3 (compiles)", {
				final ip = realFakeTest15Libraries3;
				Main.process( ip.imports, ip.dependencies ).should.be( realFakeTest15Libraries3Result );
			});
			it( "9. 40 libraries", {
				final ip = _40Libraries;
				Main.process( ip.imports, ip.dependencies ).should.be( _40LibrariesResult );
			});
			it( "10. Max size in codingame", {
				final ip = maxSizeInCodinGame;
				Main.process( ip.imports, ip.dependencies ).should.be( maxSizeInCodinGameResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final nImp = parseInt( lines[0]);
		final imports = [for( i in 0...nImp ) lines[i + 1]];
		
		final nDep = parseInt( lines[nImp + 1]);
		final dependencies = [for( i in 0...nDep ) lines[nImp + i + 2]];
			
		return { imports: imports, dependencies: dependencies };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final successfulCompilation = parseInput(
		"3
		import A
		import B
		import C
		2
		B requires A
		C requires B" );

	final successfulCompilationResult = parseResult(
		"Compiled successfully!" );

	final fatalError = parseInput(
		"3
		import A
		import B
		import C
		3
		B requires A
		C requires B
		A requires C" );

	final fatalErrorResult = parseResult(
		"Import error: tried to import A but C is required.
		Fatal error: interdependencies." );

	final reordering = parseInput(
		"4
		import A
		import C
		import B
		import D
		2
		C requires B, A
		D requires B" );

	final reorderingResult = parseResult(
		"Import error: tried to import C but B is required.
		Suggest to change import order:
		import A
		import B
		import C
		import D" );

	final reorderingLogic = parseInput(
		"6
		import F
		import A
		import B
		import C
		import E
		import D
		2
		B requires E
		C requires A" );

	final reorderingLogicResult = parseResult(
		"Import error: tried to import B but E is required.
		Suggest to change import order:
		import A
		import C
		import D
		import E
		import B
		import F" );

	final notLexographicOrderButNoError = parseInput(
		"3
		import C
		import A
		import B
		1
		B requires A" );

	final notLexographicOrderButNoErrorResult = parseResult(
		"Compiled successfully!" );

	final realFakeTest15Libraries1 = parseInput(
		"15
		import requests
		import itertools
		import random
		import functools
		import inspect
		import sys
		import collections
		import builtins
		import pandas
		import unittest
		import contextlib
		import os
		import time
		import math
		import numpy
		10
		math requires requests
		inspect requires contextlib, os
		time requires collections, sys
		contextlib requires sys, os
		numpy requires os, requests, itertools
		pandas requires unittest
		itertools requires random, inspect, contextlib
		functools requires inspect
		builtins requires math
		unittest requires contextlib" );

	final realFakeTest15Libraries1Result = parseResult(
		"Import error: tried to import itertools but random is required.
		Suggest to change import order:
		import collections
		import os
		import random
		import requests
		import math
		import builtins
		import sys
		import contextlib
		import inspect
		import functools
		import itertools
		import numpy
		import time
		import unittest
		import pandas" );

	final realFakeTest15Libraries2 = parseInput(
		"15
		import sys
		import pandas
		import os
		import unittest
		import numpy
		import collections
		import time
		import inspect
		import requests
		import functools
		import math
		import builtins
		import random
		import contextlib
		import itertools
		9
		math requires functools
		inspect requires numpy
		time requires requests
		random requires itertools
		functools requires requests
		collections requires os
		builtins requires functools
		requests requires time
		unittest requires numpy" );

	final realFakeTest15Libraries2Result = parseResult(
		"Import error: tried to import unittest but numpy is required.
		Fatal error: interdependencies." );

	final realFakeTest15Libraries3 = parseInput(
		"15
		import collections
		import os
		import random
		import requests
		import math
		import builtins
		import sys
		import contextlib
		import inspect
		import functools
		import itertools
		import numpy
		import time
		import unittest
		import pandas
		10
		math requires requests
		inspect requires contextlib, os
		time requires collections, sys
		contextlib requires sys, os
		numpy requires os, requests, itertools
		pandas requires unittest
		itertools requires random, inspect, contextlib
		functools requires inspect
		builtins requires math
		unittest requires contextlib" );

	final realFakeTest15Libraries3Result = parseResult(
		"Compiled successfully!" );

	final _40Libraries = parseInput(
		"40
		import T
		import S
		import W
		import E
		import L
		import BF
		import I
		import BB
		import O
		import U
		import M
		import BA
		import BJ
		import BH
		import K
		import BK
		import N
		import C
		import BN
		import D
		import BE
		import BL
		import P
		import Z
		import R
		import J
		import A
		import H
		import F
		import BC
		import V
		import Q
		import Y
		import BM
		import B
		import BD
		import BI
		import G
		import BG
		import X
		24
		A requires N, Q
		C requires W, Y
		D requires BN, H, BE
		E requires BE, L, BF
		F requires L
		G requires BG, A
		H requires BC, Y
		I requires F, V
		J requires BJ, BH, G
		K requires X, BN, A
		M requires BB, BA
		N requires BA
		O requires J
		Q requires BH
		V requires BK, L
		W requires BA, X
		X requires P, BH
		Y requires U, J, G
		Z requires P
		BB requires Z, D, BF
		BD requires P, B
		BI requires X, I
		BL requires A, G, BE
		BM requires N" );

	final _40LibrariesResult = parseResult(
		"Import error: tried to import W but BA is required.
		Suggest to change import order:
		import B
		import BA
		import BC
		import BE
		import BF
		import BG
		import BH
		import BJ
		import BK
		import BN
		import L
		import E
		import F
		import N
		import BM
		import P
		import BD
		import Q
		import A
		import G
		import BL
		import J
		import O
		import R
		import S
		import T
		import U
		import V
		import I
		import X
		import BI
		import K
		import W
		import Y
		import C
		import H
		import D
		import Z
		import BB
		import M" );
	
	final maxSizeInCodinGame = parseInput(
		"93
		import BV
		import BE
		import Q
		import X
		import CW
		import DF
		import BJ
		import H
		import CS
		import BS
		import BG
		import BW
		import D
		import CF
		import U
		import DD
		import CC
		import BO
		import BR
		import BY
		import CJ
		import F
		import DH
		import R
		import CT
		import BH
		import CX
		import CY
		import BM
		import DC
		import DM
		import BU
		import CN
		import DA
		import M
		import O
		import BF
		import CU
		import CQ
		import CE
		import BK
		import DK
		import V
		import CA
		import BX
		import CH
		import W
		import CI
		import C
		import CZ
		import K
		import CV
		import CK
		import S
		import BI
		import CR
		import BA
		import J
		import DJ
		import L
		import DB
		import BP
		import N
		import CD
		import BT
		import CM
		import BQ
		import I
		import Z
		import E
		import DO
		import B
		import CL
		import DL
		import G
		import P
		import BB
		import DI
		import BN
		import CG
		import DE
		import Y
		import BD
		import DG
		import CP
		import T
		import DN
		import CB
		import BC
		import BZ
		import BL
		import A
		import CO
		66
		A requires BW, Z, CA
		B requires BD
		C requires DD, BM, CL
		D requires CV, DJ, BD
		G requires BO
		H requires B
		I requires DC, F, BH
		J requires DI, A
		K requires DB, E, CY
		L requires CM
		M requires DD, BT, DL
		O requires DM, Q
		P requires L, BD, BT
		Q requires L, CU, CO
		R requires BI, CW
		S requires DK, BN
		T requires BI, F, CC
		U requires BH, T, BZ
		V requires DI, Q
		W requires BT, CT, DB
		X requires CD, BO, BM
		Z requires BY, CS
		BA requires BB
		BB requires CH, L
		BC requires CO, BV
		BG requires CI, CA
		BH requires DG, BB
		BI requires BJ
		BJ requires CK, BH, CQ
		BK requires BW, CI, DL
		BL requires Y, DE
		BN requires DF, CI, Y
		BO requires CE
		BP requires CI
		BQ requires CA, CT
		BS requires CU
		BU requires BR, Z, CD
		CA requires E, BZ
		CB requires BD, E, Q
		CC requires CM
		CD requires BH, A
		CF requires DO, BJ
		CG requires O, BX, BO
		CH requires J
		CL requires BA, Z, D
		CM requires DD, DE, CJ
		CN requires BH
		CO requires BR
		CQ requires O
		CR requires BV, DE, DA
		CT requires Z
		CU requires BV
		CV requires DM
		CW requires CA
		CY requires DI, BX, Z
		CZ requires DO, CU, F
		DB requires BU, CZ, R
		DD requires BZ
		DE requires N, CW
		DF requires M, BF
		DG requires CU, DK, DM
		DH requires DN, BK
		DI requires Z
		DJ requires CF, W
		DK requires F, CE, BE
		DO requires CQ" );

	final maxSizeInCodinGameResult = parseResult(
		"Import error: tried to import Q but L is required.
		Suggest to change import order:
		import BD
		import B
		import BE
		import BF
		import BM
		import BR
		import BT
		import BV
		import BW
		import BX
		import BY
		import BZ
		import CE
		import BO
		import CI
		import BP
		import CJ
		import CK
		import CO
		import BC
		import CP
		import CS
		import CU
		import BS
		import CX
		import DA
		import DC
		import DD
		import DL
		import BK
		import DM
		import CV
		import DN
		import DH
		import E
		import CA
		import BG
		import CW
		import F
		import DK
		import DG
		import G
		import H
		import M
		import DF
		import N
		import DE
		import CM
		import CC
		import CR
		import L
		import P
		import Q
		import CB
		import O
		import CG
		import CQ
		import DO
		import CZ
		import Y
		import BL
		import BN
		import S
		import Z
		import A
		import CT
		import BQ
		import DI
		import CY
		import J
		import CH
		import BB
		import BA
		import BH
		import BJ
		import BI
		import CD
		import BU
		import CF
		import CN
		import I
		import R
		import DB
		import K
		import T
		import U
		import V
		import W
		import DJ
		import D
		import CL
		import C
		import X" );
}
