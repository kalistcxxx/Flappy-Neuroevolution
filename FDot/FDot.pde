//FlappyDot b = new FlappyDot();
Population pop;
PillarColumn[] p = new PillarColumn[3];
int score=0;
void setup(){
  size(500,800);
  pop = new Population(100);
  resetGame();
  frameRate(100);
}

void resetGame(){
  pop.drawStart();
  for(int i = 0;i<3;i++){
    p[i]=new PillarColumn(i);
    p[i].xPos+=250;
    p[i].cashed = false;
  }
}
  

void draw(){
  background(0);
  
  if(!pop.isAllDead()) {
      pop.updateAliveDot();
  } else {
      pop.calculateFitness();
      pop.natureSelection();
      resetGame();
  }
  fill(0);
  stroke(255);   
  for(int i = 0;i<3;i++){
    p[i].xPos-=1;
    p[i].drawPillar();
    p[i].checkPosition();
  }
  
  textSize(32);
  fill(0, 102, 153);
  text("Gen " + pop.gen + " ~ Best Score: " + pop.bestScore , 10, 30); 
}

void reset(){
 score=0;
 for(int i = 0;i<3;i++){
  p[i].xPos+=550;
  p[i].cashed = false;
 }
}
void mousePressed(){

}
void keyPressed(){
  
}
  
