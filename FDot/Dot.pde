class FlappyDot{
  float xPos, yPos, ySpeed;
  float fitness;
  boolean isDead = false;
  NeuralNet brain;
  float[] vision = new float[5];
  float[] decision = new float[2];
  boolean isBest = false;
  int score = 0;
  int countingJump = 0;
  int lifetime = 0;
  
  FlappyDot(){
    xPos = 200;
    yPos = 400;
    brain = new NeuralNet(5, 8, 2);
  }
  
  void onDraw(){
    stroke(255);
    noFill();
    strokeWeight(2);
    ellipse(xPos,yPos,20,20);
  }
  
  void onJump(){
    ySpeed = -10;
    countingJump++;
  }
  
  void onDrag(){
    ySpeed += 0.4;
  }
  
  void onMove(){
    yPos+=ySpeed; 
  }
  
  void calculateFitness(){
    fitness = (score + lifetime) * countingJump;
  }
  
  float getFitness(){
    return fitness;
  }
 
  
  void checkCollisions(){
    if(yPos>800 || yPos < 0){
      isDead=true;
     }
    //for(int i = 0;i<3;i++){
        if((xPos<p[checkPillar].xPos+5&&xPos>p[checkPillar].xPos-5)&&(yPos<p[checkPillar].opening-110||yPos>p[checkPillar].opening+110)){
         isDead=true; 
        }
    //}
  }
  
  FlappyDot crossover(FlappyDot p){
    FlappyDot child = new FlappyDot();
    child.brain = this.brain.crossover(p.brain);
    return child;
  }
  
  FlappyDot cloneDot(){
    FlappyDot clone = new FlappyDot();
    clone.brain = this.brain.cloneNet();
    return clone;
  }
  
  float distanceToFirstPillar(int pos){
    return (float) Math.sqrt(Math.pow((xPos - p[0].xPos),2));
  }
  
  float distanceToSpace(float xDes, float yDes){
    return (float) Math.sqrt(Math.pow((xPos -xDes),2) + Math.pow((yPos - yDes),2));
  }
  
  //void show() {
    
  //}
  //void move() {
    
  //}
  void update() {
    if(isBest){
      println(decision[0]+ " ~");
    }  
    if(decision[0] <= 0.5){
      onJump();
    }
    
    if(!isDead){
      onMove();
    }
    onDraw();
    if(!isDead){
      onDrag();
    }
    checkCollisions();
    lifetime++;
  }
  
  int checkPillar = 0;
  
  void look() {
    if(xPos > p[checkPillar].xPos){
      checkPillar++;
      score++;
      if(checkPillar==3) checkPillar = 0;
    } 
    vision[0] = distanceToFirstPillar(checkPillar);
    vision[1] = distanceToSpace(p[checkPillar].xPos, p[checkPillar].opening);
    vision[2] = distanceToSpace(xPos, p[checkPillar].opening);
    vision[3] = distanceTwoPoint(p[checkPillar].xPos, p[checkPillar].opening, p[checkPillar].xPos, 800);
    vision[4] = distanceToSpace(xPos, 800);
  }
  
  float distanceTwoPoint(float xStart, float yStart, float xDes, float yDes){
    return (float) Math.sqrt(Math.pow((xStart -xDes),2) + Math.pow((yStart - yDes),2));
  }
  
  void think(){
    decision = brain.output(vision);
  }
  
  void mutate(){
    float globalMutationRate = 0.1f;
    brain.mutate(globalMutationRate);
  }
}
