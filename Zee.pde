PImage golf1;
PImage golf2;
PImage golf3;

float zeeVariatie = 0;
float zeeRandomVariatie = 10;
final int zeeKleur = #006994;

// Laad de 3 golven in die samen de zee vormen
void setupZee() {
  golf1 = loadImage("wave_1.png");
  golf2 = loadImage("wave_2.png");
  golf3 = loadImage("wave_3.png");
}

// Tekent een instantie van de zee,
// maakt het mogelijk de zee te tilen als het scherm groter wordt
void tekenZeeInstantie(int x, int y, float golfAfstand) {
  // Geef de golven een kleurtje
  tint(zeeKleur);
  fill(zeeKleur);

  // Teken de drie golven over elkaar op basis van de golfAfstand
  image(golf3, x, y - golfAfstand);
  image(golf2, x, y + golfAfstand);
  image(golf1, x, y - golfAfstand * 2);

  // Maak de zee af tot de bodem van het scherm met een rect
  noStroke();
  rect(x, y + golf1.height - golfAfstand - 10, width, height);
}

void tekenZee(int y) {
  // Bereken de variatie in de hoogte van een golf,
  // dit wordt smooth gedaan door de lerp functie
  zeeVariatie = lerp(zeeVariatie, zeeRandomVariatie, 0.03);
  if(round(zeeVariatie) == round(zeeRandomVariatie / 1.5)) {
    zeeRandomVariatie = -zeeRandomVariatie;
  }

  // Bereken hoevaak de zee getekend moet worden op basis van
  // de breedte van een golf
  int keerHerhalen = ceil(width / (float) golf1.width);
  
  // Teken de instanties van de zee :)
  for(int i = 0; i < keerHerhalen; i++) {
    int golfX = golf1.width * i;
    tekenZeeInstantie(golfX, y, zeeVariatie);
  }
}