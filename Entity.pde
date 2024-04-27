// Entity class

enum Quadrant {
  Q1,
    Q2,
    Q3,
    Q4
}

abstract class Entity {

  PVector pos = new PVector();

  int currentAnimation = 0;
  Animations animations;
  Quadrant quadrant;

  void updateQuadrant() {
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
    quadrant = q;
  }
}

class Animations {
  PImage spriteSheet;
  PImage currentSprite;
  int spriteWidth, spriteHeight;

  int totalRows, totalCols;

  int frameCounter;
  int currentFrameX, currentFrameY;

  int timeLastFrame;
  int frameTime;

  Animations(PImage p_spriteSheet, int p_totalRows, int p_totalCols, int p_spriteWidth, int p_spriteHeight) {
    spriteSheet = p_spriteSheet;
    currentSprite = new PImage();
    totalRows = p_totalRows;
    totalCols = p_totalCols;
    spriteWidth = p_spriteWidth;
    spriteHeight = p_spriteHeight;
    currentFrameX = 0;
    currentFrameY = p_totalCols * spriteHeight;
    frameTime = 90;
  }

  void play(int row, int p_x, int p_y, boolean p_flipped) {
    if (millis() - timeLastFrame > frameTime) {
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
}
