// Torch goblin enemy

abstract class Enemy extends Entity {

  // Stats
  int health;
  int damage;
  float range;
  float speed;  // Speed from 0 to 1

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
    
    animations = new Animations(loadImage("Torch.png"), 3, 6, 192, 192);
  }

  void update() {
    utilities.drawCircle(x, y, range);
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
    utilities.drawCircle(x, y, range);
  }
}

// Barry goblin enemy
class Barry extends Enemy {

  Explosion explosion;

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

    explosion = new Explosion(x, y);
  }

  void update() {
    utilities.drawCircle(x, y, range);
    explosion.x = x;
    explosion.y = y;
  }
}
