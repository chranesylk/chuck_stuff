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


while (true)
{
    <<<kickName>>>;
    <<< data[0], data[1], data[2] >>>;
    0 => kick.pos;
    0.2 => kick.gain;
    1=>kick.rate;
    
    1::second => now;
}

