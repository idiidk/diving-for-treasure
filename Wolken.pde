int[][] wolken;
int[] wolkGebied = new int[4];

// Versprijd de wolken binnen een specifiek gebied
void versprijdWolken(int x1, int y1, int x2, int y2, int hoeveelheid) {
  wolken = new int[hoeveelheid][];
  wolkGebied[0] = x1;
  wolkGebied[1] = y1;
  wolkGebied[2] = x2;
  wolkGebied[3] = y2;

  for(int i = 0; i < hoeveelheid; i++) {
    // Random positie binnen regio
    int wolkX = int(random(x1, x2));
    int wolkY = int(random(y1, y2));
    int wolkImageIndex = int(random(0, wolkImages.length));

    // Voeg de wolk toe aan de lijst met wolken
    int[] wolkData = { wolkX, wolkY, wolkImageIndex, int(random(1, 3)) };
    wolken[i] = wolkData;
  }
}

void tekenWolken() {
  tint(255, 128);
  // Loop over de verspreide wolken en teken ze
  for(int i = 0; i < wolken.length; i++) {
    int[] wolkData = wolken[i];
    PImage wolkImage = wolkImages[wolkData[2]];

    image(wolkImage, wolkData[0], wolkData[1]);

    // Beweeg de wolk naar rechts door de x positie te vergroten
    wolkData[0] += wolkData[3];

    // Als de wolk buiten het scherm valt wordt de x positie gereset
    // de wolk image veranderd ook om het interessant te houden
    if(wolkData[0] > width) {
      // Zet de x naar een random x van 0 tot 50 van het scherm af
      wolkData[0] = -wolkImage.width - int(random(50));
      // Zet de y naar een random y in het gebied 
      wolkData[1] = int(random(wolkGebied[1], wolkGebied[3]));
      // Verander de wolkImage om het interressant te houden ;)
      wolkData[2] = int(random(0, wolkImages.length));
    }

    // Update de wolk
    wolken[i] = wolkData;
  }
}

