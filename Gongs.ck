public class Gongs {
    Gong gng;
    Klentong tong;

    public void connect(UGen u) {
        gng.connect(u);
        tong.connect(u);
    }
    public dur gong(float amp, float duration) {
        return gng.gong(amp, duration);
    }

    public dur kenpur(float amp, float duration) {
        return gng.kenpur(amp, duration);
    }

    public dur klentong(float amp, float duration) {
        return tong.strike(amp, duration);
    }
}
