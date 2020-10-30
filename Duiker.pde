enum Richting {
  NEUTRAAL,
  LINKS,
  RECHTS,
  OMHOOG,
  OMLAAG
}

float duikerX = 0;
float duikerY = 75;
float duikerSnelheid = 1.5; // de waarde die aan de x en y positie wordt toegevoegd per frame
float duikerZuurstofGebruik = 0.00075; // zuurstof gebruik per frame

Richting duikerXRichting = Richting.NEUTRAAL; // de richting die de duiker op de x as beweegt
Richting duikerYRichting = Richting.NEUTRAAL; // de richting die de duiker op de y as beweegt

int duikerLevens = 3; // de levens die de duiker heeft
int duikerScore = 0; // de score die de duiker heeft
int[] duikerSchatten = new int[0]; // de schatten die de duiker heeft
float duikerZuurstof = 1; // het zuurstofniveau van de duiker 0.0-1.0

boolean duikerPakt = false; // of de duiker een object aan het pakken is

void tekenDuiker() {
  imageMode(CORNER);
  tint(#FFFFFF);

  // verwerk beweging van de duiker
  beweegDuiker();

  // flip de image als de duiker naar links beweegt
  //
  // https://forum.processing.org/two/discussion/25757/how-to-flip-an-image-vertically-in-processsing-3-3-6
  // https://stackoverflow.com/questions/29334348/processing-mirror-image-over-x-axis
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
  if(duikerSchatten.length == 0) {
    checkLevelCompleet();
  }

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

    if(duikerSchatten.length > 0) {
      for(int i = 0; i < duikerSchatten.length; i++) {
        duikerScore += itemScores[duikerSchatten[i]];
      }
      duikerSchatten = new int[0];
    }
  }
}

void resetDuiker(boolean volledig) {
  duikerX = bootX + bootImage.width / 2;
  duikerY = zeeNiveau + golfImages[0].height;
  duikerYRichting = Richting.NEUTRAAL;
  duikerXRichting = Richting.NEUTRAAL;
  duikerSchatten = new int[0];
  duikerZuurstof = 1;

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
    case 1: //ZUURSTOF
      if(duikerPakt) {
        duikerZuurstof = 1;
        items[gridX][gridY] = -1;
        duikerPakt = false;
      }
      break;
    case 2: //KIST EN MUNT
    case 3:
      if(duikerPakt) {
        duikerSchatten = append(duikerSchatten, itemId);
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

void checkLevelCompleet() {
  if(gridEmptyCount == items.length * items[0].length) {
    actiefScherm = Scherm.EIND;
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
    case ENTER:
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
    case ENTER:
    case 32:
      duikerPakt = true;
      break;
  }
}

boolean raaktDuikerItemAan(float itemX, float itemY) {
  float itemFixedX = itemX - gridItemGrootte / 2;
  float itemFixedY = itemY - gridItemGrootte / 2;

  return duikerX < itemFixedX + gridItemGrootte &&
         duikerX + duikerImage.width > itemFixedX &&
         duikerY < itemFixedY + gridItemGrootte &&
         duikerY + duikerImage.height > itemFixedY;
}