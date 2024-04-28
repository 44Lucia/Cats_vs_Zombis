//DWARVES VS GOBLINS
//  Arnau Miragall
//  Lucia Fornos
//  Pol Lleida


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
  background(20);
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
  case 1:
    { //-------[ character selection ]-------
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
      ui.builderButtonsDisplay();
      enemyManager.display();

      break;
    }
  case 3:
    { //-------[ game over ]-------
      ui.gameOverPanelDisplay();
      break;
    }
  }

  //utilities.fps();

  //cursor
  imageMode(CORNER);
  if(isMouseHovering) {
    image(mouseHoverSprite, mouseX, mouseY);
  } else {
    image(mouseSprite, mouseX, mouseY);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {leftClickDown = true;}
  if (mouseButton == RIGHT) {rightClickDown = true;}

  switch(gameState) {
  default:
    break;
  case 0:
    { //-------[ main title ]-------
      if (ui.returnButton.isMouseOver() && ui.showHighscoreTable) {ui.showHighscoreTable = false;}
      if (ui.playButton.isMouseOver() && !ui.showHighscoreTable) {gameState = 1;}
      if (ui.highscoreButton.isMouseOver() && !ui.showHighscoreTable) {ui.showHighscoreTable = true;}
      if (ui.exitButton.isMouseOver() && !ui.showHighscoreTable) {closeGame();}
      break;
    }
  case 1:
    { //-------[ character selection ]-------
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
      if(ui.gameOverButton.isMouseOver()) {gameState = 0;}
      break;
    }
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {leftClickDown = false;}
  if(mouseButton == RIGHT) {rightClickDown = false;}
}

void keyPressed() {
  switch(gameState) {
  default:
    break;
  case 1:
    { //player input (name)
      if(key > 32 && key < 127 && playerInput.length() < 7) {playerInput += key;} 
      else if(keyCode == BACKSPACE && playerInput.length() > 0) {
        playerInput = playerInput.substring(0, playerInput.length()-1);
      }

      //start playing with enter
      if(keyCode == ENTER && playerInput.length() > 2) {startGame();}
      break;
    }
  case 2:
    {
      if(key == 'm') {pj.money += 100;}
      if(key == 'k') {pj.isAlive = false;}
      break;
    }
  }
}

void startGame() {
  if(isKnight) {pj = new Knight();} 
  else {pj = new Archer();}

  pj.name = playerInput;
  gameState = 2; // Game scene
  
  enemyManager = new EnemyManager();
  gridManager = new GridManager();
  enemyManager.spawnWave();
}

void closeGame() {
  hsManager.saveValuesToFile();
  exit();
}
