//-------[ variables ]-------
Utilities utilities;
UIManager ui;
GridManager gridManager;
CollisionManager colManager;
HighscoreManager hsManager;
EnemyManager enemyManager;
boolean first = true;

//game control
int gameState = 0;
boolean leftClickDown, rightClickDown;
PImage mouseSprite, mouseHoverSprite;
boolean isMouseHovering;
String playerInput = "";
boolean isKnight;

//entities
Player pj;

void setup() {
  size(960, 960);

  mouseSprite = loadImage("mouse.png");
  mouseHoverSprite = loadImage("mouseHover.png");
  noCursor();

  utilities = new Utilities();
  gridManager = new GridManager();
  colManager = new CollisionManager();
  hsManager = new HighscoreManager();
  ui = new UIManager();
  enemyManager = new EnemyManager();

  isKnight = true;
}

void draw() {
  background(128);
  textFont(ui.mainFont);

  //main loop
  switch(gameState) {
  default:
    break;
  case 0:
    { //-------[ main menu ]-------
      ui.mainMenuDisplay();
      break;
    }
    case 1: { //-------[ character selection ]-------
      ui.characterSelectionDisplay();
      break;
    }
  case 2:
    { //-------[ game ]-------
      //entites update
      pj.update();
      enemyManager.update();
      gridManager.update();

      //draw entities
      image(ui.mapSprite, 0, 0);
      gridManager.display();
      pj.display();
      if (first) {
        enemyManager.enemyWave(10, 10, 10);
        first = false;
      }
      enemyManager.display();
      ui.builderButtonsDisplay();

      gridManager.display();
      
      ui.builderButtonsDisplay();

      break;
    }
  case 3:
    { //-------[ game over ]-------

      break;
    }
  }
  
  utilities.fps();

  //cursor
  imageMode(CORNER);
  if (isMouseHovering) {
    image(mouseHoverSprite, mouseX, mouseY);
  } else {
    image(mouseSprite, mouseX, mouseY);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    leftClickDown = true;
  }
  if (mouseButton == RIGHT) {
    rightClickDown = true;
  }

  switch(gameState) {
    default: break;
    case 0: { //-------[ main title ]------- 
      if(ui.returnButton.isMouseOver() && ui.showHighscoreTable) {ui.showHighscoreTable = false;}    
      if(ui.playButton.isMouseOver() && !ui.showHighscoreTable) {gameState = 1;} // To character selection      
      if(ui.highscoreButton.isMouseOver() && !ui.showHighscoreTable) {ui.showHighscoreTable = true;}
      if(ui.exitButton.isMouseOver() && !ui.showHighscoreTable) {closeGame();}
      break;
    }
    case 1: { //-------[ character selection ]-------
      if(ui.returnButton.isMouseOver()) {gameState = 0;}
      if(ui.knightSelectionButton.isMouseOver()) {isKnight = true;}
      if(ui.archerSelectionButton.isMouseOver()) {isKnight = false;}
      if(ui.startGameButton.isMouseOver() && playerInput.length() > 2) {startGame();} 
      break;
    }
  case 2:
    { //-------[ game ]-------
      break;
    }
  case 3:
    { //-------[ game over ]-------

      break;
    }
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    leftClickDown = false;
  }
  if (mouseButton == RIGHT) {
    rightClickDown = false;
  }
}

void keyPressed() {
    switch(gameState) {
      default: break;
      case 1: { //player input (name)
        if(key > 32 && key < 127 && playerInput.length() < 7) {playerInput += key;}
        else if(keyCode == BACKSPACE && playerInput.length() > 0) {
          playerInput = playerInput.substring(0, playerInput.length()-1);
        }
        
        //start playing with enter
        if(keyCode == ENTER && playerInput.length() > 2) {startGame();}
        break;
      }
      case 2: {
        if(key == 'm') {pj.money += 100;} 
        break;
      }
    }
}

void startGame() {
  if(isKnight) {pj = new Knight();}
  else {pj = new Archer();}
  
  pj.name = playerInput;
  gameState = 2; // Game scene
}

void closeGame() {
  hsManager.saveValuesToFile();
  exit();
}
