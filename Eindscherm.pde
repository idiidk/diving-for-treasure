void tekenEindScherm() {
  tekenZee();

  boolean levelGehaald = duikerLevens >= 0;
  zeeNiveau = lerp(zeeNiveau, height + 20, 0.03);
  
  textSize(REM * 2.5);
  text(levelGehaald ? "LEVEL GEHAALD!" : "GAME OVER", width / 2, height / 2 - UI_GROOTTE * 50);
  
  textSize(REM * 1.75);
  text("je score was: " + duikerScore, width / 2, height / 2);

  rect(width / 2 - 150, height / 2 + UI_GROOTTE * 50, 300, 75);

  if(tekenKnop("speel opnieuw!", width / 2 - 150, height / 2 + UI_GROOTTE * 50, 300, 75, false) && mousePressed) {
    actiefScherm = Scherm.START;
  }
}