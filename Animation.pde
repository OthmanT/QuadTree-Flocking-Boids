class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  float speed = 20;
  float scale = 1;

  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 1) + ".png";
      images[i] = loadImage(filename);
    }
    frame += random(0,2);
  }

  void display(float xpos, float ypos) {
    if (frameCount %(100/speed) == 0)
      frame = (frame+1) % imageCount;

    scale(scale);
    imageMode(CENTER);
    image(images[frame], xpos, ypos);
  }
  
  void setScale(float scale){
    this.scale = scale;
  }

  int getWidth() {
    return images[0].width;
  }
}
