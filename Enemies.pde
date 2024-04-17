// Torch goblin enemy

abstract class Enemy extends Entity {

  // Sprites
  PImage spriteSheet;
  int spriteWidth, spriteHeight;

  // Stats
  int health;
  int damage;
  int range;
  int speed;

  // Basic animations
  Animation idle;
  Animation walk;
  Animation attack;
  
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
    idle = new Animation(spriteSheet, 0, 7, spriteWidth, spriteHeight);
    walk = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
    attackRight = new Animation(spriteSheet, 2, 6, spriteWidth, spriteHeight);
    attackDown = new Animation(spriteSheet, 3, 6, spriteWidth, spriteHeight);
    attackUp = new Animation(spriteSheet, 4, 6, spriteWidth, spriteHeight);
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
    idle = new Animation(spriteSheet, 0, 6, spriteWidth, spriteHeight);
    walk = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
    attack = new Animation(spriteSheet, 2, 7, spriteWidth, spriteHeight);
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
    idle = new Animation(spriteSheet, 0, 1, spriteWidth, spriteHeight);
    reveal = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
    hide = new Animation(spriteSheet, 3, 6, spriteWidth, spriteHeight);
    walk = new Animation(spriteSheet, 4, 3, spriteWidth, spriteHeight);
    attack = new Animation(spriteSheet, 5, 3, spriteWidth, spriteHeight);
    currentAnimation = idle;
  }
}
