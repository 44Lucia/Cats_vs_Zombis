class ArcherTower extends Entity {
  PVector pos;
  PImage archerSprite;
  float angle;
  float rotationRange; 
  float minAngle; 
  float maxAngle; 
  

  ArcherTower(float p_x, float p_y) {
    pos = new PVector(p_x, p_y);
    archerSprite = loadImage("Archer.png");
    angle = 0;
    rotationRange = 190;
    minAngle = -PI / 4;
    maxAngle = PI / 4;  
    
    maxHealth = 100;
    health = maxHealth;
    healthBar = new HealthBar(this, p_x - 25, p_y - 30, 50, 5);
  }
  
  void update() {
    if (isMouseWithinRange()) {rotateTowardsMouse();}
  }

  void display() {
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(angle);
      imageMode(CENTER);
      image(archerSprite, 0, 0);
    popMatrix();
    
    if(isAlive) {healthBar.display(health, maxHealth);}
  }

  void rotateTowardsMouse() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector towerToMouse = PVector.sub(mousePos, pos);
    angle = atan2(towerToMouse.y, towerToMouse.x);
  }

  boolean isMouseWithinRange() {
    return dist(pos.x, pos.y, mouseX, mouseY) < rotationRange;
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if(health <= 0) {isAlive = false;}
  }
}
