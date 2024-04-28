class ArcherTower extends Entity {
  PVector pos;
  PImage archerSprite;
  float angle;
  float rotationRange;
  float minAngle;
  float maxAngle;
  
  ArrayList<Projectile> arrowList = new ArrayList<Projectile>();
  Projectile currentArrow;
  float shootInterval; 
  float lastShotTime;

  ArcherTower(float p_x, float p_y) {
    pos = new PVector(p_x, p_y);
    archerSprite = loadImage("Archer.png");
    angle = 0;
    rotationRange = 190;
    minAngle = -PI / 4;
    maxAngle = PI / 4;

    maxHealth = 100;
    health = maxHealth;
    healthBar = new HealthBar(this, p_x - 25, p_y - 30, 50, 5);
    
    for(int i = 0; i < 3; i++) {arrowList.add(new Projectile());}  
    getNextArrow();
    shootInterval = 2000;
    lastShotTime = 0;
  }

  void update() {
    if (isEnemyWithinRange()) {
      rotateTowardsEnemy();
      // Update and show arrows
      for (Projectile arrow : arrowList) {
          if (arrow.isActive) {
              arrow.update();
              // If the arrow is active, check for collisions
              checkCollisions(arrow);
          }
      }
      // Try to shoot an arrow
      tryShoot();
    }
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    imageMode(CENTER);
    image(archerSprite, 0, 0);
    popMatrix();
    
    // Show and update arrows
    for (Projectile arrow : arrowList) {
        if (arrow.isActive) {
            arrow.display(0);
        }
    }
    
    // Show and update life bar
    if (isAlive) { healthBar.display(health, maxHealth); }
  }
  
  Enemy findClosestEnemy() {
    // Initialize variables to store the position of the closest enemy within range
    Enemy closestEnemy = null;
    float closestDistance = rotationRange;
    
    // Iterate over the list of enemies
    for (Enemy enemy : enemyManager.torches) {
        // Calculate the distance between the tower and the current enemy
        float distanceToEnemy = dist(pos.x, pos.y, enemy.pos.x, enemy.pos.y);
        // Check if the distance is within the rotation range
        if (distanceToEnemy < rotationRange) {
            // Update nearest enemy if it is closer than the current one
            if (distanceToEnemy < closestDistance) {
                closestEnemy = enemy;
                closestDistance = distanceToEnemy;
            }
        }
    } 
    return closestEnemy;
  }

  boolean isEnemyWithinRange() {
    // Iterate over the list of enemies
    for (Enemy enemy : enemyManager.torches) {
      // Calculate the distance between the tower and the current enemy
      float distanceToEnemy = dist(pos.x, pos.y, enemy.pos.x, enemy.pos.y);
      // Check if the distance is within the rotation range
      if (distanceToEnemy < rotationRange) {
        return true; // Return true if an enemy is found within range
      }
    }
    return false; // Return false if no enemy is found within range
  }

  void rotateTowardsEnemy() {
    // Search for the nearest enemy within range
    Enemy closestEnemy = findClosestEnemy();

    // If an enemy was found within range, rotate towards that enemy
    if (closestEnemy != null) {
      // Calculate angle towards nearest enemy using atan2
      float targetAngle = atan2(closestEnemy.pos.y - pos.y, closestEnemy.pos.x - pos.x);
      // Adjust the angle to be between -PI and PI
      targetAngle = (targetAngle + TWO_PI) % TWO_PI;
      // Calculate the angle difference between the current angle and the angle towards the enemy
      float angleDiff = targetAngle - angle;
      // Apply a smooth rotation transition
      float turnSpeed = 0.1;
      angle += turnSpeed * angleDiff;
    }
  }
  
  void tryShoot() {
    // Check if enough time has passed since the last shot
    if (millis() - lastShotTime >= shootInterval) {
        shootAtEnemy(); // Shoot
        lastShotTime = millis(); // Update last shot time
    }
  }
  
  void shootAtEnemy() {
    // Search for the nearest enemy within range
    Enemy closestEnemy = findClosestEnemy();
    
    // If an enemy was found within range, shoot towards that enemy
    if (closestEnemy != null) {
        currentArrow.shootArrow(pos.x, pos.y, angle);
        getNextArrow();
    }
  }
  
  void getNextArrow() {    
    for (Projectile arrow : arrowList) {
        if (!arrow.isActive) {
            currentArrow = arrow;
            currentArrow.isActive = true;
            break; // Exit loop once an arrow has been selected
        }
    }
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      isAlive = false;
    }
  }
  
  void checkCollisions(Projectile p_arrow) {
    // Calculate vertices of each rectangle
    PVector[] arrowVertices = colManager.calculateVertices(p_arrow.pos.x, p_arrow.pos.y, p_arrow.size.x, p_arrow.size.y, p_arrow.angle); // Arrow collider
    for(int i = enemyManager.torches.size() - 1; i >= 0; i--) { // Torch enemies
      Torch torch = enemyManager.torches.get(i);
      
      PVector[] torchVertices = colManager.calculateVertices(torch.pos.x, torch.pos.y, torch.animations.spriteWidth / 8, torch.animations.spriteHeight / 4, 0); // Torch collider
            utilities.drawRectangle(torchVertices);
      
      // Check collision using SAT
      boolean collision = colManager.checkSATCollision(arrowVertices, torchVertices);      
      if(collision) {
        torch.health -= pj.damage;
        p_arrow.hasBeenShoot = false;
        p_arrow.isActive = false;
        if(torch.health <= 0) {
          enemyManager.torches.remove(torch); 
          pj.score += torch.score;
          pj.money += torch.money;
          
          if(enemyManager.torches.size() == 0) {enemyManager.spawnWave();}
        }
      }
    }
  }
}
