class Animation {

  PImage spriteSheet;
  int currentFrame;
  int timeLastFrame;
  float frameTime = 90;
  int frameX, frameY;
  int totalFrames;

  int spriteWidth;
  int spriteHeight;

  Animation(PImage spriteSheet, int row, int totalFrames, int spriteWidth, int spriteHeight) {
    this.spriteSheet = spriteSheet;
    this.totalFrames = totalFrames;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    frameY = row * spriteHeight;
  }

  void play() {
    if (millis() - timeLastFrame > frameTime) {
      currentFrame++;
      if (currentFrame >= totalFrames)
        currentFrame = 0;
      frameX = currentFrame * spriteWidth;

      timeLastFrame = millis();
    }
    copy(spriteSheet, frameX, frameY,
      spriteWidth, spriteHeight,
      -spriteHeight / 2, -spriteWidth / 2,
      spriteWidth, spriteHeight);
  }
}
