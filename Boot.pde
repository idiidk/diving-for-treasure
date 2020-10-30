float bootX = 0;
float bootY = 0;
float targetBootX = 0;
int vaarCount = 0;
int bootKleur = #FFFFFF;

void tekenBoot() {
  imageMode(CORNER);
  bootY = zeeNiveau - 50 + zeeVariatie * 0.75;

  // Teken de boot
  tint(bootKleur);
  image(bootImage, bootX, bootY);

  // Beweeg de boot soepel naar de target positie
  // wanneer de boot hier aankomt wordt er een nieuwe 
  // target positie gegenereerd
  float speed = width * 0.000001;
  bootX = lerp(bootX, targetBootX, speed);

  if(vaarCount > 100) {
    targetBootX = random(0, width - bootImage.width);
    vaarCount = 0;
  }

  vaarCount++;
}