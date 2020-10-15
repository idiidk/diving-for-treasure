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

void tekenStartScherm() {
  background(#b3e5fc);

  tekenTitel();

  int zeeY = round(height * 0.4);
  tekenZee(zeeY);
  tekenWolken(0, 0, width, zeeY - 50);
}