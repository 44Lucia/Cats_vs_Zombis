// Torch goblin enemy
class Torch extends Entity {

  // Stats
  int health;
  int damage;
  int range;
  int speed;

  // Sprites
  final PImage spriteSheet = loadImage("Torch.png");
  final int spriteWidth = 192, spriteHeight = 192;

  Torch(int x, int y) {
    this.x = x;
    this.y = y;
    health = 100;
    range = 15;
    speed = 10;
    damage = 10;
    currentAnimation = idle;
  }

  // Animations
  Animation idle = new Animation(spriteSheet, 0, 7, spriteWidth, spriteHeight);
  Animation walk = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
  Animation attackRight = new Animation(spriteSheet, 2, 6, spriteWidth, spriteHeight);
  Animation attackDown = new Animation(spriteSheet, 3, 6, spriteWidth, spriteHeight);
  Animation attackUp = new Animation(spriteSheet, 4, 6, spriteWidth, spriteHeight);
}

// TNT goblin thrower enemy
class Tnt extends Entity {

  // Stats
  int health;
  int damage;
  int range;
  int speed;

  // Sprites
  final PImage spriteSheet = loadImage("TNT.png");
  final int spriteWidth = 192, spriteHeight = 192;

  Tnt(int x, int y) {
    this.x = x;
    this.y = y;
    health = 60;
    range = 50;
    speed = 15;
    damage = 15;
    currentAnimation = idle;
  }

  // Animations
  Animation idle = new Animation(spriteSheet, 0, 6, spriteWidth, spriteHeight);
  Animation walk = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
  Animation attack = new Animation(spriteSheet, 2, 7, spriteWidth, spriteHeight);
}

// Barry goblin enemy
class Barry extends Entity {

  // Stats
  int health;
  int damage;
  int range;
  int speed;

  // Sprites
  final PImage spriteSheet = loadImage("Barry.png");
  final int spriteWidth = 128, spriteHeight = 128;

  Barry(int x, int y) {
    this.x = x;
    this.y = y;
    health = 40;
    range = 8;
    speed = 18;
    damage = 30;
    currentAnimation = idle;
  }

  // Animations
  Animation idle = new Animation(spriteSheet, 0, 1, spriteWidth, spriteHeight);
  Animation reveal = new Animation(spriteSheet, 1, 6, spriteWidth, spriteHeight);
  Animation hide = new Animation(spriteSheet, 3, 6, spriteWidth, spriteHeight);
  Animation walk = new Animation(spriteSheet, 4, 3, spriteWidth, spriteHeight);
  Animation explode = new Animation(spriteSheet, 5, 3, spriteWidth, spriteHeight);
}
