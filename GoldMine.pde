class GoldMine{
  PImage goldMine;
  ArrayList<Gold> golds;
  int timeLastGold;
  int intervalBetweenCoins; 
  int spawnRadius; 
  float mineX, mineY;
  
  GoldMine(float x, float y) {
    goldMine = loadImage("GoldMine.png");
    
    timeLastGold = 0;
    intervalBetweenCoins = 2000;
    spawnRadius = 50;
    mineX =  x;
    mineY = y;
    
    golds = new ArrayList<Gold>();
  }
  
  void update(){
    if (millis() - timeLastGold > intervalBetweenCoins) {
      float angle = random(TWO_PI);
      
      float x = mineX + cos(angle) * spawnRadius;
      float y = mineY + sin(angle) * spawnRadius;
      
      golds.add(new Gold(x, y));
      timeLastGold = millis();
    }
    
    for (int i = golds.size() - 1; i >= 0; i--) {
      Gold gold = golds.get(i);
      gold.display();
      if (gold.isCliceked()) {
        golds.remove(i);
      }
    }
  }
  
  void display(){
    image(goldMine, mineX, mineY, goldMine.width / 2.5, goldMine.height / 2);
  }
}
