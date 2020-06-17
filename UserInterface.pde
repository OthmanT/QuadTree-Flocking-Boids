import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

Slider separationSlider;
Slider cohesionSlider;
Slider alignmentSlider;
Slider fearSlider;

boolean showQTree = false;
void setupUI() {
  cp5 = new ControlP5(this);

  checkbox = cp5.addCheckBox("checkBox")
    .setPosition(5, 5)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorActive(color(0, 200, 100))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(3)
    .setSpacingColumn(5)
    .setSpacingRow(20)
    .addItem("Show tree", 0)
    ;

  cp5.addButton("Predator+")
    .setValue(0)
    .setPosition(75, 2)
    .setSize(60, 16)
    ;

  cp5.addButton("Predator-")
    .setValue(0)
    .setPosition(140, 2)
    .setSize(60, 16)
    ;

  separationSlider = cp5.addSlider("Separation")
    .setPosition(5, height-15)
    .setRange(0, 5)
    ;

  cohesionSlider = cp5.addSlider("Cohesion")
    .setPosition(separationSlider.getWidth() + 15, height-15)
    .setRange(0, 5)
    ;

  alignmentSlider = cp5.addSlider("Alignment")
    .setPosition(separationSlider.getWidth() + cohesionSlider.getWidth() + 25, height-15)
    .setRange(0, 5)
    ;

  fearSlider = cp5.addSlider("Fear")
    .setPosition(separationSlider.getWidth() + cohesionSlider.getWidth() + alignmentSlider.getWidth()  + 35, height-15)
    .setRange(0, 10)
    ;


  separationSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  cohesionSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  alignmentSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  fearSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  separationSlider.setValue(1);
  cohesionSlider.setValue(1);
  alignmentSlider.setValue(1);

  fearSlider.setValue(0);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom("Predator+")) {
    predators.add(new Predator());
  }
  if (theEvent.isFrom("Predator-")) {
    predators.remove(predators.size()-1);
  }
  if (theEvent.isFrom(checkbox)) {
    int col = 0;
    for (int i=0; i<checkbox.getArrayValue().length; i++) {
      int n = (int)checkbox.getArrayValue()[i];
      if (i ==0) {
        showQTree = boolean(n);
      }
    }
  }
}

void drawUI() {
  fill(10);
  noStroke();

  rectMode(CORNER);
  rect(0, 0, width, 20);
  rect(0, height-30, width, 30);

  fill(255);
  textAlign(RIGHT, CENTER);
  text((int)frameRate + " fps", width, 10);

  text(flock.boids.size() + " boids", width - 45, 10);
}
