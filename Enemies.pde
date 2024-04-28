abstract class Enemy extends Entity {
  // Stats
  float damage, range;
  int score, money;

  // Acceleration
  PVector desiredPos;
  PVector finalMovement;
  float currentAcceleration = 0, deltaAcceleration = 0.005;
  final float MAX_SPEED = 2;
  float rotationAngle = 0.3;

  // Flipping variables
  float lastX;
  boolean flipped;

  final float LIThreshold = 2;

  void calculateMovement() {

    PVector distanceToDestination = new PVector(desiredPos.x - pos.x, desiredPos.y - pos.y);

    if (abs(distanceToDestination.x) < LIThreshold && abs(distanceToDestination.y) < LIThreshold) {
      currentAnimation = 0;
      setNewMovement();
    } else {
      currentAnimation = 1;

      //add direction to movement
      finalMovement.x += distanceToDestination.x * rotationAngle;
      finalMovement.y += distanceToDestination.y * rotationAngle;

      //speed limit to avoid extremely fast moves
      float speed = sqrt(pow(finalMovement.x, 2) + pow(finalMovement.y, 2));
      if (speed > MAX_SPEED) {
        finalMovement.x = (finalMovement.x / speed) * MAX_SPEED;
        finalMovement.y = (finalMovement.y / speed) * MAX_SPEED;
      }
    }
  }

  void setNewMovement() {
    float angle;
    float magnitude = random(70, 105);

    updateQuadrant();
    switch(quadrant) {
    case Q1:
      angle = random(HALF_PI, PI);
      break;
    case Q2:
      angle = random(HALF_PI);
      break;
    case Q3:
      angle = random(3 * HALF_PI, TWO_PI);
      break;
    case Q4:
      angle = random(PI, 3 * HALF_PI);
      break;
    default:
      angle = 0;
      break;
    }

    //Go to the center of your quad
    desiredPos.x = pos.x + magnitude * cos(angle);
    desiredPos.y = pos.y + magnitude * sin(angle);
  }

  void move() {
    //acceleration
    if (currentAcceleration < 1) {
      currentAcceleration += deltaAcceleration;
    } else {
      currentAcceleration = 0.8;
    }

    pos.x += finalMovement.x * currentAcceleration;
    pos.y += finalMovement.y * currentAcceleration;
  }

  void drawRange() {
    utilities.drawCircle(pos.x, pos.y, range);
  }

  Entity entityInRange() {
    for (TreeWall treeWall : gridManager.treeList) {
      PVector distance = new PVector(pos.x - treeWall.pos.x, pos.y - treeWall.pos.y);
      if (distance.mag() < range) {
        return treeWall;
      }
    }

    for (ArcherTower archerTower : gridManager.archerTowerList) {
      PVector distance = new PVector(pos.x - archerTower.pos.x, pos.y - archerTower.pos.y);
      if (distance.mag() < range) {
        return archerTower;
      }
    }

    for (GoldMine goldMine : gridManager.goldMineList) {
      PVector distance = new PVector(pos.x - goldMine.pos.x, pos.y - goldMine.pos.y);
      if (distance.mag() < range) {
        return goldMine;
      }
    }

    PVector distance = new PVector(pos.x - pj.pos.x, pos.y - pj.pos.y);
    if (distance.mag() < range) {
      return pj;
    }

    return null;
  }

  void display() {
    
    circle(desiredPos.x, desiredPos.y, 40);
    // Manage sprite orientation
    if (pos.x - lastX != 0) {
      flipped = pos.x - lastX < 0;
    }
    lastX = pos.x;

    animations.play(currentAnimation, int(pos.x), int(pos.y), flipped);
    drawRange();
    healthBar.healthBarPos.set(pos.x - animations.spriteWidth / 8, pos.y - animations.spriteHeight / 4);
    healthBar.display(health, maxHealth);
  }
}

class Torch extends Enemy {
  Torch(PVector p_pos) {
    pos = p_pos;

    animations = new Animations(loadImage("Torch.png"), 3, 6, 192, 192);

    // Stats
    health = 100;
    maxHealth = 100;
    healthBar = new HealthBar(this, pos.x, pos.y, 50, 5);
    range = 70;
    damage = 5;
    score = 1;
    money = 10;
    finalMovement = new PVector();
    desiredPos = new PVector();

    setNewMovement();
  }

  void update() {
    Entity target = entityInRange();
    if (target != null) {
      currentAnimation = 2;
      if (canAttackTime + lastTimeAttacked < millis()) {
        lastTimeAttacked = millis();
        target.takeDamage(damage);
      }
    } else {
      calculateMovement();
      move();
    }
  }
}

// TNT goblin thrower enemy
class Tnt extends Enemy {
  int health;
  int maxHealth;

  Tnt(PVector p_pos) {

    // Position
    pos = p_pos;

    animations = new Animations(loadImage("TNT.png"), 3, 6, 192, 192);

    // Stats
    health = 60;
    maxHealth = 60;
    healthBar = new HealthBar(this, pos.x, pos.y, 50, 5);
    range = 230;
    damage = 10;
    score = 3;
    money = 20;
  }

  void update() {
  }
}

// Barry goblin enemy
class Barry extends Enemy {
  int health;
  int maxHealth;

  Barry (PVector p_pos) {

    // Position
    pos = p_pos;

    animations = new Animations(loadImage("Barry.png"), 3, 3, 128, 128);

    // Stats
    health = 40;
    maxHealth = 40;
    healthBar = new HealthBar(this, pos.x, pos.y, 50, 5);

    range = 50;
    damage = 15;
    score = 5;
    money = 30;
  }

  void update() {
  }
}
