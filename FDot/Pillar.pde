class PillarColumn{
    float xPos, opening;
    boolean cashed = false;
   PillarColumn(int i){
    xPos = 100+(i*200);
    opening = random(600)+110;
   }
   void drawPillar(){
     line(xPos,0,xPos,opening-110);  
     line(xPos,opening+110,xPos,800);
   }  
   void checkPosition(){
    if(xPos<0){
     xPos+=(200*3);
     opening = random(600)+100;
     cashed=false;
    } 
    if(xPos<250&&cashed==false){
     cashed=true;
     score++; 
    }
   }

  }
