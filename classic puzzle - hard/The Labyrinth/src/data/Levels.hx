package data;

using StringTools;

function parseLevel( level:String ) return level.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

final l0 = parseLevel(
"######
#T..C#
######" );

final l1 = parseLevel(
"##############################
##############################
##############################
##############################
##############################
##############################
#####T......C#################
##############################
##############################
##############################
##############################
##############################
##############################
##############################
##############################" );
