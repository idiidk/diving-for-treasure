PImage[] wolkImages = new PImage[3];
ArrayList<int[]> wolken = new ArrayList();

void setupWolken() {
  wolkImages[0] = loadImage("cloud_1.png");
  wolkImages[1] = loadImage("cloud_2.png");
  wolkImages[2] = loadImage("cloud_3.png");

  wolkImages[0].resize(0, 100);
  wolkImages[1].resize(0, 50);
  wolkImages[2].resize(0, 75);
}

// Het gebied waar de wolken getekend worden
void tekenWolken(int x1, int y1, int x2, int y2) {
  tint(#FFFFFF, 128);
  if(wolken.size() == 0) {
    for(int i = 0; i < 10; i++) {
      int[] wolkData = { round(random(x1, x2)), round(random(y1, y2)), round(random(0, wolkImages.length - 1)) };
      wolken.add(wolkData);
    }
  }

  for(int i = 0; i < wolken.size(); i++) {
    int[] wolkData = wolken.get(i);
    int[] wolkPositie = { wolkData[0], wolkData[1] };
    PImage wolkImage = wolkImages[wolkData[2]];

    image(wolkImage, wolkPositie[0], wolkPositie[1]);

    wolkPositie[0]++;
    int[] nieuweData = { wolkPositie[0], wolkPositie[1], wolkData[2] };

    if(wolkPositie[0] > width) {
      nieuweData[0] = -wolkImage.width - round(random(50));
      nieuweData[1] = round(random(y1, y2));
      nieuweData[2] = round(random(0, wolkImages.length - 1));
    }
    wolken.set(i, nieuweData);
  }
}

