//Run this first
public class BPM
{
    
   public float GetQuater(float bpm)
   {
        return 60.0/bpm;
        
   }
    
   public float GetEighth(float bpm)
   {
        return 60.0 * 0.5/bpm;
        
   }
   
   public float GetSixteenth(float bpm)
   {
        return 60.0 * 0.25/bpm;
        
   }
   
   public float DynamicSet(int noteType, float bpm){
        if(noteType == 4){
            return GetQuater(bpm);
            }
        else if(noteType == 8){
            return GetEighth(bpm);
            }
        else if(noteType == 16){
            return GetSixteenth(bpm);
            
            }
        else{
            return 10000.0;
            
            }
     
        }
     
     
     
     }