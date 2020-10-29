float bootX = 0;
int bootY = 0;
int targetBootX = 0;
int bootKleur = #FFFFFF;

void tekenBoot() {
  imageMode(CORNER);
  bootY = int(zeeNiveau - 50 + zeeVariatie * 0.75);

  // Teken de boot
  tint(bootKleur);
  image(bootImage, bootX, bootY);

  // Beweeg de boot soepel naar de target positie
  // wanneer de boot hier aankomt wordt er een nieuwe 
  // target positie gegenereerd
  bootX = lerp(bootX, targetBootX, 0.005);

  if(round(targetBootX) == round(bootX)) {
    targetBootX = int(random(0, width - bootImage.width));
  }
}