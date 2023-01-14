import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.ERegUtils;

/*
A SLC (simplified lambda calculus) expression takes one of the two forms: varList or λvar.expr, where var is a lower-case letter from u to z, varList is a sequence of variables, and expr is either a var or another SLC expression.

EXAMPLES
λx.λy.xyz
λx.x
λy.yzxw
λw.λx.λy.λz.z

Your job is to determine which variables are bound, which are free, and which are neither.

A bound variable is a variable that is bound by a λ and occurs in its expression, e.g., λx.x, x is bound.

A free variable is a variable that is NOT bound by a λ but does occur in an expression, e.g., λy.λx.zwv, z, w, and v are free variables.

A variable that is neither free nor bound is a variable that is bound by a λ but does not occur in its expression, e.g., λx.λy.yz, x is neither free nor bound.

*/

function main() {

	final lambdaExpr = readline();

	print( process( lambdaExpr ));
}

function process( lambdaExpr:String ) {
	
	final lambdaVars = ~/λ([u-z])/.getMatches( lambdaExpr );
	final exprVars = ~/\.([u-z]+)/.getMatches( lambdaExpr )[0].split( "" );
	
	final listBound = [];
	final listFree = [];
	final listNeither = [];

	for( v in lambdaVars ) if( exprVars.contains( v )) listBound.push( v );
	for( v in exprVars ) if( !lambdaVars.contains( v )) listFree.push( v );
	for( v in lambdaVars ) if( !exprVars.contains( v )) listNeither.push( v );

	final outputBound = listBound.length == 0 ? "NONE" : listBound.join(" ");
	final outputFree = listFree.length == 0 ? "NONE" : listFree.join(" ");
	final outputNeither = listNeither.length == 0 ? "NONE" : listNeither.join(" ");

	return '$outputBound\n$outputFree\n$outputNeither';
}
