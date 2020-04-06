public class Kantil extends GamelanInstrument {
    ADSRKey key1;
    key1.init(0.9, 1.0, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(12000, 8000, 0.3, 0, 0, 1., 3.0);
    [a1] @=> Attack attacks [];

    [0.0,
    611.581,
    661.043,
    827.835,
    893.7948,
    1152.22,
    1232.011,
    1333.128,
    1663.032,
    1792.553,
    2295.512] @=> float scale [];

    tune(attacks, harmonics, scale);
}
