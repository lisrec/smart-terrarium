import os
from subprocess import run
from threading import Thread
from flask import Flask, Response
import RPi.GPIO as GPIO

app = Flask(__name__)

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(21, GPIO.OUT)
GPIO.cleanup()

def clear_music():
    os.system("killall aplay")

def _music_thread():
    run(["aplay", "/home/admin/music.wav"])

def play_music():
    clear_music()
    process = Thread(target=_music_thread, daemon=True)
    process.start()

@app.route("/")
def home():
    return Response(status=200)

@app.route("/start")
def start():
    play_music()
    return Response(status=200)

@app.route("/stop")
def stop():
    clear_music()
    return Response(status=200)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')