class UIManager {
  PFont mainFont;
  PImage pixelUISprite;
  
  //main title
  PImage bgSprite;
  PImage titleBgSprite;
  PImage redButtonSprite, redButtonHoverSprite;
  PVector titleBgPos = new PVector(50, 160);
  Button playButton, highscoreButton, exitButton;
  PVector playButtonPos = new PVector(185, 360);
  
  //highscore table
  PImage backToMainTitleSprite;
  PImage top1HighscoreSprite, top5HighscoreSprite, top10HighscoreSprite;
  PImage returnButtonSprite, returnButtonHoverSprite;
  int highscorePosX = 135, highscorePosY = 340;
  Button returnButton;
  int returnButtonPosX = 40, returnButtonPosY = 120;
  boolean showHighscoreTable;
  
  //character selection
  PImage nameInputPanel;
  int nameInputPanelPosX = 135, nameInputPanelPosY = 360;
  Button knightSelectionButton, archerSelectionButton, startGameButton;
  PImage knightButtonSprite, knightButtonSelectedSprite;
  PImage archerButtonSprite, archerButtonSelectedSprite;
  int knightSelectionButtonPosX = 140, archerSelectionButtonPosX = 305, selectionButtonsPosY = 460;
  int startGameButtonPosY = 600;
  
  //towers ui
  PImage mapSprite;
  PImage panelSprite;
  PImage treeSprite;
  PImage goldSprite;
  PImage archerSprite;
  Button goldButton, treeButton, archerButton;
  boolean cursorOverGold;
  
  //Game over ui
  PImage gameOverPanel;
  Button gameOverButton;
  
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
    
    nameInputPanel = loadImage("InputPanel.png");
    knightButtonSprite = loadImage("knightButton.png");
    knightButtonSelectedSprite = loadImage("knightButtonSelected.png");
    archerButtonSprite = loadImage("archerButton.png");
    archerButtonSelectedSprite = loadImage("archerButtonSelected.png");
    
    gameOverPanel = loadImage("gameOverPanel.png");
    gameOverButton = new Button(this, width / 2 - redButtonSprite.width / 2, height / 2 + 80, "Main title", redButtonSprite, redButtonHoverSprite);
    
    //buttons
    playButton = new Button(this, playButtonPos.x, playButtonPos.y, "Play", redButtonSprite, redButtonHoverSprite);
    highscoreButton = new Button(this, playButtonPos.x, playButtonPos.y + 80, "Highscores", redButtonSprite, redButtonHoverSprite);
    exitButton = new Button(this, playButtonPos.x, playButtonPos.y + 200, "Exit", redButtonSprite, redButtonHoverSprite);
    returnButton = new Button(this, returnButtonPosX, returnButtonPosY, "", returnButtonSprite, returnButtonHoverSprite);
    
    knightSelectionButton = new Button(this, knightSelectionButtonPosX, selectionButtonsPosY, "", knightButtonSprite, knightButtonSelectedSprite);
    archerSelectionButton = new Button(this, archerSelectionButtonPosX, selectionButtonsPosY, "", archerButtonSprite, archerButtonSelectedSprite);
    startGameButton = new Button(this, playButtonPos.x, startGameButtonPosY, "Start run", redButtonSprite, redButtonHoverSprite);
    
    panelSprite = loadImage("BannerInGame.png");
    mapSprite = loadImage("Map.png");
    
    goldSprite = loadImage("GoldMine.png");
    goldSprite.resize(85, 70);
    goldButton = new Button(this, 250, height - 80, "100", goldSprite, goldSprite);
    
    treeSprite = loadImage("Tree.png");
    treeSprite.resize(70, 90);
    treeButton = new Button(this, 50, height - 100, "50", treeSprite, treeSprite);
    
