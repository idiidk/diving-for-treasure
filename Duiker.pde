enum Richting {
  NEUTRAAL,
  LINKS,
  RECHTS,
  OMHOOG,
  OMLAAG
}

float duikerX = 0;
float duikerY = 75;
float duikerSnelheid = 1.25;
float duikerZuurstofGebruik = 0.0005; // per frame

Richting duikerXRichting = Richting.NEUTRAAL;
Richting duikerYRichting = Richting.NEUTRAAL;

int duikerLevens = 0;
int duikerScore = 0;
int duikerSchatten = 0;
float duikerZuurstof = 1;

boolean duikerPakt = false;

void tekenDuiker() {
  imageMode(CORNER);
  tint(#FFFFFF);

  beweegDuiker();

  pushMatrix();
  switch(duikerXRichting) {
    case LINKS:
    case NEUTRAAL:
      scale(-1.0, 1.0);
      image(duikerImage, -duikerX - duikerImage.width, duikerY);
      break;
    case RECHTS:
      image(duikerImage, duikerX, duikerY);
      break;
  }
  popMatrix();

  tekenZuurstofBalk();

  if(duikerLevens < 0) {
    actiefScherm = Scherm.EIND;
  }
}

void tekenZuurstofBalk() {
  int size = 10;

  fill(#FFFFFF);
  rect(duikerX - 2, duikerY - 2 - size, duikerImage.width + 4, size + 4);

  fill(#FF00FF);
  rect(duikerX, duikerY - size, duikerImage.width * duikerZuurstof, size);

  if(verliestDuikerZuurstof()) {
    duikerZuurstof -= duikerZuurstofGebruik;

    if(duikerZuurstof < 0) {
      resetDuiker(false);
      duikerLevens--;
    }
  } else {
    duikerZuurstof = 1;

    if(duikerSchatten > 0) {
      duikerScore += duikerSchatten * 50;
      duikerSchatten = 0;
    }
  }
}

void resetDuiker(boolean volledig) {
  duikerY = zeeNiveau + golfImages[0].height;
  duikerYRichting = Richting.NEUTRAAL;
  duikerXRichting = Richting.NEUTRAAL;
  duikerZuurstof = 1;
  duikerSchatten = 0;

  if(volledig) {
    duikerLevens = 3;
    duikerScore = 0;
  }
}

void beweegDuiker() {
  if(!magDuikerRichtingOp(duikerYRichting)) {
    zetDuikerYRichting(Richting.NEUTRAAL);
  }

  if(!magDuikerRichtingOp(duikerXRichting)) {
    zetDuikerXRichting(Richting.NEUTRAAL);
  }

  switch(duikerXRichting) {
    case LINKS:
      duikerX -= duikerSnelheid;
      break;
    case RECHTS:
      duikerX += duikerSnelheid;
      break;
  }

  switch(duikerYRichting) {
    case OMHOOG:
      duikerY -= duikerSnelheid;
      break;
    case OMLAAG:
      duikerY += duikerSnelheid;
      break;
  }
}

void verwerkDuikerItemAanraking(int gridX, int gridY, int itemId) {
  switch(itemId) {
    case 0: //MIJN
      items[gridX][gridY] = -1;
      duikerLevens--;
      resetDuiker(false);
      break;
    case 1: //KIST EN MUNT
    case 2:
      if(duikerPakt) {
        duikerSchatten++;
        items[gridX][gridY] = -1;
        duikerPakt = false;
      }
      break;
  }
}

// Of de duiker naar boven of naar beneden kan duiken
boolean kanDuikerDuiken() {
  return duikerYRichting == Richting.NEUTRAAL;
}

boolean verliestDuikerZuurstof() {
  return duikerY > zeeNiveau + golfImages[0].height;
}

boolean magDuikerRichtingOp(Richting richting) {
  switch(richting) {
    case OMHOOG:
      return duikerY + 1 >= zeeNiveau + golfImages[0].height;
    case OMLAAG:
      return duikerY + duikerImage.height - 1 <= height;
    case LINKS:
      return duikerX - 1 > 0;
    case RECHTS:
      return duikerX + 1 < width;
    case NEUTRAAL:
      return true;
    default:
      return false;
  }
}

void zetDuikerXRichting(Richting richting) {
  if(magDuikerRichtingOp(richting)) {
    duikerXRichting = richting;
  }
}

void zetDuikerYRichting(Richting richting) {
  if(magDuikerRichtingOp(richting)) {
    duikerYRichting = richting;
  }
}

void keyReleasedDuiker() {
  switch(keyCode) {
    case LEFT:
      if(duikerXRichting != Richting.LINKS) return;
      zetDuikerXRichting(Richting.NEUTRAAL);
      break;
    case RIGHT:
    if(duikerXRichting != Richting.RECHTS) return;
      zetDuikerXRichting(Richting.NEUTRAAL);
      break;
    case 32:
      duikerPakt = false;
      break;
  }
}

void keyPressedDuiker() {
  switch(keyCode) {
    case UP:
      if(!kanDuikerDuiken()) return;
      zetDuikerYRichting(Richting.OMHOOG);
      break;
    case DOWN:
      if(!kanDuikerDuiken()) return;
      zetDuikerYRichting(Richting.OMLAAG);
      break;
    case LEFT:
      zetDuikerXRichting(Richting.LINKS);
      break;
    case RIGHT:
      zetDuikerXRichting(Richting.RECHTS);
      break;
    case 32:
      duikerPakt = true;
      break;
  }
}

boolean raaktDuikerItemAan(int itemX, int itemY) {
  int itemFixedX = itemX - gridItemGrootte / 2;
  int itemFixedY = itemY - gridItemGrootte / 2;

  return duikerX < itemFixedX + gridItemGrootte &&
         duikerX + duikerImage.width > itemFixedX &&
         duikerY < itemFixedY + gridItemGrootte &&
         duikerY + duikerImage.height > itemFixedY;
}