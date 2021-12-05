import math
import struct

import numpy as np
import pyaudio

from services.config import (
    CHUNK_SIZE,
    DEVICE_INDEX,
    PA_CHANNELS,
    PA_FORMAT,
    SAMPLE_RATE,
)


def detect_volume():
    def rms(data):
        count = len(data) / 2
        v_format = f"{int(count)}h"
        shorts = struct.unpack(v_format, data)
        sum_squares = 0.0
        for sample in shorts:
            n = sample * (1.0 / 32768)
            sum_squares += n * n
        return math.sqrt(sum_squares / count)

    p = pyaudio.PyAudio()
    stream = p.open(
        format=PA_FORMAT,
        input_device_index=DEVICE_INDEX,
        channels=PA_CHANNELS,
        rate=SAMPLE_RATE,
        input=True,
        frames_per_buffer=CHUNK_SIZE,
    )

    for _ in range(5):
        stream.read(CHUNK_SIZE)
    while True:
        data = parse_to_int16(stream.read(CHUNK_SIZE))
        result = rms(data)
        print("RMS: ", result)
        # if result > 0.04:
        if True:
            break
    stream.close()


def parse_to_int16(chunk):
    if PA_FORMAT == pyaudio.paFloat32:
        _chunk = np.frombuffer(chunk, dtype="<f4")
        _chunk = np.copy(_chunk)
        _chunk /= 1.414
        _chunk *= 32767
        _chunk = _chunk.astype(np.int16)
        return _chunk.tobytes()
    return chunk
