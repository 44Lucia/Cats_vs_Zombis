//-------[ variables ]-------
Utilities utilities;

//game control
int gameState = 0;
boolean isClicked;

//entities
Player pj;
GridManager gridManager;

void setup() {
  size(900, 900);
 
  //initialize entites
  utilities = new Utilities();
  pj = new Player();
  gridManager = new GridManager();
  
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
}


void mousePressed() {
  isClicked = true;
}

void mouseReleased(){
  isClicked = false;
}
