#! /usr/bin/python3
# Copyright (C) 2017 DataArt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import argparse
import numpy as np
import os
from scipy.io import wavfile
from audio.processor import WavProcessor
import json

parser = argparse.ArgumentParser(description='Read file and process audio')
parser.add_argument('wav_dir', type=str, help='Directory to be recursivly decended for samples.')
parser.add_argument('json_out', type=str, help='Output JSON file', default = 'results.json')

def process_dir(start_dir, out_file):
    
    f = open(out_file, 'w')
    results = []
    with WavProcessor() as proc:
        for dirpath, dirs, files in os.walk(start_dir):
            for filename in [f for f in files if f.lower().endswith('.wav')]:
                fname = os.path.join(dirpath,filename)
                result = process_file(fname, proc)
                results.append((fname,tuple(result)))
                print('%s %s' % (fname,result))
    print(json.dumps(results), file=f)
    f.close()

def process_file(wav_file, proc):
    sr, data = wavfile.read(wav_file)
    if data.dtype != np.int16:
        raise TypeError('Bad sample type: %r' % data.dtype)

    return proc.get_predictions(sr, data) or []


if __name__ == '__main__':
    args = parser.parse_args()
    process_dir(args.wav_dir, args.json_out)
