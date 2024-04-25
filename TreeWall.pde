class TreeWall {
  PImage treeImage;
  PVector pos;
  int health;
  int maxHealth;
  boolean alive;
  HealthBar healthBar;

  TreeWall(float p_x, float p_y) {
    treeImage = loadImage("Tree.png");
    treeImage.resize(55, 70);
    pos = new PVector(p_x,p_y);
    maxHealth = 100;
    health = maxHealth;
    alive = true;
    healthBar = new HealthBar(this, p_x, p_y - 10, 50, 5);
  }

  void display() {
    image(treeImage, pos.x, pos.y);
    if(alive) {healthBar.display();}
  }

  void takeDamage(int damage) {
    health -= damage;
    if(health <= 0) {alive = false;}
  }
}

class HealthBar {
  PVector healthBarPos;
  float w, h;
  TreeWall tree;

  HealthBar(TreeWall p_tree, float p_x, float p_y, float p_w, float p_h) {
    tree = p_tree;
    healthBarPos = new PVector(p_x, p_y);
    w = p_w;
    h = p_h;
  }

  void display() {
    // Dibuja el fondo de la barra de vida
    fill(255);
    rect(healthBarPos.x, healthBarPos.y, w, h);

    // Calcula la longitud de la barra de vida en función de la salud actual
    float healthLength = map(tree.health, 0, tree.maxHealth, 0, w);

    // Dibuja la barra de vida
    fill(0, 255, 0); // Verde
    rect(healthBarPos.x, healthBarPos.y, healthLength, h);
  }
}
