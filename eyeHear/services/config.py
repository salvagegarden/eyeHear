import pyaudio

# Audio recording parameters
PA_FORMAT = pyaudio.paFloat32
PA_CHANNELS = 1
STREAMING_LIMIT = 240000  # 4 minutes
SAMPLE_RATE = 48000
CHUNK_SIZE = 4800
# SAMPLE_RATE = 48000
# CHUNK_SIZE = 4096  # int(SAMPLE_RATE / 10)  # 100ms
DEVICE_INDEX = 1  # None
