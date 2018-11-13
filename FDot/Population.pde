class Population{
   FlappyDot[] pop;
   int bestDot;
   int gen = 0;
   //float fitnessSum = 0;
   
   int bestScore = 0;
   
   Population(int size){
     pop = new FlappyDot[size];
     for(int i=0;i< pop.length;i++){
       pop[i] = new FlappyDot();
     }
   }
   
   void updateAliveDot(){
     for(int i = 0;i <pop.length;i++){
       if(!pop[i].isDead){
         pop[i].look();
         pop[i].think();
         pop[i].update();
       }
       if(bestScore < pop[i].score){
         bestScore = pop[i].score;
       }
     }
   }
   
   void drawStart(){
     for(int i = 0;i <pop.length;i++){
      pop[i].onDraw();
      //pop[i].checkPillar = 0;
     }
     
   }
     
   
   void findBestDot(){
     float max = 0;
     int bestPosition= -1;
     for(int i=0;i<pop.length;i++){
       if(max < pop[i].getFitness()){
         max = pop[i].getFitness();
         bestPosition = i;
       }
     }
     bestDot = bestPosition == -1? 0 : bestPosition;
   }
   
   boolean isAllDead(){
     for(int i=0;i<pop.length;i++){
       if(!pop[i].isDead) return false;
     }
     return true;
   }
   
   void natureSelection(){
     FlappyDot[] nextGen = new FlappyDot[pop.length];
     
     findBestDot();
     nextGen[0] = pop[bestDot].cloneDot();
     nextGen[0].isBest = true;
     float fitnessSum = calculateFitnessSum();
     for(int i=1;i<nextGen.length;i++){
       if(i< pop.length / 2){
         nextGen[i] = selectNextGenDot(fitnessSum).cloneDot();
       } else {
         nextGen[i] = selectNextGenDot(fitnessSum).crossover(selectNextGenDot(fitnessSum));
       }
       nextGen[i].mutate();
     }
     
     pop = nextGen.clone();
     gen++;
   }
   
   FlappyDot selectNextGenDot(float fitnessSum){
     float rdSum = random(0, fitnessSum);
     float runningSum = 0;
     for(int i=1; i < pop.length;i++){
       runningSum += pop[i].getFitness();
       if(runningSum > rdSum){
         return pop[i];
       }
     }
     return pop[0];
   }
   
   void calculateFitness(){
     for(int i=0;i<pop.length;i++){
       pop[i].calculateFitness();
     }
   }
   
   float calculateFitnessSum(){
     float result = 0;
     for(int i=0;i<pop.length;i++){
       result += pop[i].getFitness();
     }
     return result;
   }
}
