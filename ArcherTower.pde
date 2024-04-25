class ArcherTower {
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
  }

  void rotateTowardsMouse() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector towerToMouse = PVector.sub(mousePos, pos);
    angle = atan2(towerToMouse.y, towerToMouse.x);
  }

  boolean isMouseWithinRange() {
    return dist(pos.x, pos.y, mouseX, mouseY) < rotationRange;
  }
}
