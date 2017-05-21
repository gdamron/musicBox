me.arg(0) => string filename;

dac => WvOut w => blackhole;
filename => w.wavFilename;
<<<"writing to: ", w.filename()>>>;
null @=> w;
0 => int elapsed;

while (elapsed < 180) {
    1::second => now;
    1 +=> elapsed;
}

