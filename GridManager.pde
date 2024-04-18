class GridManager {
  final int rows; // Número de filas en la cuadrícula
  final int cols; // Número de columnas en la cuadrícula
  final int cellSize; // Tamaño de cada celda de la cuadrícula
  int[][] grid; // Matriz que representa la cuadrícula
  boolean[][] ocupedCells; // Matriz que registra las casillas ocupadas
  int selectedRow;
  int selectedCol;
  ArrayList<TreeWall> treeList;
  ArrayList<GoldMine> goldMineList;

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
    if(gridLocked && millis() - lastLockTime >= lockDuration) {gridLocked = false;}

    if(leftClickDown) {
      checkItemToInsert();
      gridManagement();
    }
    
    //Mines update
    ui.cursorOverGold = false;
    for(GoldMine mine : goldMineList) {
      mine.update();
      if(!ui.cursorOverGold) {mine.cursorOverSomeGold();} // Skip iterations if already triggered a true
    }
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

  void gridManagement() {
    // Calcula la fila y columna seleccionadas en función de la posición del ratón
    int row = mouseY / cellSize;
    int col = mouseX / cellSize;
    // Verifica si la celda seleccionada está dentro de los límites de la cuadrícula
    if (row >= 0 && row < rows && col >= 0 && col < cols) {
      // Verifica si la casilla está ocupada
      if (!ocupedCells[row][col] && !gridLocked && canPlaceItems()) {
        if (selectedTree) {
          treeList.add(new TreeWall(col * cellSize + 6, row * cellSize - 1));
          ocupedCells[row][col] = true;
          pj.money -= 50;
          selectedTree = false;
          placingItem = false;
        } else if (selectedMine) {
          goldMineList.add(new GoldMine(col * cellSize - 2, row * cellSize + 2));
          ocupedCells[row][col] = true;
          pj.money -= 100;
          selectedMine = false;
          placingItem = false;
        }
      }
    }
  }

  void checkItemToInsert() {
    if (ui.treeButton.isMouseOver() && pj.money >= 50) {
      if (!gridLocked) {
        gridLocked = true;
        lastLockTime = millis();
      }

      selectedMine = false;
      selectedTree = true;
      shadowSprite = loadImage("Tree.png");
      shadowSprite.resize(55, 70);
      placingItem = true;
    } else if (ui.goldButton.isMouseOver() && pj.money >= 100) {
      if (!gridLocked) {
        gridLocked = true;
        lastLockTime = millis();
      }

      selectedTree = false;
      selectedMine = true;
      shadowSprite = loadImage("GoldMine.png");
      shadowSprite.resize(70, 55);
      placingItem = true;
    }
  }

  void displayItems() {
    for (TreeWall tree : treeList) {tree.display();}
    for (GoldMine mine : goldMineList) {mine.display();}

    if (placingItem) {
      float shadowX = mouseX - shadowSprite.width / 2;
      float shadowY = mouseY - shadowSprite.height /  2;
      image(createShadow(shadowSprite), shadowX, shadowY);
    }
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

  boolean canPlaceItems() {
    return selectedMine || selectedTree || selectedArcher;
  }
}
