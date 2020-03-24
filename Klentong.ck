public class Klentong extends GamelanInstrument {
    ADSRKey key1, key2;
    key1.init(1.0, 1.0, 0.001, 0.001, 0.6, 0.998);
    key1.init(0.05, 2.3, 0.001, 0.001, 0.025, 0.45);
    [key1, key2] @=> ADSRKey harmonics [];

    16 => float FullDecay;

    Attack attack;
    attack.init(6000, 4000, 0.2, 0.0, 0.0, 1.0, 3.0);
    [attack] @=> Attack attacks [];

    [205.4] @=> float scale [];

    tune(attacks, harmonics, scale);

    private dur strike(float amp, float duration) {
        Math.pow(amp, amp + 1) => float ampScale;
        FullDecay * ampScale => float fullDecay;
        duration::second => dur strikeDur;

        strike(0, amp, fullDecay);

        return strikeDur - Attack.StrikeTick;
    }
}
