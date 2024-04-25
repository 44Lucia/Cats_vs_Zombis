// Torch goblin enemy

enum Quadrant {
  Q1,
    Q2,
    Q3,
    Q4
}

abstract class Enemy extends Entity {

  // Stats
  int health;
  int damage;
  float range;
  Quadrant quadrant;

  // Dash variables
  float moveTimerOffset;
  float moveTimer;
  float moveCooldown;
  boolean moving;
  boolean movingStart;

  // Acceleration
  PVector desiredPos;
  PVector finalMovement;
  float currentAcceleration = 0, deltaAcceleration = 0.005;
  final float MAX_SPEED = 2;
  float rotationAngle = 0.3;   //enemy rotation amplitude

  // Flipping variables
  float lastX;
  boolean flipped;

  Quadrant checkQuadrant() {
    Quadrant q;
    if (pos.x > width / 2) {
      if (pos.y < height / 2)
        q = Quadrant.Q1;
      else
        q = Quadrant.Q4;
    } else {
      if (pos.y < height / 2)
        q = Quadrant.Q2;
      else
        q = Quadrant.Q3;
    }
    return q;
  }

  final float LIThreshold = 4;

  void calculateMovement() {
    PVector distanceToDestination = desiredPos.sub(pos);

    if (abs(distanceToDestination.x) < LIThreshold && abs(distanceToDestination.y) < LIThreshold) {
      currentAnimation = 0;
      setNewMovement();
    }

    float magnitude = sqrt(pow(distanceToDestination.x, 2) + pow(distanceToDestination.y, 2));

    if (magnitude > 0)
      distanceToDestination = distanceToDestination.div(magnitude);

    //add direction to movement
    finalMovement.x = finalMovement.x + distanceToDestination.x * rotationAngle;
    finalMovement.y = finalMovement.y + distanceToDestination.y * rotationAngle;

    //speed limit to avoid extremely fast moves
    float speed = sqrt(pow(finalMovement.x, 2) + pow(finalMovement.y, 2));
    if (speed > MAX_SPEED) {
      finalMovement.x = finalMovement.x / speed * MAX_SPEED;
      finalMovement.y = finalMovement.y / speed * MAX_SPEED;
    }
  }

  void setNewMovement() {
    // Check quadrant
    quadrant = checkQuadrant();

    float angle;
    float magnitude = random(5);
    switch (quadrant) {
    case Q1:
      angle = random(HALF_PI, PI);
      break;
    case Q2:
      angle = random(HALF_PI);
      break;
    case Q3:
      angle = random(3 * HALF_PI);
      break;
    case Q4:
      angle = random(PI, 3 * HALF_PI);
      break;
    default:
      angle = 0;
      break;
    }
    desiredPos.x = magnitude * cos(angle);
    desiredPos.y = magnitude * sin(angle);
    println(desiredPos);
  }

  void move() {

    //acceleration
    if (currentAcceleration < 1) {
      currentAcceleration += deltaAcceleration;
    } else {
      currentAcceleration = 0.8;
    }

    pos = pos.add(finalMovement.mult(currentAcceleration));
  }



  void drawRange() {
    utilities.drawCircle(pos.x, pos.y, range);
  }

  void display() {
    // Manage sprite orientation
    if (pos.x - lastX != 0)
      flipped = pos.x - lastX < 0;
    lastX = pos.x;

    animations.play(currentAnimation, int(pos.x), int(pos.y), flipped);
    drawRange();
  }
}

class Torch extends Enemy {

  Torch(PVector p_pos) {

    // Position
    pos = p_pos;

    // Stats
    health = 100;
    range = 70;
    damage = 10;
    finalMovement = new PVector();
    desiredPos = new PVector();

    moveTimer = millis();
    moveCooldown = 1000;

    quadrant = checkQuadrant();
    setNewMovement();

    animations = new Animations(loadImage("Torch.png"), 3, 6, 192, 192);
  }

  void update() {
    //println(quadrant);
    //println(pos);
    calculateMovement();
    move();
  }
}

// TNT goblin thrower enemy
class Tnt extends Enemy {

  Tnt(PVector p_pos) {

    // Position
    pos = p_pos;

    // Stats
    health = 60;
    range = 230;
    damage = 15;

    animations = new Animations(loadImage("TNT.png"), 3, 6, 192, 192);
  }

  void update() {
  }
}

// Barry goblin enemy
class Barry extends Enemy {

  Barry (PVector p_pos) {

    // Position
    pos = p_pos;

    // Stats
    health = 40;
    range = 50;
    damage = 30;

    animations = new Animations(loadImage("Barry.png"), 3, 3, 128, 128);
  }

  void update() {
  }
}
