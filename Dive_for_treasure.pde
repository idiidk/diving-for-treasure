enum Scherm {
  START,
  SPEL
}

Scherm actiefScherm = Scherm.START;

void setup() {
  size(750, 500);
  setupUI();
  setupZee();
  setupWolken();

  setupSpelScherm();
}

void draw() {
  switch(actiefScherm) {
    case START:
      tekenStartScherm();
      break;
    case SPEL:
      tekenSpelScherm();
      break;
  }
}