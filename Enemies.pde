// Torch goblin enemy

abstract class Enemy extends Entity {

  // Stats
  int health;
  int damage;
  float range;
  float speed; // Speed from 0 to 1
  int quadrant;
  float moveTimerOffset;
  float moveTimer;
  float moveCooldown;
  boolean moving;
  float lastX;
  boolean flipped;

  final float LIThreshold = 4; // Linear Interpolation threshold for not moving infinitely

  void moveTo(float targetX, float targetY) {
    if (abs(x - targetX) < LIThreshold && abs(y - targetY) < LIThreshold) {
      currentAnimation = 0;
      x = targetX;
      y = targetY;
    } else {
      currentAnimation = 1;
      x = (1 - speed) * x + speed * targetX;
      y = (1 - speed) * y + speed * targetY;
    }
  }

  /*
  boolean constructionInRange() {
   
   }
   */

  void drawRange() {
    utilities.drawCircle(x, y, range);
  }

  void display() {
    // Manage sprite orientation
    if (x - lastX != 0)
      flipped = x - lastX < 0;
    lastX = x;

    animations.play(currentAnimation, int(x), int(y), flipped);
    drawRange();
  }
}

class Torch extends Enemy {

  Torch(float x, float y) {

    // Position
    this.x = x;
    this.y = y;

    // Stats
    health = 100;
    range = 70;
    speed = 0.025;
    damage = 10;
    moveTimer = millis();
    moveCooldown = 3000;

    animations = new Animations(loadImage("Torch.png"), 3, 6, 192, 192);
  }

  void update() {

    if (moveTimerOffset + millis() - moveTimer > moveCooldown) {
      moveTimerOffset = random(5000);
      moveTimer = millis();
      moving = true;
    }
    moveTimerOffset = random(7000);
    float magnitude = 500;
    //float angle = random();
    //PVector dashVector = new PVector(magnitude * cos(angle));
   // moveTo(dashVector.x, dashVector.y);
  }
}

// TNT goblin thrower enemy
class Tnt extends Enemy {

  Tnt(float x, float y) {

    // Position
    this.x = x;
    this.y = y;

    // Stats
    health = 60;
    range = 230;
    speed = 0.05;
    damage = 15;

    animations = new Animations(loadImage("TNT.png"), 3, 6, 192, 192);
  }

  void update() {
  }
}

// Barry goblin enemy
class Barry extends Enemy {

  Barry(float x, float y) {

    // Position
    this.x = x;
    this.y = y;

    // Stats
    health = 40;
    range = 50;
    speed = 0.08;
    damage = 30;

    animations = new Animations(loadImage("Barry.png"), 3, 3, 128, 128);
  }

  void update() {
  }
}
