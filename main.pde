//-------[ variables ]-------
Utilities utilities;
GridManager gridManager;
CollisionManager colManager;

//game control
int gameState = 0;
boolean isClicked;
PImage mouseSprite; 

//entities
Player pj;

void setup() {
  size(900, 900);
  
  mouseSprite = loadImage("mouse.png");
  noCursor();
  
  utilities = new Utilities();
  colManager = new CollisionManager();
  gridManager = new GridManager();
 
  //initialize entites
  pj = new Player();
  
  gameState = 1;
}

void draw() {
  background(128);
  
  switch(gameState) {
    default: break;
    case 0: { //-------[ main menu loop ]-------
      break;
    }
    case 1: { //-------[ main scene loop ]-------
      //entites update
      pj.update();
      gridManager.update();
      
      //draw entities
      pj.display();
      gridManager.display();
      
      break;
    }
  }
  
  image(mouseSprite, mouseX, mouseY);
}

//Draw rectangle using its vertex


void mousePressed() {
  isClicked = true;
}

void mouseReleased(){
  isClicked = false;
}
