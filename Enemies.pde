// Torch goblin enemy

abstract class Enemy extends Entity {

  // Stats
  int health;
  int damage;
  float range;
  float speed;  // Speed from 0 to 1

  // Basic animations
  Animation idle;
  Animation walk;
  Animation attack;

  final float LIThreshold = 4; // Linear Interpolation threshold for not moving infinitely

  void moveTo(float targetX, float targetY) {
    if (abs(x - targetX) < LIThreshold && abs(y - targetY) < LIThreshold) {
      x = targetX;
      y = targetY;
      currentAnimation = idle;
    } else {
      currentAnimation = walk;
      x = (1 - speed) * x + speed * targetX;
      y = (1 - speed) * y + speed * targetY;
    }
  }
}

class Torch extends Enemy {

  // Specific animations
  Animation attackRight;
  Animation attackDown;
  Animation attackUp;

  Torch(int x, int y) {

    // Position
    this.x = x;
    this.y = y;

    // Stats
    health = 100;
    range = 70;
    speed = 0.025;
    damage = 10;

    // Sprite
    spriteSheet = loadImage("Torch.png");
    spriteWidth = 192;
    spriteHeight = 192;

    // Animations
    idle = new Animation(0, 7);
    walk = new Animation(1, 6);
    attackRight = new Animation(2, 6);
    attackDown = new Animation(3, 6);
    attackUp = new Animation(4, 6);
    currentAnimation = idle;
  }

  void update() {
    utilities.drawCircle(x, y, range);
  }
}

// TNT goblin thrower enemy
class Tnt extends Enemy {

  Tnt(int x, int y) {
    this.x = x;
    this.y = y;
    health = 60;
    range = 230;
    speed = 0.05;
    damage = 15;
    currentAnimation = idle;

    // Sprites
    spriteSheet = loadImage("TNT.png");
    spriteWidth = 192;
    spriteHeight = 192;

    // Animations
    idle = new Animation(0, 6);
    walk = new Animation(1, 6);
    attack = new Animation(2, 7);
    currentAnimation = idle;
  }
  
  void update() {
    utilities.drawCircle(x, y, range);
  }
}

// Barry goblin enemy
class Barry extends Enemy {

  // Specific animations
  Animation reveal;
  Animation hide;

  Barry(int x, int y) {
    this.x = x;
    this.y = y;
    health = 40;
    range = 50;
    speed = 0.08;
    damage = 30;

    // Sprite
    spriteSheet = loadImage("Barry.png");
    spriteWidth = 128;
    spriteHeight = 128;

    // Animations
    idle = new Animation(0, 1);
    reveal = new Animation(1, 6);
    hide = new Animation(3, 6);
    walk = new Animation(4, 3);
    attack = new Animation(5, 3);
    currentAnimation = idle;
  }
  
  void update() {
    utilities.drawCircle(x, y, range);
  }
}
