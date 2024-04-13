class TreeWall {
  PImage treeImage;
  float x, y;
  int health;
  int maxHealth;
  boolean alive;
  HealthBar healthBar;

  TreeWall(float x, float y) {
    treeImage = loadImage("Tree.png");
    treeImage.resize(40, 55);
    this.x = x;
    this.y = y;
    maxHealth = 100;
    health = maxHealth;
    alive = true;
    healthBar = new HealthBar(this, x, y - 10, 50, 5);
  }

  void display() {
    image(treeImage, x, y);
    if (alive) {
      healthBar.display();
    }
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      alive = false;
    }
  }

  boolean isAlive() {
    return alive;
  }
}

class HealthBar {
  float x, y;
  float w, h;
  TreeWall tree;

  HealthBar(TreeWall tree, float x, float y, float w, float h) {
    this.tree = tree;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    // Dibuja el fondo de la barra de vida
    fill(255);
    rect(x, y, w, h);

    // Calcula la longitud de la barra de vida en función de la salud actual
    float healthLength = map(tree.health, 0, tree.maxHealth, 0, w);

    // Dibuja la barra de vida
    fill(0, 255, 0); // Verde
    rect(x, y, healthLength, h);
  }
}
