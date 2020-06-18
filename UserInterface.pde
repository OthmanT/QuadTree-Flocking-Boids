import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

Slider separationScaleSlider;
Slider separationRadiusSlider;
Slider separationMaxForceSlider; 

Slider cohesionScaleSlider;
Slider cohesionRadiusSlider;
Slider cohesionMaxForceSlider;

Slider alignmentScaleSlider;
Slider alignmentRadiusSlider;
Slider alignmentMaxForceSlider;

Slider fearSlider;
Slider mouseFearSlider;

Textfield desiredBoidsTextField;

ColorPicker backgroundColorPicker;
boolean showBackgroundColorPicker = true;
Button backgroundColorButton;

Button boidsMenuButton;
boolean showSettings = false;
Accordion settingsMenu;

ColorPicker boidsFillColorPicker;
ColorPicker boidsStrokeColorPicker;


boolean showQTree = false;
void setupUI() {
  cp5 = new ControlP5(this);

  setupBoidsMenu();
  setupBackgroundColorPicker();

  checkbox = cp5.addCheckBox("checkBox")
    .setPosition(90, 5)
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
    .setPosition(175, 2)
    .setSize(60, 16)
    ;

  cp5.addButton("Predator-")
    .setValue(0)
    .setPosition(240, 2)
    .setSize(60, 16)
    ;



  desiredBoidsTextField = cp5.addTextfield("desiredBoids")
    .setPosition(width - 90, 2)
    .setSize(40, 16)
    .setStringValue("1600")
    .setValue("1600")
    .setFocus(false)
    .setColor(color(250))
    .setColorForeground(color(250)) 
    .setColorBackground(color(50))
    .setAutoClear(false)
    ;
  desiredBoidsTextField.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);


  mouseFearSlider = cp5.addSlider("Mouse fear s")
    .setPosition(100, height-15)
    .setRange(-2, 10)
    ;


  //fearSlider.setValue(0);
  //mouseFearSlider.setValue(0);
}

void setupBoidsMenu() {
  boidsMenuButton =   cp5.addButton("SettingsButton")
    .setCaptionLabel("Settings")
    .setValue(0)
    .setPosition(5, 2)
    .setSize(60, 16)
    ;

  Group basicGroup = cp5.addGroup("basicGroup")
    .setBackgroundColor(color(0, 64))
    .setHeight(15)
    .setBackgroundHeight(200) 
    ;


  //////
  cp5.addTextlabel("FillColorLabel")
    .setText("Fill color")
    .setPosition(2, 4)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  boidsFillColorPicker = cp5.addColorPicker("Boids fill color", 0, 20, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  cp5.addTextlabel("StrokeColorLabel")
    .setText("Stroke color")
    .setPosition(2, 84)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  boidsStrokeColorPicker = cp5.addColorPicker("Boids stroke color", 0, 100, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  //////
  Group flockingGroup = cp5.addGroup("FlockingGroup")
    .setBackgroundColor(color(0, 64))
    .setHeight(15)
    .setBackgroundHeight(10) 
    ;

  float y = 15;
  cp5.addTextlabel("SeparationLabel")
    .setText("Separation")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  flockingGroup.setBackgroundHeight (300);
  separationScaleSlider = cp5.addSlider("SeparationScale")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  separationScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  separationRadiusSlider = cp5.addSlider("SeparationRadius")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  separationRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  separationMaxForceSlider = cp5.addSlider("SeparationMaxSteerForce")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  separationMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  separationMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
  /////

  y += 25;
  cp5.addTextlabel("CohesionLabel")
    .setText("Cohesion")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  cohesionScaleSlider = cp5.addSlider("CohesionScale")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  cohesionScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 20;
  cohesionRadiusSlider = cp5.addSlider("CohesionRadius")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  cohesionRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  cohesionMaxForceSlider = cp5.addSlider("cohesionMaxSteerForce")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  cohesionMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  cohesionMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  ////
  y += 25;
  cp5.addTextlabel("AlignmentLabel")
    .setText("Alignment")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  alignmentScaleSlider = cp5.addSlider("AlignmentScale")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 10)
    .moveTo(flockingGroup)
    ;

  alignmentScaleSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentScaleSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 20;
  alignmentRadiusSlider = cp5.addSlider("AlignmentRadius")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 100)
    .moveTo(flockingGroup)
    ;

  alignmentRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y +=20;
  alignmentMaxForceSlider = cp5.addSlider("alignmentMaxSteerForce")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 1)
    .moveTo(flockingGroup)
    ;

  alignmentMaxForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  alignmentMaxForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);
  ////

  separationScaleSlider.setValue(1);
  separationRadiusSlider.setValue(5);
  cohesionRadiusSlider.setValue(20);
  cohesionScaleSlider.setValue(1);
  alignmentRadiusSlider.setValue(20);
  alignmentScaleSlider.setValue(1);
  separationMaxForceSlider.setValue(0.1);
  cohesionMaxForceSlider.setValue(0.1);
  alignmentMaxForceSlider.setValue(0.1);

  //The menu
  settingsMenu = cp5.addAccordion("Boids")
    .setPosition(5, 22)
    .setWidth(150)

    .addItem(basicGroup)
    .addItem(flockingGroup)
    ;

  //boidsMenu.open(0, 1);
  settingsMenu.setCollapseMode(Accordion.MULTI);
  settingsMenu.setVisible(showSettings);
}

void setupBackgroundColorPicker() {
  backgroundColorPicker = cp5.addColorPicker("backgroundColorPicker")
    .setPosition(width - 400, 25)
    .setColorValue(color(50))
    ;

  backgroundColorPicker.setVisible(showBackgroundColorPicker);

  backgroundColorButton = cp5.addButton("BG Color")
    .setValue(0)
    .setPosition(width - 300, 2)
    .setColorBackground(backgroundColorPicker.getColorValue())
    .setSize(60, 16)
    ;
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom("SettingsButton")) {
    if (settingsMenu != null) {
      showSettings = !showSettings;
      settingsMenu.setVisible(showSettings);
    }
  }

  if (theEvent.isFrom("backgroundColorPicker")) {
    if (backgroundColorButton != null)
      backgroundColorButton.setColorBackground(backgroundColorPicker.getColorValue());
  }
  if (theEvent.isFrom("BG Color")) {
    showBackgroundColorPicker = !showBackgroundColorPicker;
    backgroundColorPicker.setVisible(showBackgroundColorPicker);
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
