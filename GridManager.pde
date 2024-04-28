enum ItemType {
    TREE(50, "Tree.png", 55, 70),
    MINE(100, "GoldMine.png", 70, 55),
    ARCHER(70, "Archer.png", 33, 33);
    
    int cost;
    String spriteName;
    int spriteWidth;
    int spriteHeight;
    
    ItemType(int cost, String spriteName, int spriteWidth, int spriteHeight) {
        this.cost = cost;
        this.spriteName = spriteName;
        this.spriteWidth = spriteWidth;
        this.spriteHeight = spriteHeight;
    }
}

class GridManager {
  final int rows; 
  final int cols; 
  final int cellSize; 
  int[][] grid; 
  boolean[][] ocupedCells;
  int selectedRow;
  int selectedCol;
  ArrayList<TreeWall> treeList;
  ArrayList<GoldMine> goldMineList;
  ArrayList<ArcherTower> archerTowerList;

  PImage shadowSprite;
  boolean placingItem;
  
  boolean gridLocked;
  int lockDuration;
  int lastLockTime;

  boolean selectedTree;
  boolean selectedMine;
  boolean selectedArcher;

  GridManager() {
    rows = 15;
    cols = 15;
    cellSize = 64;
    selectedRow = -1;
    selectedCol = -1;
    lockDuration = 500;
    lastLockTime = 0;

    grid = new int[rows][cols];
    ocupedCells = new boolean[rows][cols];
    treeList = new ArrayList<TreeWall>();
    goldMineList = new ArrayList<GoldMine>();
    archerTowerList = new ArrayList<ArcherTower>();
    
    selectedTree = false;
    selectedMine = false;
    selectedArcher = false;
    gridLocked = false;
    placingItem = false;

    // Initializes the grid with default values (0 for empty spaces)
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {grid[i][j] = 0;}
    }
  }

  void update() {
     if (gridLocked && millis() - lastLockTime >= lockDuration) {
        gridLocked = false;
    }

    if (leftClickDown) {
        checkItemToInsert();
        gridManagement();
    }
    
    updateMines();
    updateArchers();
    updateTrees();
  }

  void display() {    
    //Draw items
    displayItems();
    
    //Grid
    for(int i = 0; i < rows; i++) {
      for(int j = 0; j < cols; j++) {
        strokeWeight(1);
        noFill();
        rectMode(CORNER);
        rect(j * cellSize, i * cellSize, cellSize, cellSize);
        
        //Selected cell
        if (i == selectedRow && j == selectedCol) {
          strokeWeight(2);
          rect(j * cellSize, i * cellSize, cellSize, cellSize);
        }
      }
    }
  }

  void updateMines() {
    for (GoldMine goldMine : goldMineList){
      if(!goldMine.isAlive){ removeItem(goldMine.gridRow, goldMine.gridCol); }
    }
    goldMineList.removeIf(mine -> !mine.isAlive);
    goldMineList.forEach(GoldMine::update);
  }

  void updateArchers() {
    for (ArcherTower archerTower : archerTowerList){
      if(!archerTower.isAlive) {removeItem(archerTower.gridRow, archerTower.gridCol);}
    }
    archerTowerList.removeIf(archer -> !archer.isAlive);
    archerTowerList.forEach(ArcherTower::update);
  }
  
  void updateTrees() {
    for(TreeWall treeWall : treeList){
      if(!treeWall.isAlive){ removeItem(treeWall.gridRow, treeWall.gridCol); }
    }
    treeList.removeIf(tree -> !tree.isAlive);
  }
  
  void gridManagement() {
      int row = mouseY / cellSize;
      int col = mouseX / cellSize;
      
      if(isValidCell(row, col)) {
          if(!ocupedCells[row][col] && !gridLocked && canPlaceItems()) {
              placeItem(row, col);
          }
      }
  }
  
  void placeItem(int row, int col) {
      int cost = 0;
      if (selectedTree) {
          treeList.add(new TreeWall(col * cellSize + 6, row * cellSize,row, col));
          cost = ItemType.TREE.cost;
      } else if (selectedMine) {
          goldMineList.add(new GoldMine(col * cellSize - 2, row * cellSize,row, col));
          cost = ItemType.MINE.cost;
      } else if (selectedArcher) {
          archerTowerList.add(new ArcherTower(col * cellSize + 33, row * cellSize + 33,row, col));
          cost = ItemType.ARCHER.cost;
      }
      ocupedCells[row][col] = true;
      pj.money -= cost;
      selectedTree = false;
      selectedMine = false;
      selectedArcher = false;
      placingItem = false;
      shadowSprite = null;
  }
  
  void checkItemToInsert() {
      if (ui.treeButton.isMouseOver() && pj.money >= ItemType.TREE.cost) {
          selectItem(ItemType.TREE, "Tree.png", 55, 70);
      } else if (ui.goldButton.isMouseOver() && pj.money >= ItemType.MINE.cost) {
          selectItem(ItemType.MINE, "GoldMine.png", 70, 55);
      } else if (ui.archerButton.isMouseOver() && pj.money >= ItemType.ARCHER.cost) {
          selectItem(ItemType.ARCHER, "Archer.png", 55, 60);
      }
  }
  
  void selectItem(ItemType type, String spriteName, int spriteWidth, int spriteHeight) {
      if (!gridLocked) {
          gridLocked = true;
          lastLockTime = millis();
      }
      selectedTree = type == ItemType.TREE;
      selectedMine = type == ItemType.MINE;
      selectedArcher = type == ItemType.ARCHER;
      shadowSprite = loadImage(spriteName);
      shadowSprite.resize(spriteWidth, spriteHeight);
      placingItem = true;
  }

  void displayItems() {
    for(TreeWall tree : treeList) {tree.display();}
    for(GoldMine mine : goldMineList) {mine.display();}
    for(ArcherTower archer : archerTowerList) {archer.display();}
    
    if(placingItem && shadowSprite != null) { // Only show the shadow if there is a shadow image defined
      int row = mouseY / cellSize;
      int col = mouseX / cellSize;
      float shadowX = col * cellSize - (cellSize - shadowSprite.width - 65) / 2; // Calculate the X position of the shadow
      float shadowY = row * cellSize - (cellSize - shadowSprite.height - 70) / 2; // Calculate the Y position of the shadow
      imageMode(CENTER);
      image(createShadow(shadowSprite), shadowX, shadowY);
    }
  }
  
  void removeItem(int row, int col) {
    grid[row][col] = 0;
    ocupedCells[row][col] = false;
  }

  PImage createShadow(PImage originalImage) {
    PImage shadowImage = createImage(originalImage.width, originalImage.height, ARGB); // // Create a new image of the same size
    float[] lut = createOpacityLUT(); // Create a lookup table to adjust opacity

    // Apply the lookup table to the original image to create the shadow
    originalImage.loadPixels();
    shadowImage.loadPixels();
    for (int i = 0; i < originalImage.pixels.length; i++) {
      int c = originalImage.pixels[i];
      int a = (int) alpha(c);
      int newA = (int) (a * lut[a]); // Adjust opacity using lookup table
      shadowImage.pixels[i] = color(red(c), green(c), blue(c), newA); // Keep the original color components and adjust only the opacity
    }
    shadowImage.updatePixels();

    return shadowImage;
  }

  float[] createOpacityLUT() {
    float[] lut = new float[256]; // Create a lookup table with 256 values (0-255)
    float opacityFactor = 0.5; // Opacity factor for shadow
    for (int i = 0; i < 256; i++) {
      lut[i] = i / 255.0 * opacityFactor; // Adjust opacity based on original pixel value
    }
    return lut;
  }
  
  boolean isValidCell(int row, int col) {
    return row >= 0 && row < rows && col >= 0 && col < cols;
  }

  boolean canPlaceItems() {
    return selectedMine || selectedTree || selectedArcher;
  }  
}
