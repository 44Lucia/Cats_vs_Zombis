class EnemyManager {

  ArrayList<Torch> torches;
  ArrayList<Tnt> tnts;
  ArrayList<Barry> barries;

  EnemyManager() {
    torches = new ArrayList<Torch>();
    tnts = new ArrayList<Tnt>();
    barries = new ArrayList<Barry>();
  }

  void update() {
    for (int i = 0; i < torches.size(); i++)
      torches.get(i).update();

    for (int i = 0; i < tnts.size(); i++)
      tnts.get(i).update();

    for (int i = 0; i < barries.size(); i++)
      barries.get(i).update();
  }

  void display() {
    for (int i = 0; i < torches.size(); i++) {
      torches.get(i).display();
      torches.get(i).moveTo(mouseX, mouseY);
    }

    for (int i = 0; i < tnts.size(); i++) {
      tnts.get(i).display();
      tnts.get(i).moveTo(mouseX, mouseY);
    }

    for (int i = 0; i < barries.size(); i++) {
      barries.get(i).display();
      barries.get(i).moveTo(mouseX, mouseY);
    }
  }

  void enemyWave(int torches, int tnts, int barries) {
    for (int i = 0; i < torches; i++)
      this.torches.add(new Torch(i * 192, 0));

    for (int i = 0; i < tnts; i++)
      this.tnts.add(new Tnt(i * 192, 192));

    for (int i = 0; i < barries; i++)
      this.barries.add(new Barry(i * 128, 384));
  }
}
