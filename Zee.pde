float zeeVariatie = 0;
float zeeRandomVariatie = 10;
float zeeNiveau = 0;
int zeeKleur = #006994;

// Tekent een instantie van de zee,
// maakt het mogelijk de zee te tilen als het scherm groter wordt
void tekenZeeInstantie(float x, float y, float golfAfstand) {
  // Geef de golven een kleurtje
  imageMode(CORNER);
  tint(zeeKleur);
  fill(zeeKleur);

  // Teken de drie golven over elkaar op basis van de golfAfstand
  image(golfImages[2], x, y - golfAfstand);
  image(golfImages[1], x, y + golfAfstand);
  image(golfImages[0], x, y - golfAfstand * 2);

  // Maak de zee af tot de bodem van het scherm met een rect
  noStroke();
  rect(x, y + golfImages[0].height - golfAfstand - 10, width, height);
}

void tekenZee() {
  // Bereken de variatie in de hoogte van een golf,
  // dit wordt smooth gedaan door de lerp functie
  zeeVariatie = lerp(zeeVariatie, zeeRandomVariatie, 0.03);
  if(int(zeeVariatie) == int(zeeRandomVariatie / 1.5)) {
    zeeRandomVariatie = -zeeRandomVariatie;
  }

  // Bereken hoevaak de zee getekend moet worden op basis van
  // de breedte van een golf
  int keerHerhalen = ceil(width / (float) golfImages[0].width);
  
  // Teken de instanties van de zee :)
  for(int i = 0; i < keerHerhalen; i++) {
    float golfX = golfImages[0].width * i;
    tekenZeeInstantie(golfX, zeeNiveau, zeeVariatie);
  }
}