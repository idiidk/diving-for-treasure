int gridItemGrootte = 32;
int gridBreedte = 60;
int gridHoogte = 40;

int[][] items = new int[gridBreedte][gridHoogte];

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
  }

  for(int i = 0; i < aantalSchatten; i++) {
    int id = int(random(1, itemImages.length));
    voegItemToe(id);
  }
}

void resetGridItems() {
  for(int x = 0; x < gridBreedte; x++) {
    for(int y = 0; y < gridHoogte; y++) {
      items[x][y] = -1;
    }
  }
}

void tekenGrid(int x1, int y1, int x2, int y2) {
  imageMode(CENTER);
  fill(#FF0000);

  x1 += gridItemGrootte;
  x2 -= gridItemGrootte;
  y1 += gridItemGrootte * 2;
  y2 -= gridItemGrootte * 2;
  
  int breedte = x2 - x1;
  int hoogte = y2 - y1;

  int xStapGrootte = breedte / gridBreedte;
  int yStapGrootte = hoogte / gridHoogte;
  
  for(int x = 0; x < gridBreedte; x++) {
    for(int y = 0; y < gridHoogte; y++) {
      int itemId = items[x][y];
      if(itemId == -1) continue;

      int itemX = x1 + x * xStapGrootte;
      int itemY = y1 + y * yStapGrootte;
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