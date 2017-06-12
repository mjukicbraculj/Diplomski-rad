import os
import librosa
import dtw
import numpy
import math
import time
import fastdtw
from scipy.spatial.distance import euclidean

words = ["nula", "jedan", "dva", "tri", "cetiri", "pet", "sest", "sedam", "osam", "devet", "plus", "minus", "puta", "dijeljeno", "jednako"]
training_data_url = "C:/Users/Mira/Documents/DIPLOMSKI RAD - ALGORITAM PORAVNANJA VREMENSKIH NIZOVA/speach-recognition/Dataset/Train/average_mfcss_with_centroid"
test_data_url = "C:/Users/Mira/Documents/DIPLOMSKI RAD - ALGORITAM PORAVNANJA VREMENSKIH NIZOVA/speach-recognition/Dataset/Test/mira/"


def load_mfcss(path):
    f = open(path, 'r')
    data = [list(map(float, line.split(' '))) for line in f]
    return data


def main():
    shots = 0
    test_files = [f for f in os.listdir(test_data_url)]
    train_files = [f for f in os.listdir(training_data_url)]
    start = time.time()
    for test_file in test_files:
        test_data, test_sampling_rate = librosa.load(test_data_url + "/" + test_file)
        test_mfcc = librosa.feature.mfcc(test_data, test_sampling_rate, n_mfcc=13).T
        min_dtw_distance = math.inf

        for train_subfile in train_files:
            train_mfccs = load_mfcss(training_data_url+ "/" + train_subfile)
            # dtw_distance, path = fastdtw.fastdtw(test_mfcc, numpy.array(train_mfccs).T,
            #                                      dist=euclidean)
            dtw_distance, _, _, _ = dtw.dtw(test_mfcc, numpy.array(train_mfccs).T,
                                            dist=lambda x, y: numpy.linalg.norm(x - y, ord=1))
            if min_dtw_distance > dtw_distance:
                min_dtw_distance = dtw_distance
                min_dtw_distance_file_name = train_subfile

        train_word = (min_dtw_distance_file_name.split("_"))[0]
        test_word = (test_file.split("_"))[0]
        print(train_word, test_word)
        if train_word == test_word:
            shots += 1
    end = time.time()
    print("Number of correct predicted: ", shots/len(test_files))
    print("Elapsed time: ", end - start)

if __name__ == "__main__":
    main()