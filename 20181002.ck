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
//[0.2,0.2,0.2,0.2,0.2,0.2,0.0,0.0,0.2,0.0,0.2,0.0,0.2,0.0,0.0,0.0] @=> float hihatPattern[];
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



path + kickName => kickName;
path + snareName => snareName;
path + hihatName => hihatName;
path + clapName => clapName;

kickName => kick.read;
snareName => snare.read;
hihatName => hihat.read;
clapName => clap.read;

// COMPOSITION


/*while (true)
{
    //<<< data[0], data[1], data[2] >>>;
    //Update Sequence with income data
    
    //UpdateSequence(kickPattern, 4, data[1]);
    //UpdateSequence(snarePattern, 8, data[2]);
    //UpdateSequence(clapPattern, 8, data[3]);
    

    
    
}*/


//spork~PlayBackSample(kick,4,data[1],1 );
//UpdateSequence(hihatPattern, 16, data[0]);
//PlaySequence(hihat,hihatPattern);

/*fun void UpdateSequence(float pattern[], int noteType, int incomeData)
{
    for(0 => int i; i < pattern.cap(); i++){
        incomeData/100.0 => pattern[i];
        <<<data[0]/100.0>>>;
        bpm.DynamicSet(noteType,tempo)::second => now;
    }    
    
}*/

fun void PlaySequence(SndBuf sample, float pattern[])
{
        //Playback samples based on the sequence
    for(0 => int i; i < pattern.cap(); i++)
    {
        PlayBackSample(sample,pattern.cap(), pattern[i], 1);
    }
    
}

fun void PlayBackSample(SndBuf sample, int noteType, float gain, float rate)
{
    BPM bpm; 
    120 => int tempo;
    while(true){
        0 => sample.pos;
        data[0]/100.0 => sample.gain;
        rate => sample.rate;
        <<<data[0]/100.0>>>;
        //bpm.GetEighth(tempo) ::second => now;
        bpm.DynamicSet(noteType,tempo)::second => now;
    }
}   


spork~PlayBackSample(hihat,16,data[0],1 );
spork~PlayBackSample(kick,4,data[1],1 );
while(true) 1::second => now;
