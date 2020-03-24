public class Ugal extends GamelanInstrument {
    ADSRKey key1;
    key1.init(1.0, 1.0, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(8000, 1000, 04, 0.5, 0.5, 1., 2.0);
    [a1] @=> Attack attacks [];

    [0.0,
     305.96,
     328.147,
     418.07,
     451.13,
     571.338,
     611.92,
     662.878,
     827.531,
     885.9,
     1150.304] @=> float scale [];

    tune(attacks, harmonics, scale);
}
