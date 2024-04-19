// Entity class

abstract class Entity {

  float x, y;
  float lastX;

  int currentAnimation;
  Animations animations;

  void display() {

    pushMatrix();
    translate(x, y);

    // Manage sprite orientation
    if (x - lastX < 0)
      scale(-1, 1);
    else
      scale(1, 1);

    animations.play(currentAnimation);
    lastX = x;

    utilities.drawCircle(0, 0, 50);
    popMatrix();
  }
}

class Animations {
  PImage spriteSheet;
  int spriteWidth, spriteHeight;

  int totalRows, totalCols;

  int frameCounter;
  int currentFrameX, currentFrameY;

  int timeLastFrame;
  int frameTime;

  Animations(PImage spriteSheet, int rows, int cols, int spriteWidth, int spriteHeight) {
    this.spriteSheet = spriteSheet;
    totalRows = rows;
    totalCols = cols;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    currentFrameX = 0;
    currentFrameY = cols * spriteHeight;
    frameTime = 90;
  }

  void play(int row) {
    if (millis() - timeLastFrame > frameTime) {
      frameCounter = (frameCounter + 1) % totalCols;

      currentFrameX = frameCounter * spriteWidth;
      currentFrameY = row * spriteHeight;
      timeLastFrame = millis();
    }

    copy(spriteSheet, currentFrameX, currentFrameY,
      spriteWidth, spriteHeight,
      -spriteHeight / 2, -spriteWidth / 2,
      spriteWidth, spriteHeight);
  }
}
