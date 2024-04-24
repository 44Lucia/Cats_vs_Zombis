class ArcherTower {
  PVector position;
  PImage archerSprite;
  float angle;
  float rotationRange; 
  float minAngle; 
  float maxAngle; 

  ArcherTower(float x, float y) {
    position = new PVector(x, y);
    archerSprite = loadImage("Archer.png");
    angle = 0;
    rotationRange = 190;
    minAngle = -PI / 4;
    maxAngle = PI / 4;  
  }
  
  void update() {
    if (isMouseWithinRange()) {
      rotateTowardsMouse();
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    imageMode(CENTER);
    image(archerSprite, 0, 0);
    popMatrix();
  }

  void rotateTowardsMouse() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector towerToMouse = PVector.sub(mousePos, position);
    angle = atan2(towerToMouse.y, towerToMouse.x);
  }

  boolean isMouseWithinRange() {
    return dist(position.x, position.y, mouseX, mouseY) < rotationRange;
  }
}
