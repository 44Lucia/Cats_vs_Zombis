//-------[ variables ]-------
Utilities utilities;
UIManager ui;
GridManager gridManager;
CollisionManager colManager;
HighscoreManager hsManager;

//game control
int gameState = 0;
boolean leftClickDown, rightClickDown;
PImage mouseSprite, mouseHoverSprite; 
boolean isMouseHovering;
String playerInput;

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

  //initialize entites
  pj = new Archer();
}

void draw() {
  background(128);
  textFont(ui.mainFont);

  //main loop
  switch(gameState) {
    default: break;
    case 0: { //-------[ main menu ]-------
      ui.mainMenuDisplay();
      break;
    }
    case 1: { //-------[ character selection ]-------

      break;
    }
    case 2: { //-------[ game ]-------
      //entites update
      pj.update();
      
      gridManager.update();
      
      //draw entities
      image(ui.mapSprite, 0, 0);
      pj.display();
      
      gridManager.display();
      ui.builderButtonsDisplay();
      
      break;
    }
    case 3: { //-------[ game over ]-------     

      break;
    }
  }
  
  //cursor
  imageMode(CORNER);
  if(isMouseHovering) {image(mouseHoverSprite, mouseX, mouseY);}
  else {image(mouseSprite, mouseX, mouseY);}  
}

void mousePressed() {
  if(mouseButton == LEFT) {leftClickDown = true;}
  if(mouseButton == RIGHT) {rightClickDown = true;}
  
  switch(gameState) {
    default: break;
    case 0: { //-------[ main title ]-------
    
      if(ui.playButton.isMouseOver() && !ui.showHighscoreTable) {startGame();}
      
      if((ui.highscoreButton.isMouseOver() && !ui.showHighscoreTable) ||
          (ui.returnButton.isMouseOver() && ui.showHighscoreTable)) {ui.showHighscoreTable = !ui.showHighscoreTable;}
      
      if(ui.exitButton.isMouseOver() && !ui.showHighscoreTable) {closeGame();}

      break;
    }
    case 1: { //-------[ character selection ]-------

      break;
    }
    case 2: { //-------[ game ]-------
      break;
    }
    case 3: { //-------[ game over ]-------     

      break;
    }
  }
}

void mouseReleased() {
  if(mouseButton == LEFT) {leftClickDown = false;}
  if(mouseButton == RIGHT) {rightClickDown = false;}
}

void keyPressed() {
 if(key == 'm') {pj.money += 100;} 
}

void startGame() {
  gameState = 2; // Game scene
}

void closeGame() {
  hsManager.saveValuesToFile();
  exit();
} 
