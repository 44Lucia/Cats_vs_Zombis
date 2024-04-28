class Player extends Entity {
  int damage = 0;
  int money = 70;
  int score = 0;
  String name = "";
  PVector pos;

  boolean isWeaponUp;

  Player() {
    pos = new PVector(width / 2, height / 2);
    animations = new Animations(loadImage("Player.png"), 1, 64, 64);
    healthBar = new HealthBar(this, pos.x - animations.spriteWidth / 2, pos.y + 30, 60, 10);
  }

  //default no weapon update
  void update() {
    playerAnimDirection();
    isWeaponUp = currentAnimation < 5; //Sets the weapon back or front of the player

    //game over
    if (!isAlive) {
      gameState = 3;
    }
  }

  //default no weapon display
  void display() {
    fill(0);
    animations.play(currentAnimation, int(pos.x), int(pos.y), false);
  }

  void playerAnimDirection() {
    float animAngle = degrees(utilities.mouseAngle());
    //sprite Row update (8 dir)
    if (animAngle >= -22.5 && animAngle < 22.5) {
      currentAnimation = 0;
    } //east
    else if (animAngle <= -22.5 && animAngle > -67.5) {
      currentAnimation = 1;
    } //north-east
    else if (animAngle <= -67.5 && animAngle > -112.5) {
      currentAnimation = 2;
    } //north
    else if (animAngle <= -112.5 && animAngle > -157.5) {
      currentAnimation = 3;
    } //north-west
    else if (animAngle <= -157.5 || animAngle > 157.5) {
      currentAnimation = 4;
    } //west
    else if (animAngle <= 157.5 && animAngle > 112.5) {
      currentAnimation = 5;
    } //south-west
    else if (animAngle <= 112.5 && animAngle > 67.5) {
      currentAnimation = 6;
    } //south
    else {
      currentAnimation = 7;
    } //south-east
  }
}

class Knight extends Player {
  GreatSword sword;

  Knight() {
    sword = new GreatSword();
    maxHealth = 100;
    health = maxHealth;
    damage = 5;
  }

  void update() {
    super.update();

    sword.update();
  }

  void display() {
    fill(0);

    if (isWeaponUp) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(sword.currentAngle);
      sword.display();
      popMatrix();
    }
    animations.play(currentAnimation, int(pos.x), int(pos.y), false);

    if (!isWeaponUp) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(sword.currentAngle);
      sword.display();
      popMatrix();
    }

    healthBar.display(health, maxHealth);
  }
}

class Archer extends Player {
  Bow bow;

  Archer() {
    bow = new Bow();
    maxHealth = 60;
    health = maxHealth;
    damage = 40;
  }

  void update() {
    super.update();

    bow.update();
  }

  void display() {
    fill(0);

    if (isWeaponUp) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(bow.currentAngle);
      bow.display();
      popMatrix();
    }
    animations.play(currentAnimation, int(pos.x), int(pos.y), false);

    if (!isWeaponUp) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(bow.currentAngle);
      bow.display();
      popMatrix();
    }

    healthBar.display(health, maxHealth);
  }
}
