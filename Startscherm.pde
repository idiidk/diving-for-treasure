final int daySkyColor = #b3e5fc;

int[] uiStaat = new int[2];
int[] mijnOpties = {5, 10, 20, 50, 100};
int[] schatOpties = {5, 10, 20, 50, 100};

int titelOndoorzichtigheid = 0;
int startZeeNiveau = 0;

void tekenTitel() {
  if(titelOndoorzichtigheid < 255) {
    titelOndoorzichtigheid += 5;
  }

  textAlign(CENTER, CENTER);

  fill(#000000, titelOndoorzichtigheid);
  textSize(REM * 3);
  text("Dive for Treasure", width / 2, UI_GROOTTE * 50);

  fill(#000000, titelOndoorzichtigheid / 1.5);
  textSize(REM * 1.75);
  text("door Vincent Brouwer", width / 2, UI_GROOTTE * 100);
}

void setupStartScherm() {
  zeeNiveau = height + 20;
  startZeeNiveau = round(height * 0.4);
  versprijdWolken(0, 0, width, startZeeNiveau - 50, 10);
}

void tekenStartScherm() {
  background(daySkyColor);
  tekenTitel();

  zeeNiveau = int(lerp(zeeNiveau, startZeeNiveau, 0.03));

  tekenZee();
  tekenWolken();

  boolean startSpel = tekenKnop("start spel!", width * 0.5 - 100, height * 0.75, 200, 75, false);
  int padding = int(width / 5 * UI_GROOTTE);
  
  textAlign(TOP, LEFT);
  fill(#000000, 100);
  text("Aantal mijnen", padding, UI_GROOTTE * 200);
  uiStaat[0] = tekenWisselschakelaar(mijnOpties, padding, UI_GROOTTE * 220, width - padding * 2, 50, uiStaat[0]);
  
  textAlign(TOP, LEFT);
  fill(#000000, 100);
  text("Aantal schatten", padding, UI_GROOTTE * 320);
  uiStaat[1] = tekenWisselschakelaar(schatOpties, padding, UI_GROOTTE * 340, width - padding * 2, 50, uiStaat[1]);

  if(mousePressed) {
    if(startSpel) {
      setupSpelScherm();
      actiefScherm = Scherm.SPEL;
    }
  }
}