void setupSpelScherm() {
  targetBootX = int(random(0, width / 2));
  duikerX = targetBootX;

  versprijdGridItems(mijnOpties[uiStaat[0]], schatOpties[uiStaat[1]]);
}

void tekenSpelScherm() {
  background(daySkyColor);

  if(zeeNiveau != 100) {
    zeeNiveau = int(lerp(zeeNiveau, 100, 0.03));
    resetDuiker(false);
  }

  tekenWolken();
  tekenZee();
  tekenBoot();
  tekenGrid(0, zeeNiveau + golfImages[0].height, width, zeeNiveau + (height - zeeNiveau));
  tekenDuiker();
  
  tekenStatus();
}

void tekenStatus() {
  textAlign(LEFT, LEFT);
  fill(#000000);
  text("Score: " + duikerScore, 25 * UI_GROOTTE, 50 * UI_GROOTTE);
  text("Levens: " + duikerLevens, 25 * UI_GROOTTE, 75 * UI_GROOTTE);
  text("Schatten in bezit: " + duikerSchatten, 25 * UI_GROOTTE, 100 * UI_GROOTTE);
}