abstract class Enemy extends Entity {
  // Stats
  float damage, range;
  int score, money;

  long canAttackTime = 1000, lastTimeAttacked;

  // Movement variables
  boolean idle;
  PVector finalMovement = new PVector();
  PVector desiredPos = new PVector();
  float currentAcceleration = 0, deltaAcceleration = 0.005;
  float moveTimer = millis();
  float moveCooldown = 2000;
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
      idle = true;
      if (millis() - moveTimer > moveCooldown) {
        idle = false;
        moveCooldown = random(1500, 2000);
        setNewMovement();
        moveTimer = millis();
      }
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
    float magnitude = random(85, 140);

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

    PVector distance;
    for (TreeWall treeWall : gridManager.treeList) {
      distance = new PVector(pos.x - treeWall.pos.x, pos.y - treeWall.pos.y);
      if (distance.mag() < range) {
        return treeWall;
      }
    }

    for (ArcherTower archerTower : gridManager.archerTowerList) {
      distance = new PVector(pos.x - archerTower.pos.x, pos.y - archerTower.pos.y);
      if (distance.mag() < range) {
        return archerTower;
      }
    }
    
    for (GoldMine goldMine : gridManager.goldMineList) {
      distance = new PVector(pos.x - goldMine.pos.x, pos.y - goldMine.pos.y);
      if (distance.mag() < range) {
        return goldMine;
      }
    }

    distance = new PVector(pos.x - pj.pos.x, pos.y - pj.pos.y);
    if (distance.mag() < range) {
      return pj;
    }

    return null;
  }

  void display() {

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

    animations = new Animations(loadImage("Torch.png"), 6, 192, 192);

    // Stats
    health = 100;
    maxHealth = 100;
    healthBar = new HealthBar(this, pos.x, pos.y, 50, 5);
    range = 70;
    damage = 5;
    score = 1;
    money = 50;

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
      if (millis() - damageLutTimer > 50) {
        damageLutTimer = millis();
        target.damageLUT();
      }
    } else {
      calculateMovement();
      if (!idle)
        move();
    }
  }
}

// TNT goblin thrower enemy
class Tnt extends Enemy {

  Projectile projectile = new Projectile();

  Tnt(PVector p_pos) {

    // Position
    pos = p_pos;

    animations = new Animations(loadImage("TNT.png"), 6, 192, 192);

    // Stats
    health = 60;
    maxHealth = 60;
    healthBar = new HealthBar(this, pos.x, pos.y, 50, 5);
    range = 230;
    damage = 10;
    score = 3;
    money = 20;

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
      if (millis() - damageLutTimer > 50) {
        damageLutTimer = millis();
        target.damageLUT();
      }
    } else {
      calculateMovement();
      if (!idle)
        move();
    }
  }
}

// Barry goblin enemy
class Barry extends Enemy {

  Barry (PVector p_pos) {

    // Position
    pos = p_pos;

    animations = new Animations(loadImage("Barry.png"), 3, 128, 128);

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
    Entity target = entityInRange();
    if (target != null) {
      currentAnimation = 2;
      if (canAttackTime + lastTimeAttacked < millis()) {
        lastTimeAttacked = millis();
        target.takeDamage(damage);
      }
      if (millis() - damageLutTimer > 50) {
        damageLutTimer = millis();
        target.damageLUT();
      }
    } else {
      calculateMovement();
      if (!idle)
        move();
    }
  }
}
