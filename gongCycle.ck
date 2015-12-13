2.4 => float TEMPO;

if (me.args())
{
	(Std.atof(me.arg(0)) / 1000.0 + 0.25) * 4=> TEMPO;
}

Gamelan gam;
gam.connect(dac);

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
