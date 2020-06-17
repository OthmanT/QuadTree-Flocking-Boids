import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

Slider separationSlider;
Slider cohesionSlider;
Slider alignmentSlider;
Slider fearSlider;
Slider mouseFearSlider;

Textfield desiredBoidsTextField;

ColorPicker backgroundColorPicker;
boolean showBackgroundColorPicker = true;
Button backgroundColorButton;

Accordion accordion;

boolean showQTree = false;
void setupUI() {
  cp5 = new ControlP5(this);

  backgroundColorPicker = cp5.addColorPicker("picker")
    .setPosition(width - 400, 25)
    .setColorValue(color(50))
    ;

  backgroundColorPicker.setVisible(showBackgroundColorPicker);

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

  backgroundColorButton = cp5.addButton("BG Color")
    .setValue(0)
    .setPosition(width - 300, 2)
    .setColorBackground(backgroundColorPicker.getColorValue())
    .setSize(60, 16)
    ;

  desiredBoidsTextField = cp5.addTextfield("desiredBoids")
    .setPosition(width - 90, 2)
    .setSize(40, 16)
    .setValue("1600")
    .setFocus(false)
    .setColor(color(250))
    .setColorForeground(color(250)) 
    .setColorBackground(color(50))
    .setAutoClear(false)
    ;
  desiredBoidsTextField.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  float x = 5;
  separationSlider = cp5.addSlider("Separation")
    .setPosition(x, height-15)
    .setRange(0, 5)
    ;

  x += separationSlider.getWidth() + 10;
  cohesionSlider = cp5.addSlider("Cohesion")
    .setPosition(x, height-15)
    .setRange(0, 5)
    ;

  x += cohesionSlider.getWidth() + 5;
  alignmentSlider = cp5.addSlider("Alignment")
    .setPosition(x, height-15)
    .setRange(0, 5)
    ;

  x += alignmentSlider.getWidth() + 5;
  fearSlider = cp5.addSlider("Fear")
    .setPosition(x, height-15)
    .setRange(0, 10)
    ;

  x += fearSlider.getWidth() + 5;
  mouseFearSlider = cp5.addSlider("Mouse fear")
    .setPosition(x, height-15)
    .setRange(-2, 10)
    ;

  separationSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  cohesionSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  alignmentSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  fearSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
  mouseFearSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);

  separationSlider.setValue(1);
  cohesionSlider.setValue(1);
  alignmentSlider.setValue(1);

  fearSlider.setValue(0);
  mouseFearSlider.setValue(0);
}

void controlEvent(ControlEvent theEvent) {

  if (theEvent.isFrom("BG Color")) {
    showBackgroundColorPicker = !showBackgroundColorPicker;
    backgroundColorPicker.setVisible(showBackgroundColorPicker);
    backgroundColorButton.setColorBackground(backgroundColorPicker.getColorValue());
  }

  if (theEvent.isFrom("Predator+")) {
    predators.add(new Predator());
  }
  if (theEvent.isFrom("Predator-")) {
    predators.remove(predators.size()-1);
  }

  if (theEvent.isFrom("desiredBoids")) {
    println(desiredBoidsTextField.getStringValue());
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

  text(flock.boids.size() + " boids /", width - 95, 10);
}
