class UIManager {
  PFont mainFont;
  PImage pixelUISprite;
  
  //main title
  PImage bgSprite;
  PImage titleBgSprite;
  PImage redButtonSprite, redButtonHoverSprite;
  int titleBgPosX = 50, titleBgPosY = 160;
  Button playButton, highscoreButton, exitButton;
  int playButtonPosX = 185, playButtonPosY = 360;
  
  //highscore table
  PImage backToMainTitleSprite;
  PImage top1HighscoreSprite, top5HighscoreSprite, top10HighscoreSprite;
  PImage returnButtonSprite, returnButtonHoverSprite;
  int highscorePosX = 150, highscorePosY = 340;
  Button returnButton;
  int returnButtonPosX = 40, returnButtonPosY = 120;
  boolean showHighscoreTable;
  
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
    
    top1HighscoreSprite = loadImage("HighscoreTop1.png");
    top5HighscoreSprite = loadImage("HighscoreTop5.png");
    top10HighscoreSprite = loadImage("HighscoreTop10.png");
    returnButtonSprite = loadImage("ReturnButton.png");
    returnButtonHoverSprite = loadImage("ReturnButtonHover.png");
    
    //buttons
    playButton = new Button(this, playButtonPosX, playButtonPosY, "Play", redButtonSprite, redButtonHoverSprite);
    highscoreButton = new Button(this, playButtonPosX, playButtonPosY + 80, "Highscores", redButtonSprite, redButtonHoverSprite);
    exitButton = new Button(this, playButtonPosX, playButtonPosY + 200, "Exit", redButtonSprite, redButtonHoverSprite);
    returnButton = new Button(this, returnButtonPosX, returnButtonPosY, "", returnButtonSprite, returnButtonHoverSprite);
    
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
    
    if(!showHighscoreTable) {
      textSize(52);
      text("Dwarfs", titleBgPosX + 120,  titleBgPosY + 40);
      textSize(32);
      text("vs.", titleBgPosX + titleBgSprite.width / 2,  titleBgPosY + titleBgSprite.height / 2 - 20);
      textSize(52);
      text("Goblins", titleBgPosX + titleBgSprite.width - 120,  titleBgPosY + 90);
      
      playButton.display();
      highscoreButton.display();
      exitButton.display();
    }
    else {
      textSize(52);
      textAlign(CENTER, CENTER);
      text("Highscores", titleBgPosX + titleBgSprite.width / 2,  titleBgPosY + titleBgSprite.height / 2 - 20);
      displayHighscore();
    }
  }
  
  void builderButtonsDisplay(){
    goldButton.display();
    treeButton.display();
    archerButton.display();
    
    fill(255);
    textSize(20);
    textAlign(RIGHT, TOP);
    text("Money: " + pj.money, width - 10, 10);
  }
  
  void displayHighscore() {
    returnButton.display();
    
    for(int i = 0; i < 20; i+=2) {
      int offsetY = i * 25;
      //score bg sprite
      imageMode(CORNER);
      if(i == 0) {image(top1HighscoreSprite, highscorePosX, highscorePosY);}
      else if(i < 8) {image(top5HighscoreSprite, highscorePosX, highscorePosY + offsetY);}
      else {image(top10HighscoreSprite, highscorePosX, highscorePosY + offsetY);}

      //score text
      hsManager.sortedScores();
      
      if(hsManager.sortedScores().length > i) { //avoid null scores if less than 10
        fill(0);
        textSize(48);
        textAlign(CORNER);
        text(hsManager.sortedScores()[i], highscorePosX + 20, highscorePosY + top1HighscoreSprite.height + offsetY - 14);
        textSize(32);
        text(hsManager.sortedScores()[i+1], highscorePosX + top1HighscoreSprite.width - 60, highscorePosY + top1HighscoreSprite.height + offsetY - 14);
      }
    }  
  }
}
