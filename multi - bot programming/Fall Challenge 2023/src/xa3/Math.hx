package xa3;

import Math.round;

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

function center( v1:Int, v2:Int ) return round(( v2 - v1 ) / 2 + v1 );