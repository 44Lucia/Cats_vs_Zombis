// Entity class

enum Quadrant {
  Q1, Q2, Q3, Q4
}

abstract class Entity {
  int health;
  int maxHealth;
  HealthBar healthBar;
  boolean isAlive = true;
  float damageLutTimer = millis();

  PVector pos = new PVector();

  int currentAnimation = 0;
  Animations animations;
  Quadrant quadrant;

  void updateQuadrant() {
    Quadrant q;
    if (pos.x > width / 2) {
      if (pos.y < height / 2) {
        q = Quadrant.Q1;
      } else {
        q = Quadrant.Q4;
      }
    } else if (pos.y < height / 2) {
      q = Quadrant.Q2;
    } else {
      q = Quadrant.Q3;
    }
    quadrant = q;
  }

  void takeDamage(float p_damage) {

    health -= p_damage;
    if (health <= 0) {
      if (this instanceof Player) {
        hsManager.highscoreDict.add(pj.name, pj.score);
      }
      isAlive = false;
    }
  }

  void damageLUT() {

    PImage lut = animations.currentSprite;
    animations.freezeFrame(true);

    for (int i = 0; i < lut.width; i++) {
      for (int j = 0; j < lut.height; j++) {
        color col = lut.get(i, j);
        if (alpha(col) > 10) {
          col += color(40, 0, 0);
        }
        lut.set(i, j, col);
      }
    }
  }
}

class Animations {
  PImage spriteSheet;
  PImage currentSprite;
  int spriteWidth, spriteHeight;

  int totalCols;
  int frameCounter;
  int currentFrameX, currentFrameY;

  int timeLastFrame;
  int frameTime;
  boolean frozenFrame = false;

  Animations(PImage p_spriteSheet, int p_totalCols, int p_spriteWidth, int p_spriteHeight) {
    spriteSheet = p_spriteSheet;
    currentSprite = new PImage();
    totalCols = p_totalCols;
    spriteWidth = p_spriteWidth;
    spriteHeight = p_spriteHeight;
    currentFrameX = 0;
    currentFrameY = p_totalCols * spriteHeight;
    frameTime = 90;
  }

  void play(int row, int p_x, int p_y, boolean p_flipped) {
    if (!frozenFrame && millis() - timeLastFrame > frameTime) {
      if (totalCols != 0)
        frameCounter = (frameCounter + 1) % totalCols;

      currentFrameX = frameCounter * spriteWidth;
      currentFrameY = row * spriteHeight;
      timeLastFrame = millis();

      currentSprite = spriteSheet.get(currentFrameX, currentFrameY, spriteWidth, spriteHeight);
    }
    pushMatrix();
    imageMode(CENTER);
    if (p_flipped) {
      scale(-1, 1);
      image(currentSprite, -p_x, p_y);
    } else {
      scale(1, 1);
      image(currentSprite, p_x, p_y);
    }
    popMatrix();
  }

  void freezeFrame(boolean freeze) {
    frozenFrame = freeze;
  }
}
