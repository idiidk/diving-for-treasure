int gridItemGrootte = 32;
int gridBreedte = 60;
int gridHoogte = 40;
int gridEmptyCount = 0;

int[][] items = new int[gridBreedte][gridHoogte];
int[] itemScores = {0, 0, 50, 100};

void voegItemToe(int id) {
  int x = int(random(0, gridBreedte));
  int y = int(random(0, gridHoogte));

  if(items[x][y] != -1) voegItemToe(id);
  items[x][y] = id;
}

void versprijdGridItems(int aantalMijnen, int aantalSchatten) {
  resetGridItems();
  zetGridItemGrootte(gridItemGrootte);

  for(int i = 0; i < aantalMijnen; i++) {
    voegItemToe(0);
    gridEmptyCount++;
  }

  for(int i = 0; i < aantalSchatten; i++) {
    int id = int(random(2, itemImages.length));
    voegItemToe(id);
  }

  for(int i = 0; i < int(aantalSchatten / 2); i++) {
    voegItemToe(1);
    piranhaPosities.add(new PVector(random(0, width), random(zeeNiveau + golfImages[0].height, height)));
  }
}

void resetGridItems() {
  gridEmptyCount = 0;

  for(int x = 0; x < gridBreedte; x++) {
    for(int y = 0; y < gridHoogte; y++) {
      items[x][y] = -1;
      gridEmptyCount++;
    }
  }
}

void tekenGrid(float x1, float y1, float x2, float y2) {
  imageMode(CENTER);
  fill(#FF0000);

  x1 += gridItemGrootte;
  x2 -= gridItemGrootte;
  y1 += gridItemGrootte * 2;
  y2 -= gridItemGrootte * 2;
  
  float breedte = x2 - x1;
  float hoogte = y2 - y1;

  float xStapGrootte = breedte / gridBreedte;
  float yStapGrootte = hoogte / gridHoogte;

  gridEmptyCount = 0;
  
  for(int x = 0; x < gridBreedte; x++) {
    for(int y = 0; y < gridHoogte; y++) {
      int itemId = items[x][y];
      switch(itemId) {
        case -1: // NIKS
        case 0: // BOM
        case 1: // ZUURSTOF
          gridEmptyCount++;
          break;
      }

      if(itemId == -1) continue;

      float itemX = x1 + x * xStapGrootte;
      float itemY = y1 + y * yStapGrootte;
      tint(#FFFFFF, 128);

      if(raaktDuikerItemAan(itemX, itemY)) {
        verwerkDuikerItemAanraking(x, y, itemId);
      }
      image(itemImages[itemId], itemX, itemY);
    }
  }
}

void zetGridItemGrootte(int grootte) {
  for(int i = 0; i < itemImages.length; i++) {
    itemImages[i].resize(grootte, grootte);
  }
}