public class Jublag extends GamelanInstrument {
    ADSRKey key1;
    key1.init(1.0, 0.75, 0.001, 0.001, 0.6, 0.998);
    [key1] @=> ADSRKey harmonics [];

    Attack a1;
    a1.init(4000, 1000, 0.4, 0.5, 0.5, 0.25, 1.0);
    [a1] @=> Attack attacks [];

    [0.0,
     283.303,
     303.089,
     326.876,
     417.606,
     452.323] @=> float scale [];

    tune(attacks, harmonics, scale);
}
