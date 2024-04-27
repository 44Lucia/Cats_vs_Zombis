class GoldMine extends Entity {
  PImage goldMine;
  ArrayList<Gold> goldList;
  int timeLastGold;
  int intervalBetweenCoins; 
  int spawnRadius; 
  PVector minePos;
  
  int health;
  int maxHealth;
  boolean alive;
  HealthBar healthBar;
  
  GoldMine(float p_x, float p_y) {
    goldMine = loadImage("GoldMine.png");
    goldMine.resize(70, 55);
    
    timeLastGold = 0;
    intervalBetweenCoins = 2000;
    spawnRadius = 50;
    
    minePos = new PVector(p_x, p_y);
    
    goldList = new ArrayList<Gold>();
    
    maxHealth = 100;
    health = maxHealth;
    alive = true;
    healthBar = new HealthBar(this, p_x + 10, p_y - 10, 50, 5);
  }
  
  void update() {
    if (millis() - timeLastGold > intervalBetweenCoins && goldList.size() < 10) {
      float angle = random(TWO_PI);
      
      spawnRadius = (int)random(10, 50);
      PVector newPos = new PVector((minePos.x + cos(angle) * spawnRadius),(minePos.y + sin(angle) * spawnRadius));
      
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
    image(goldMine, minePos.x, minePos.y);
    
    for (Gold gold : goldList) {gold.display();}
    if(alive) {healthBar.display(health, maxHealth);}
  }
  
  void cursorOverSomeGold() {   
    for(Gold gold : goldList) {
      if(gold.isMouseOver()) {ui.cursorOverGold = true; return;}
    }
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if(health <= 0) {alive = false;}
  }
}
