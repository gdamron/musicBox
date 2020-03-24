public class Calun extends GamelanInstrument {
    ADSRKey key1;
    key1.init(1.0, 0.75, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(6000, 1000, 0.4, 0.5, 0.5, 1., 1.0);
    [a1] @=> Attack attacks [];

    [0.0,
     212.306,
     226.191,
     285.669,
     307.661,
     331.623,
     414.006,
     449.881] @=> float scale [];

    tune(attacks, harmonics, scale);
}
