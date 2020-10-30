float[][] wolken;
float[] wolkGebied = new float[4];

// Versprijd de wolken binnen een specifiek gebied
void versprijdWolken(float x1, float y1, float x2, float y2, int hoeveelheid) {
  wolken = new float[hoeveelheid][];
  wolkGebied[0] = x1;
  wolkGebied[1] = y1;
  wolkGebied[2] = x2;
  wolkGebied[3] = y2;

  for(int i = 0; i < hoeveelheid; i++) {
    // Random positie binnen regio
    float wolkX = random(x1, x2);
    float wolkY = random(y1, y2);
    float wolkImageIndex = random(0, wolkImages.length);

    // Voeg de wolk toe aan de lijst met wolken
    float[] wolkData = { wolkX, wolkY, wolkImageIndex, random(1, 3) };
    wolken[i] = wolkData;
  }
}

void tekenWolken() {
  tint(255, 128);
  // Loop over de verspreide wolken en teken ze
  for(int i = 0; i < wolken.length; i++) {
    float[] wolkData = wolken[i];
    PImage wolkImage = wolkImages[int(wolkData[2])];

    image(wolkImage, wolkData[0], wolkData[1]);

    // Beweeg de wolk naar rechts door de x positie te vergroten
    wolkData[0] += wolkData[3];

    // Als de wolk buiten het scherm valt wordt de x positie gereset
    // de wolk image veranderd ook om het interessant te houden
    if(wolkData[0] > width) {
      // Zet de x naar een random x van 0 tot 50 van het scherm af
      wolkData[0] = -wolkImage.width - random(50);
      // Zet de y naar een random y in het gebied 
      wolkData[1] = random(wolkGebied[1], wolkGebied[3]);
      // Verander de wolkImage om het interressant te houden ;)
      wolkData[2] = int(random(0, wolkImages.length));
    }

    // Update de wolk
    wolken[i] = wolkData;
  }
}

