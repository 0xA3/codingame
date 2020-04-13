package ooc;

import ooc.ExecuteAction;
import ooc.ChargeAction;

enum PowerAction {
	Charge( c:ChargeAction );
	Execute( e:ExecuteAction );
}