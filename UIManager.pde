class UIManager {
  PFont mainFont;
  PImage pixelUISprite;
  
  //main title
  PImage bgSprite;
  PImage titleBgSprite;
  PImage redButtonSprite, redButtonHoverSprite;
  int titleBgPosX = 50, titleBgPosY = 160;
  Button playButton;
  int playButtonPosX = 185, playButtonPosY = 340;
  
  UIManager() {
    mainFont = createFont("Alkhemikal.ttf", 100);
    bgSprite = loadImage("MainMenuBg.png");
    titleBgSprite = loadImage("MainTitleBg.png");
    redButtonSprite = loadImage("RedButton.png");
    redButtonHoverSprite = loadImage("RedButtonHover.png");
    
    playButton = new Button(this, playButtonPosX, playButtonPosY, "Play", redButtonSprite, redButtonHoverSprite); 
  }

  //-------[ functions ]-------  
  void mainMenuDisplay() {
    background(bgSprite);
    
    //title
    fill(0);    
    imageMode(CORNER);
    image(titleBgSprite, titleBgPosX, titleBgPosY);
    
    playButton.display();
  }
}
