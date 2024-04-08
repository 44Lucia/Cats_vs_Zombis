//-------[ variables ]-------
Utilities utilities;
GridManager gridManager;
CollisionManager colManager;

//game control
int gameState = 0;
boolean isClicked;

//entities
Player pj;

void setup() {
  size(900, 900);
  
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
}

//Draw rectangle using its vertex
void drawRectangle(PVector[] vertices) {
  beginShape();
  for (PVector v : vertices) {
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}

void mousePressed() {
  isClicked = true;
}

void mouseReleased(){
  isClicked = false;
}
