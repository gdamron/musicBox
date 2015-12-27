2.4 => float TEMPO;
0.0 => float ELAPSED;
180 => float DURATION;
0 => int cycle;
1.0 => float gainVal;

if (me.args())
{
	(Std.atof(me.arg(0)) / 1000.0 + 0.25) * 4=> TEMPO;
}

TEMPO < 2.0 => int isFast;

Gamelan gam;
gam.connect(dac);

0 => int index;
TEMPO => float duration;
0.6 => float amp;

while (ELAPSED < DURATION) {

	if (index == 0) gam.gong(amp * gainVal, duration);
	else if (index == 1) gam.kenpur(amp * gainVal, duration);
	else if (index == 2) gam.klentong(amp * gainVal, duration);
	else if (index == 3) gam.kenpur(amp * gainVal, duration);

	duration +=> ELAPSED;
	duration::second + 1::ms => now;

	index++;
	if (index > 3) {
		index - 4 => index;

		1 +=> cycle;
		if (cycle%8==0 && isFast) {
			2 *=> TEMPO;
			false => isFast;
		} else if (cycle%4==0 && !isFast) { 
			2 /=> TEMPO;
			true => isFast;
		}
	}

	if (ELAPSED > 60 && gainVal > 0) {
		0.05 -=> gainVal;
	}
}
