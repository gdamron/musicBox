2.4 => float TEMPO;
0.0 => float ELAPSED;
180 => float DURATION;
0 => int cycle;
1.0 => float gainVal;

if (me.args())
{
	(Std.atof(me.arg(0)) / 1000.0 + 0.25) * 4=> TEMPO;
}

TEMPO < 0.5 => int isFast;

Gamelan gam;
Gain g => dac;
gam.connect(g);
gainVal => g.gain;

0 => int index;
TEMPO => float duration;
0.6 => float amp;

while (ELAPSED < DURATION) {

	if (index == 0) gam.gong(amp, duration);
	else if (index == 1) gam.kenpur(amp, duration);
	else if (index == 2) gam.klentong(amp, duration);
	else if (index == 3) gam.kenpur(amp, duration);

	duration +=> ELAPSED;
	duration::second + 1::ms => now;

	index++;
	if (index > 3) {
		index - 4 => index;
	}

	if (ELAPSED > 60 && gainVal > 0) {
		0.025 -=> gainVal;
		gainVal => g.gain;
	}
}
