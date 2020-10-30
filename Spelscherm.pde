void setupSpelScherm() {
  versprijdGridItems(mijnOpties[uiStaat[0]], schatOpties[uiStaat[1]]);
  resetDuiker(true);

  targetBootX = int(random(0, width / 2));
  duikerX = targetBootX;
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
  tekenPiranha();
  
  tekenStatus();
}

void tekenStatus() {
  textAlign(LEFT, LEFT);
  fill(#000000);
  text("Score: " + duikerScore, 25 * UI_GROOTTE, 50 * UI_GROOTTE);
  text("Levens: " + duikerLevens, 25 * UI_GROOTTE, 75 * UI_GROOTTE);
  text("Schatten in bezit: ", 25 * UI_GROOTTE, 100 * UI_GROOTTE);

  for(int i = 0; i < duikerSchatten.length; i++) {
    int itemId = duikerSchatten[i];
    PImage schatImage = itemImages[itemId];

    if(i < 4) {
      image(schatImage, 25 * UI_GROOTTE * (i + 1) + schatImage.width * i, 125 * UI_GROOTTE);
    } else if(i == 5) {
      textAlign(CENTER, CENTER);
      fill(#000000);
      text("+" + (duikerSchatten.length - 5), 20 * UI_GROOTTE * i + schatImage.width * i, 140 * UI_GROOTTE);
    }
  }
}