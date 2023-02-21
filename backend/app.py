import os
import atexit
from subprocess import run
from threading import Thread
from flask import Flask, Response, jsonify
import RPi.GPIO as GPIO

# Create Flas app
app = Flask(__name__)

# Server state
music_playing = False

# Initialize GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)

# Clean up before close app
def OnExitApp():
    GPIO.cleanup()

atexit.register(OnExitApp)

def server_shutdown():
    os.system("shutdown +1")
    GPIO.cleanup()
    raise RuntimeError("Server going down")


def clear_music():
    os.system("pkill -9 play_infinity")
    os.system("killall aplay")
    global music_playing
    music_playing = False

def _music_thread():
    run(["/home/admin/smart-terrarium/music/play_infinity.sh"])

def play_music():
    clear_music()
    process = Thread(target=_music_thread, daemon=True)
    process.start()
    global music_playing
    music_playing = True


@app.get("/music")
def get_music():
    global music_playing
    return jsonify(
        isPlaying = music_playing
    )

@app.post("/music/start")
def start():
    play_music()
    return Response(status=200)

@app.post("/music/stop")
def stop():
    clear_music()
    return Response(status=200)

@app.post("/server/shutdown")
def shutdown():
    server_shutdown()
    return Response(status=200)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')