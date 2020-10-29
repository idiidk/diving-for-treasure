void tekenEindScherm() {
  zeeNiveau = int(lerp(zeeNiveau, height + 20, 0.03));

  tekenZee();
  fill(zeeKleur);
  
  textSize(REM * 2.5);
  text("GAME OVER", width / 2, height / 2 - UI_GROOTTE * 50);
  
  textSize(REM * 1.75);
  text("je score was: " + duikerScore, width / 2, height / 2);

  rect(width / 2 - 150, int(height / 2 + UI_GROOTTE * 50), 300, 75);

  if(tekenKnop("speel opnieuw!", width / 2 - 150, int(height / 2 + UI_GROOTTE * 50), 300, 75, false) && mousePressed) {
    resetDuiker(true);
    actiefScherm = Scherm.START;
  }
}