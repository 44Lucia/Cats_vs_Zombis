class Animation {
  PImage spriteSheet;
  int currentFrame;
  int timeLastFrame;
  float frameTime = 90;
  int frameX, frameY;
  int totalFrames;

  int spriteWidth, spriteHeight;

  Animation(PImage p_spriteSheet, int p_row, int p_totalFrames, int p_spriteWidth, int p_spriteHeight) {
    spriteSheet = p_spriteSheet;
    totalFrames = p_totalFrames;
    spriteWidth = p_spriteWidth;
    spriteHeight = p_spriteHeight;
    frameY = p_row * spriteHeight;
  }

  void play() {
    if (millis() - timeLastFrame > frameTime) {
      currentFrame++;
      
      if (currentFrame >= totalFrames) {currentFrame = 0;}
      frameX = currentFrame * spriteWidth;
      timeLastFrame = millis();
    }
    
    copy(spriteSheet, frameX, frameY,
      spriteWidth, spriteHeight,
      -spriteHeight / 2, -spriteWidth / 2,
      spriteWidth, spriteHeight);
  }
}
