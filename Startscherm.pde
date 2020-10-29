final int daySkyColor = #b3e5fc;

int[] uiStaat = new int[2];
int[] mijnOpties = {5, 10, 20, 50, 100};
int[] schatOpties = {5, 10, 20, 50, 100};

int titelOndoorzichtigheid = 0;

void tekenTitel() {
  if(titelOndoorzichtigheid < 255) {
    titelOndoorzichtigheid += 5;
  }

  textAlign(CENTER, CENTER);

  fill(#FFFFFF, titelOndoorzichtigheid);
  textSize(REM * 2);
  text("Dive for Treasure", width / 2, UI_GROOTTE * 50);

  fill(#FFFFFF, titelOndoorzichtigheid / 1.5);
  textSize(REM * 1.5);
  text("door Vincent Brouwer", width / 2, UI_GROOTTE * 80);
}

void setupStartScherm() {
  zeeNiveau = round(height * 0.4);
  versprijdWolken(0, 0, width, int(zeeNiveau) - 50, 10);
}

void tekenStartScherm() {
  background(daySkyColor);
  tekenTitel();

  tekenZee();
  tekenWolken();

  boolean startSpel = tekenKnop("start spel!", int(width * 0.5 - 75), int(height * 0.75), 150, 75, false);
  int padding = int(width / 6 * UI_GROOTTE);
  
  uiStaat[0] = tekenWisselschakelaar(mijnOpties, padding, int(height * 0.25), int(width - padding * 2), 50, uiStaat[0]);
  uiStaat[1] = tekenWisselschakelaar(schatOpties, padding, int(height * 0.25) + 75, int(width - padding * 2), 50, uiStaat[1]);

  if(mousePressed) {
    if(startSpel) {
      setupSpelScherm();
      actiefScherm = Scherm.SPEL;
    }
  }
}