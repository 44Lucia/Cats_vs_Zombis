class GoldMine extends Entity {
  ArrayList<Gold> goldList;
  int timeLastGold;
  int intervalBetweenCoins; 
  int spawnRadius;
  int gridRow;
  int gridCol;
  
  GoldMine(float p_x, float p_y, int p_gridRow, int p_gridCol) {
    
    animations = new Animations(loadImage("GoldMine.png"), 1, 192, 128);
    animations.spriteSheet.resize(70, 55);
    
    timeLastGold = 0;
    intervalBetweenCoins = 2000;
    spawnRadius = 50;
    
    pos = new PVector(p_x, p_y);
    
    goldList = new ArrayList<Gold>();
    
    maxHealth = 100;
    health = maxHealth;
    isAlive = true;
    healthBar = new HealthBar(this, p_x + 10, p_y - 10, 50, 5);
    
    gridRow = p_gridRow;
    gridCol = p_gridCol;
  }
  
  void update() {
    if (millis() - timeLastGold > intervalBetweenCoins && goldList.size() < 10) {
      float angle = random(TWO_PI);
      
      spawnRadius = (int)random(10, 50);
      PVector newPos = new PVector((pos.x + cos(angle) * spawnRadius),(pos.y + sin(angle) * spawnRadius));
      
      goldList.add(new Gold(newPos.x, newPos.y));
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
    animations.play(0, int(pos.x) + animations.spriteWidth / 2, int(pos.y) + animations.spriteHeight / 2, false);
    
    for (Gold gold : goldList) {gold.display();}
    if(isAlive) {healthBar.display(health, maxHealth);}
  }
  
  void cursorOverSomeGold() {   
    for(Gold gold : goldList) {
      if(gold.isMouseOver()) {ui.cursorOverGold = true; return;}
    }
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if(health <= 0) {isAlive = false;}
  }
}
