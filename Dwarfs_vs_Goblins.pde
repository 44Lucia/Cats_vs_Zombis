//-------[ variables ]-------
Utilities utilities;
UIManager ui;
GridManager gridManager;
CollisionManager colManager;

//game control
int gameState = 0;
boolean isClicked;
PImage mouseSprite; 
String playerInput;

//entities
Player pj;

void setup() {
  size(960, 960);
  
  mouseSprite = loadImage("mouse.png");
  noCursor();
  
  utilities = new Utilities();
  ui = new UIManager();
  colManager = new CollisionManager();
  gridManager = new GridManager();
 
  //initialize entites
  pj = new Player();
  
  //gameState = 1;
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
      pj.display();
      ui.builderButtonsDisplay();
      
      gridManager.display();
      
      break;
    }
    case 3: { //-------[ game over ]-------     

      break;
    }
  }
  
  imageMode(CORNER);
  image(mouseSprite, mouseX, mouseY);
}

void mousePressed() {
  isClicked = true;
  
  switch(gameState) {
    default: break;
    case 0: { //-------[ main title ]-------
      if(ui.playButton.isMouseOver()) {startGame();}
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

void mouseReleased(){
  isClicked = false;
}

void startGame() {
  gameState = 2; // Game scene
}
