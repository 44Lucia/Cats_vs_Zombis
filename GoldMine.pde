class GoldMine{
  PImage goldMine;
  ArrayList<Gold> goldList;
  int timeLastGold;
  int intervalBetweenCoins; 
  int spawnRadius; 
  float mineX, mineY;
  
  GoldMine(float x, float y) {
    goldMine = loadImage("GoldMine.png");
    goldMine.resize(70, 55);
    
    timeLastGold = 0;
    intervalBetweenCoins = 2000;
    spawnRadius = 50;
    mineX =  x;
    mineY = y;
    
    goldList = new ArrayList<Gold>();
  }
  
  void update() {
    if (millis() - timeLastGold > intervalBetweenCoins && goldList.size() < 10) {
      float angle = random(TWO_PI);
      
      spawnRadius = (int)random(10, 50);
      float x = mineX + cos(angle) * spawnRadius;
      float y = mineY + sin(angle) * spawnRadius;
      
      goldList.add(new Gold(x, y));
      timeLastGold = millis();
    }
    
    for (int i = goldList.size() - 1; i >= 0; i--) {
      Gold gold = goldList.get(i);
      if (gold.isCliceked()) {
        pj.money += 10;
        goldList.remove(i);
      }
    }
  }
  
  void display() {
    image(goldMine, mineX, mineY);
    
    for (Gold gold : goldList) {gold.display();}
  }
  
  void cursorOverSomeGold() {   
    for(Gold gold : goldList) {
      if(gold.isMouseOver()) {ui.cursorOverGold = true; return;}
    }
  }
}
