enum Scherm {
  START,
  SPEL,
  EIND
}

Scherm actiefScherm = Scherm.START;

void setup() {
  size(1920, 950);

  PFont font = loadFont("Poppins-Regular-48.vlw");
	textFont(font);

  setupImages();
  setupStartScherm();
}

void draw() {
  clear();
  switch(actiefScherm) {
    case START:
      tekenStartScherm();
      break;
    case SPEL:
      tekenSpelScherm();
      break;
    case EIND:
      tekenEindScherm();
      break;
  }
}

void keyReleased() {
  switch(actiefScherm) {
    case SPEL:
      keyReleasedDuiker();
      break;
  }
}

void keyPressed() {
  switch(actiefScherm) {
    case SPEL:
      keyPressedDuiker();
      break;
  }
}