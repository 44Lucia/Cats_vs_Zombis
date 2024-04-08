//-------[ variables ]-------

//game control
int gameState = 0;

//entities
Player pj;

void setup() {
  size(900, 900);
 
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

      //draw entities
      pj.display();
    
      break;
    }
  }
}
