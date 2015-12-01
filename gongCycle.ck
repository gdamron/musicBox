2.4 => float TEMPO;

//intialize reverb
NRev r => Pan2 p => dac;
.1 => r.mix;
	
if (me.args())
{
	Std.atof(me.arg(0)) => TEMPO;
}

// CREATE INSTRUMENTS AND ARRAY TO HOLD THEIR NAMES
// Create GAMELAN object
Gamelan gam;
gam.connect(r);

0 => int index;
TEMPO => float duration;
0.6 => float amp;

while (true) {

	if (index == 0) gam.gong(amp, duration);
	else if (index == 1) gam.kenpur(amp, duration);
	else if (index == 2) gam.klentong(amp, duration);
	else if (index == 3) gam.kenpur(amp, duration);

	duration::second + 1::ms => now;

	index++;
	if (index > 3) {
		index - 4 => index;
	}
}