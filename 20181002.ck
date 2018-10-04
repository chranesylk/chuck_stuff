SerialIO serial;
string line;
string stringInts[3];
int data[3];

SerialIO.list() @=> string list[];
for( int i; i < list.cap(); i++ )
{
    chout <= i <= ": " <= list[i] <= IO.newline();
}
serial.open(0, SerialIO.B9600, SerialIO.ASCII);

fun void serialPoller(){
    while( true )
    {
        // Grab Serial data
        serial.onLine()=>now;
        serial.getLine()=>line;
        
        if( line$Object == null ) continue;
        
        0 => stringInts.size;
        
        // Line Parser
        if (RegEx.match("\\[([0-9]+),([0-9]+),([0-9]+)\\]", line , stringInts))
        {
            for( 1=>int i; i<stringInts.cap(); i++)  
            {
                // Convert string to Integer
                Std.atoi(stringInts[i])=>data[i-1];
            }
        }
    }
}

spork ~ serialPoller();



120 => int tempo;
[0.2,0.2,0.2,0.2,0.2,0.2,0.0,0.0,0.2,0.0,0.2,0.0,0.2,0.0,0.0,0.0] @=> float hihatPattern[];
[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0] @=> float snarePattern[];
[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0] @=> float clapPattern[];
[0.0,0.0,0.0,0.0] @=> float kickPattern[];

SndBuf kick => dac;
SndBuf snare => dac;
SndBuf hihat => dac;
SndBuf clap => dac;

me.dir() => string path;

"audio/kick1.wav" => string kickName;
"audio/snare1.wav" => string snareName;
"audio/hihat1.wav" => string hihatName;
"audio/clap1.wav" => string clapName;

BPM bpm; 

path + kickName => kickName;
path + snareName => snareName;
path + hihatName => hihatName;
path + clapName => clapName;

kickName => kick.read;
snareName => snare.read;
hihatName => hihat.read;
clapName => clap.read;

// COMPOSITION


while (true)
{
    //<<< data[0], data[1], data[2] >>>;
    
    for(0 => int i; i < hihatPattern.cap(); i++){
        data[0]/100.0 => hihatPattern[i];
        <<<data[0]/100.0>>>;
        bpm.GetSixteenth(tempo)::second => now;
        }
    for(0 => int i; i < hihatPattern.cap(); i++)
    {
        PlayBackSample(hihat,16, hihatPattern[i], 1);
    }
    
    
}

fun void PlayBackSample(SndBuf sample, int noteType, float gain, float rate)
{
    0 => sample.pos;
    gain => sample.gain;
    rate => sample.rate;
    //bpm.GetEighth(tempo) ::second => now;
    bpm.DynamicSet(noteType,tempo)::second => now;
}   
