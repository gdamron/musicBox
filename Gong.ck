public class Gong extends GamelanInstrument {
    ADSRKey key1;
    key1.init(1.0, 1.0, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    24.0 => float FullDecay;

    Attack attack;
    attack.init(0, 0, 0.0, 0, 0, 0.0, 1.0);
    [attack] @=> Attack attacks [];

    [114.66, 152.72] @=> float scale [];

    tune(attacks, harmonics, scale);

    public dur gong(float amp, float duration) {
        return strikeGong(0, amp, duration);
    }

    public dur kenpur(float amp, float duration) {
        return strikeGong(1, amp, duration);
    }

    private dur strikeGong(int degree, float amp, float duration) {
        Math.pow(amp, amp + 1) => float ampScale;
        FullDecay * ampScale => float fullDecay;
        duration::second => dur strikeDur;
        strike(degree, amp, fullDecay);

        return strikeDur - Attack.StrikeTick;

    }
}
