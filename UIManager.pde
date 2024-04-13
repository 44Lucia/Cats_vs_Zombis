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
  
  //game ui
  PImage treeSprite;
  PImage goldSprite;
  PImage archerSprite;
  Button goldButton;
  Button treeButton;
  Button archerButton;
  
  UIManager() {
    mainFont = createFont("Alkhemikal.ttf", 100);
    bgSprite = loadImage("MainMenuBg.png");
    titleBgSprite = loadImage("MainTitleBg.png");
    redButtonSprite = loadImage("RedButton.png");
    redButtonHoverSprite = loadImage("RedButtonHover.png");
    
    playButton = new Button(this, playButtonPosX, playButtonPosY, "Play", redButtonSprite, redButtonHoverSprite); 
    
    goldSprite = loadImage("GoldMine.png");
    goldSprite.resize(85, 70);
    goldButton = new Button(this, 250, height - 80, "100", goldSprite, goldSprite);
    
    treeSprite = loadImage("Tree.png");
    treeSprite.resize(70, 90);
    treeButton = new Button(this, 50, height - 100, "50", treeSprite, treeSprite);
    
    archerSprite = loadImage("Archer.png");
    archerSprite.resize(70, 85);
    archerButton = new Button(this, 150, height - 100, "120", archerSprite, archerSprite);
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
  
  void uiGameDisplay(){
    goldButton.display();
    treeButton.display();
    archerButton.display();
    
    fill(255);
    textSize(20);
    textAlign(RIGHT, TOP);
    text("Money: " + money, width - 10, 10);
  }
}
