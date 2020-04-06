public class Recording {
    public void record(string filename, DoneEvent e) {
        dac => WvOut w => blackhole;
        filename => w.wavFilename;
        <<<"writing to: ", w.filename()>>>;
        null @=> w;
        e => now;
    }
}