    archerSprite = loadImage("Archer.png");
    archerSprite.resize(70, 85);
    archerButton = new Button(this, 150, height - 100, "70", archerSprite, archerSprite);
  }

  //-------[ functions ]-------  
  void mainMenuDisplay() {
    background(bgSprite);
    
    //title
    fill(0);    
    imageMode(CORNER);
    image(titleBgSprite, titleBgPos.x, titleBgPos.y);
    
    if(!showHighscoreTable) {
      textSize(52);
      text("Dwarfs", titleBgPos.x + 120,  titleBgPos.y + 40);
      textSize(32);
      text("vs.", titleBgPos.x + titleBgSprite.width / 2,  titleBgPos.y + titleBgSprite.height / 2 - 20);
      textSize(52);
      text("Goblins", titleBgPos.x + titleBgSprite.width - 120,  titleBgPos.y + 90);
      
      playButton.display();
      highscoreButton.display();
      exitButton.display();
      
      //cursor
      isMouseHovering = playButton.isMouseOver() || highscoreButton.isMouseOver() || exitButton.isMouseOver();
    }
    else {
      textSize(52);
      textAlign(CENTER, CENTER);
      text("Highscores", titleBgPos.x + titleBgSprite.width / 2,  titleBgPos.y + titleBgSprite.height / 2 - 20);
      displayHighscore();
    }
  }
  
  void characterSelectionDisplay() {
    background(bgSprite);
    
    //title
    fill(0);
    imageMode(CORNER);
    image(titleBgSprite, titleBgPos.x, titleBgPos.y);
    textSize(52);
    textAlign(CENTER, CENTER);
    text("Select character", titleBgPos.x + titleBgSprite.width / 2,  titleBgPos.y + titleBgSprite.height / 2 - 20);
    
    returnButton.display();
    
    image(nameInputPanel, nameInputPanelPosX, nameInputPanelPosY);
    
    //input text
    fill(0);
    textSize(40);
    textAlign(CENTER, CENTER);
    if(playerInput == "") {text("--", nameInputPanelPosX + nameInputPanel.width / 2, nameInputPanelPosY + nameInputPanel.height / 3);}
    else {text(playerInput, nameInputPanelPosX + nameInputPanel.width / 2, nameInputPanelPosY + nameInputPanel.height / 3);}
    
    startGameButton.display();
    
    if(isKnight) {
      knightSelectionButton.displayCharacterButton(true);
      archerSelectionButton.displayCharacterButton(false);
      isMouseHovering = archerSelectionButton.isMouseOver() || returnButton.isMouseOver() || startGameButton.isMouseOver();
    }
    else {
      knightSelectionButton.displayCharacterButton(false);
      archerSelectionButton.displayCharacterButton(true);
      isMouseHovering = knightSelectionButton.isMouseOver() || returnButton.isMouseOver() || startGameButton.isMouseOver();
    }
  }
  
  void builderButtonsDisplay() {
    fill(200, 200, 200, 150); // Color semitransparente
    imageMode(CORNER);
    image(panelSprite, 15, height - 115, 350, 125);
    
    goldButton.display();
    treeButton.display();
    archerButton.display();
    
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Score: " + pj.score, width / 2, 10);
    text("Money: " + pj.money, width / 2, 30);
    
    //cursor
    isMouseHovering = goldButton.isMouseOver() || treeButton.isMouseOver() || archerButton.isMouseOver() || cursorOverGold;
  }
  
  void displayHighscore() {
    returnButton.display();
    
    //cursor
    isMouseHovering = returnButton.isMouseOver();
    
    for(int i = 0; i < 20; i+=2) { // 10 names + 10 scores
      int offsetY = i * 25;
      //score bg sprite
      imageMode(CORNER);
      if(i == 0) {image(top1HighscoreSprite, highscorePosX, highscorePosY);}
      else if(i < 8) {image(top5HighscoreSprite, highscorePosX, highscorePosY + offsetY);}
      else {image(top10HighscoreSprite, highscorePosX, highscorePosY + offsetY);}

      //score text
      if(hsManager.sortedScores().length > i) { //avoid null scores if less than 10
        fill(0);
        textSize(48);
        textAlign(CORNER);
        
        int PosY = highscorePosY + top1HighscoreSprite.height + offsetY - 14;
        text(hsManager.sortedScores()[i], highscorePosX + 50, PosY);
        textSize(32);
        text(hsManager.sortedScores()[i+1], highscorePosX + top1HighscoreSprite.width - 60,PosY);
      }
    }  
  }
  
  void gameOverPanelDisplay() {
    background(bgSprite);
    
    //title
    fill(0);
    imageMode(CENTER);
    image(gameOverPanel, width / 2, height / 2);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Game over...", width / 2, height / 2 - 140);
        
    //results text
    fill(0);
    textSize(32);
    textAlign(CORNER, CENTER);
    text("Player:   " + pj.name, width / 2 - 160, height / 2 - 70);
    text("Score:   " + pj.score, width / 2 - 160, height / 2 - 40);
    textSize(24);
    if(pj.score > Integer.valueOf(hsManager.sortedScores()[1])) {text("New Highscore, congrats!!", width / 2 - 160, height / 2 + 10);}
    gameOverButton.display();
    
    imageMode(CENTER);
    PImage classIcon;
    if(isKnight) {classIcon = loadImage("swordIcon.png");}
    else {classIcon = loadImage("bowIcon.png");}
    image(classIcon, width / 2 + 100, height / 2 - 45);
    
    isMouseHovering = gameOverButton.isMouseOver();
  }
}
