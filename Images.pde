PImage bootImage;
PImage duikerImage;

PImage[] wolkImages;
PImage[] golfImages;
PImage[] itemImages;

void setupImages() {
  bootImage = loadImage("boat.png");
  duikerImage = loadImage("diver.png");
  duikerImage.resize(0, 35);

  golfImages = new PImage[] { loadImage("wave_1.png"), loadImage("wave_2.png"), loadImage("wave_3.png") };
  wolkImages = new PImage[] { loadImage("cloud_1.png"), loadImage("cloud_2.png"), loadImage("cloud_3.png") };
  itemImages = new PImage[] { loadImage("mine.png"), loadImage("chest.png"), loadImage("gold.png") };

  // Maak de wolken kleiner
  for(int i = 0; i < wolkImages.length; i++) {
    wolkImages[i].resize(0, 100 - 25 * i);
  }
}