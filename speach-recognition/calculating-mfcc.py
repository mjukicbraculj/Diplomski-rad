import os
import librosa

def main():
    words = ["nula", "jedan", "dva", "tri", "cetiri", "pet", "sest", "sedam", "osam", "devet", "plus", "minus", "puta", "dijeljeno", "jednako"]
    for word in words:
        directory = os.getcwd() + '/Dataset/Train/' + word + "/"
        files = [f for f in os.listdir(directory)]
        print(files, directory)
        for file in files:
            if file.endswith(".wav"):
                data, sampling_rate = librosa.load(directory + file)
                mfcc = librosa.feature.mfcc(data, sampling_rate, n_mfcc=13)
                new_file_name = directory + os.path.splitext(file)[0] + '.txt'
                print(new_file_name)
                new_file = open(new_file_name, 'w')
                for i in range(len(mfcc)):
                    for j in range(len(mfcc[i])):
                        if j is not 0:
                            new_file.write(" " + str(mfcc[i][j]))
                        else:
                            new_file.write(str(mfcc[i][j]))
                    new_file.write('\n')

if __name__ == '__main__':
    main()