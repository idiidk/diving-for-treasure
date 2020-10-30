float piranhaSnelheid = 0.25;
ArrayList<PVector> piranhaPosities = new ArrayList<PVector>();

void tekenPiranha() {
  for(int i = 0; i < piranhaPosities.size(); i++) {
    PVector piranhaPositie = piranhaPosities.get(i);

    tint(#FFFFFF, 128);
    image(piranhaImage, piranhaPositie.x, piranhaPositie.y);
    
    float xPlus = piranhaPositie.x > duikerX ? -piranhaSnelheid : piranhaSnelheid;
    float yPlus = piranhaPositie.y > duikerY ? -piranhaSnelheid : piranhaSnelheid;

    piranhaPositie.x += xPlus;
    piranhaPositie.y += yPlus;

    checkKannibalisme(piranhaPositie, i);

    if(piranhaPositie.dist(new PVector(duikerX, duikerY)) < 35) {
      piranhaPositie.x = duikerX;
      piranhaPositie.y = duikerY; 
      duikerLevens--;
      resetDuiker(false);
    }
  }
}

void checkKannibalisme(PVector piranhaPositie, int actieveIndex) {
  for(int i = 0; i < piranhaPosities.size(); i++) {
    if(i == actieveIndex) continue;

    PVector vriendPositie = piranhaPosities.get(i);
    
    float afstand = piranhaPositie.dist(vriendPositie);
    if(afstand < 35) {
      piranhaPositie = vriendPositie;
      piranhaPosities.remove(i);
    }
  }
}