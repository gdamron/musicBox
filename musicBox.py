import subprocess
import pygame
from random import randint

def random_ints():
    arr_len = (randint(0, 4) + 1) * 16
    random_ints = []
    for _ in range(arr_len):
        random_ints.append(randint(0, 10))
    return random_ints

def play_gamelan():
    melody = ":".join(str(x) for x in random_ints())
    duration = randint(0, 1000)
    print('base duration: {duration}'.format(duration=duration))
    print('melody: {melody}'.format(melody=melody))

    # run this:
    chuck = ["chuck",
             "--silent",
             "Gamelan.ck",
             "gongCycle.ck:{dur}".format(dur=duration),
             "play.ck:0:{dur}:{mel}".format(mel=melody, dur=duration),
             "play.ck:1:{dur}:{mel}".format(mel=melody, dur=duration),
             "play.ck:2:{dur}:{mel}".format(mel=melody, dur=duration),
             "play.ck:3:{dur}:{mel}".format(mel=melody, dur=duration),
             "play.ck:4:{dur}:{mel}".format(mel=melody, dur=duration),
             "play.ck:5:{dur}:{mel}".format(mel=melody, dur=duration),
             "record.ck:output/musicBox.wav"]

    print(" ".join(chuck))
    subprocess.call(chuck)
    #then play output
    wav = pygame.mixer.Sound("./output/musicBox.wav");
    wav.play()

    while pygame.mixer.get_busy():
        pygame.time.delay(100)


def start():
    pygame.init()
    pygame.mixer.init()

start()
play_gamelan()
