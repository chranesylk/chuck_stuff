SndBuf kick => dac;
SndBuf snare => dac;
SndBuf hihat => dac;
SndBuf clap => dac;

me.dir() => string path;

"/audio/kick1.wav" => string kickName;
"/audio/snare1.wav" => string snareName;
"/audio/hihat1.wav" => string hihatName;
"/audio/clap1.wav" => string clapName;

path + kickName => kickName;
path + snareName => snareName;
path + hihatName => hihatName;
path + clapName => clapName;

kickName => kick.read;
snareName => snare.read;
hihatName => hihat.read;
clapName => clap.read;