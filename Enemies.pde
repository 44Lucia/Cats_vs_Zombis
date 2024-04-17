// Torch goblin enemy

abstract class Enemy extends Entity {

  // Stats
  int health;
  int damage;
  int range;
  int speed;

  // Basic animations
  Animation idle;
  Animation walk;
  Animation attack;
  
 // void moveTo(float x, y) {
    
 // }
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
    range = 15;
    speed = 10;
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
}

// TNT goblin thrower enemy
class Tnt extends Enemy {

  Tnt(int x, int y) {
    this.x = x;
    this.y = y;
    health = 60;
    range = 50;
    speed = 15;
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
}

// Barry goblin enemy
class Barry extends Enemy {

  // Specific animations
  Animation idle;
  Animation reveal;
  Animation hide;

  Barry(int x, int y) {
    this.x = x;
    this.y = y;
    health = 40;
    range = 8;
    speed = 18;
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
}
