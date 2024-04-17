// Entity class

abstract class Entity {

  float x, y;
  float lastX;

  PImage spriteSheet;
  int spriteWidth, spriteHeight;
  Animation currentAnimation;

  class Animation {
    int currentFrame;
    int timeLastFrame;
    float frameTime = 90;
    int frameX, frameY;
    int totalFrames;

    Animation(int row, int totalFrames) {
      this.totalFrames = totalFrames;
      frameY = row * spriteHeight;
    }

    void play() {
      if (millis() - timeLastFrame > frameTime) {
        currentFrame++;

        if (currentFrame >= totalFrames) {
          currentFrame = 0;
        }
        frameX = currentFrame * spriteWidth;
        timeLastFrame = millis();
      }

      copy(spriteSheet, frameX, frameY,
        spriteWidth, spriteHeight,
        -spriteHeight / 2, -spriteWidth / 2,
        spriteWidth, spriteHeight);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);

    // Manage sprite orientation
    if (x - lastX < 0)
      scale(-1, 1);
    else
      scale(1, 1);
    lastX = x;

    currentAnimation.play();
    popMatrix();
  }
}
