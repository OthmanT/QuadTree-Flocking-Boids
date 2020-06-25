import controlP5.*;
ControlP5 cp5;

CheckBox seekMouseOnClickCheckBox;
Slider seekMouseForceSlider;
Slider maxSpeedSlider;
Slider separationScaleSlider;
Slider separationRadiusSlider;
Slider separationMaxForceSlider; 
Slider cohesionScaleSlider;
Slider cohesionRadiusSlider;
Slider cohesionMaxForceSlider;
Slider alignmentScaleSlider;
Slider alignmentRadiusSlider;
Slider alignmentMaxForceSlider;

Textfield desiredBoidsTextField;

ColorPicker backgroundColorPicker;
boolean showBackgroundColorPicker = true;
Button backgroundColorButton;

CheckBox slowChangeCheckBox;
RadioButton mouseActionCheckBox;

Button settingsMenuButton;
boolean showSettings = false;
Accordion settingsMenu;

Slider boidsSizeSlider;
ColorPicker boidsFillColorPicker;
ColorPicker boidsStrokeColorPicker;
Slider boidsStrokeWeightSlider;
RadioButton boidApparenceRadioButton;

RadioButton mouseBehaviorRadioButton;
CheckBox showMouseCursorCheckBox;
CheckBox showMouseRadiusCheckBox;
Slider mouseRadiusSlider;
Slider mouseForceSlider;
ColorPicker mouseFillColorPicker;
ColorPicker mouseStrokeColorPicker;

CheckBox showQuadTreeCheckBox;
Slider quadTreeBoidPerSquareLimitSlider;
ColorPicker quadTreeLinesColorPicker;
Slider quadTreeBoidsPerceptionRadiuslider;

Slider wallsSizeSlider;
ColorPicker wallsColorPicker;
Button clearWallsButton;
Slider wallsSteerForceSlider;

void setupUI() {
  cp5 = new ControlP5(this);

  setupSettingsMenu();
  setupBackgroundColorPicker();
  setupBarUI();
}

void setupBarUI() {

  cp5.addTextlabel("MouseClickLabel")
    .setText("Mouse click:")
    .setPosition(70, 7)
    .setColorValue(255)
    ;

  mouseActionCheckBox = cp5.addRadioButton("mouseActionCheckBox")
    .setPosition(130, 6)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(4)
    .setSpacingColumn(35)
    .setSpacingRow(20)
    .addItem("Seek", 0)
    .addItem("+ wall", 1)
    .addItem("+ boid", 2)
    .addItem("+ Prdtr", 3)
    .activate(0)
    ;


  slowChangeCheckBox = cp5.addCheckBox("slowChangeCheckBox")
    .setPosition(width-250, 6)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(3)
    .setSpacingColumn(5)
    .setSpacingRow(20)
    .addItem("Slow change", 0)
    ;

  desiredBoidsTextField = cp5.addTextfield("desiredBoids")
    .setPosition(width - 90, 2)
    .setSize(40, 16)
    .setStringValue("100")
    .setValue("100")
    .setFocus(false)
    .setColor(color(250))
    .setColorForeground(color(250)) 
    .setColorBackground(color(50))
    .setAutoClear(false)
    ;

  desiredBoidsTextField.getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE);
}

void setupSettingsMenu() {
  settingsMenuButton =   cp5.addButton("SettingsButton")
    .setCaptionLabel("Settings")
    .setValue(0)
    .setPosition(5, 2)
    .setSize(60, 16)
    ;

  Group basicGroup = cp5.addGroup("basicGroup")
    .setLabel("Boids appearance")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(250) 
    ;


  //////
  float basicGroupY = 4;
  cp5.addTextlabel("boidApparenceLabel")
    .setText("Apparence")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidApparenceRadioButton = cp5.addRadioButton("radioButton")
    .setPosition(4, basicGroupY)
    .setSize(10, 10)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(3)
    .setSpacingColumn(35)
    .addItem("Arrow", 1)
    .addItem("Circle", 2)
    .addItem("Fish", 3)
    .activate(0)
    .moveTo(basicGroup)
    ;

  basicGroupY +=20;
  boidsSizeSlider = cp5.addSlider("boidsSizeSlider")
    .setLabel("Scale")
    .setPosition(4, basicGroupY)
    .setWidth(144)
    .setRange(0, 1)
    .setValue(0.5)
    .moveTo(basicGroup)
    ;

  boidsSizeSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  boidsSizeSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);


  basicGroupY += 20;
  cp5.addTextlabel("FillColorLabel")
    .setText("Fill color")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidsFillColorPicker = cp5.addColorPicker("Boids fill color", 0, (int)basicGroupY, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  basicGroupY +=75;
  boidsStrokeWeightSlider = cp5.addSlider("boidsStrokeWeightSlider")
    .setLabel("Stroke Weight")
    .setPosition(4, basicGroupY)
    .setWidth(144)
    .setRange(0, 5)
    .setValue(1)
    .moveTo(basicGroup)
    ;

  boidsStrokeWeightSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  boidsStrokeWeightSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  basicGroupY +=15;
  cp5.addTextlabel("StrokeColorLabel")
    .setText("Stroke color")
    .setPosition(2, basicGroupY)
    .setColorValue(255)
    .moveTo(basicGroup)
    ;

  basicGroupY += 15;
  boidsStrokeColorPicker = cp5.addColorPicker("Boids stroke color", 0, (int)basicGroupY, 150, 12)
    .moveTo(basicGroup)
    .setValue(color(255))
    ;

  ///////
  /*
  FLOCKING GROUP
   */
  //////

  Group flockingGroup = cp5.addGroup("FlockingGroup")
    .setLabel("Flocking behavior")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    ;
  flockingGroup.setBackgroundHeight (330);

  float y = 4;
  cp5.addTextlabel("SpeedLabel")
    .setText("Speed")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y +=15;
  maxSpeedSlider = cp5.addSlider("MaxSpeed")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 20)
    .moveTo(flockingGroup)
    ;

  maxSpeedSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  maxSpeedSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 25;
  cp5.addTextlabel("SeekMouseLabel")
    .setText("Seek Mouse")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
  seekMouseForceSlider = cp5.addSlider("seekMouseForceSlider")
    .setPosition(4, y)
    .setWidth(144)
    .setRange(0, 1)
    .setValue(0.1)
    .moveTo(flockingGroup)
    ;

  seekMouseForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  seekMouseForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  y += 15;
  seekMouseOnClickCheckBox = cp5.addCheckBox("seekMouseOnClickCheckBox")
    .setPosition(4, y)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Seek Mouse on click", 0)
    .activate(0)
    .moveTo(flockingGroup)
    ;


  ////
  y += 25;
  cp5.addTextlabel("SeparationLabel")
    .setText("Separation")
    .setPosition(2, y)
    .setColorValue(255)
    .moveTo(flockingGroup)
    ;

  y += 15;
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

  separationScaleSlider.setValue(2);
  separationRadiusSlider.setValue(20);
  cohesionRadiusSlider.setValue(20);
  cohesionScaleSlider.setValue(1);
  alignmentRadiusSlider.setValue(20);
  alignmentScaleSlider.setValue(1);
  separationMaxForceSlider.setValue(0.1);
  cohesionMaxForceSlider.setValue(0.1);
  alignmentMaxForceSlider.setValue(0.1);
  maxSpeedSlider.setValue(2);

  /////
  /*
   Mouse Group
   */
  //////
  Group mouseGroup = cp5.addGroup("mouseGroup")
    .setLabel("Mouse settings & behavior")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(270) 
    ;

  float mouseGroupY = 4;
  cp5.addTextlabel("MouseBehaviorLabel")
    .setText("Behavior")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseBehaviorRadioButton = cp5.addRadioButton("mouseBehaviorRadioButton")
    .setPosition(4, mouseGroupY)
    .setSize(10, 10)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(2)
    .setSpacingColumn(55)
    .addItem("Attraction", 1)
    .addItem("Repulsion", 2)
    .activate(1)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=15;
  mouseForceSlider = cp5.addSlider("mouseBehaviorMaxForceSlider")
    .setPosition(4, mouseGroupY)
    .setLabel("Force")
    .setWidth(144)
    .setRange(0, 10)
    .moveTo(mouseGroup)
    ;
  mouseForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  mouseForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  mouseGroupY +=20;
  showMouseCursorCheckBox = cp5.addCheckBox("showMouseCursorCheckBox")
    .setPosition(4, mouseGroupY)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Show cursor (c)", 0)
    .activate(0)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=20;
  showMouseRadiusCheckBox = cp5.addCheckBox("showMouseRadiusCheckBox")
    .setPosition(4, mouseGroupY)
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setSpacingRow(20)
    .addItem("Show radius", 0)
    .moveTo(mouseGroup)
    ;

  mouseGroupY +=15;
  mouseRadiusSlider = cp5.addSlider("mouseRadiusSlider")
    .setPosition(4, mouseGroupY)
    .setLabel("Radius")
    .setWidth(144)
    .setRange(0, width/2)
    .setValue(100)
    .moveTo(mouseGroup)
    ;
  mouseRadiusSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  mouseRadiusSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  mouseGroupY += 20;
  cp5.addTextlabel("mouseFillColorLabel")
    .setText("Fill color")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseFillColorPicker = cp5.addColorPicker("mouseFillColorPicker", 0, (int)mouseGroupY, 150, 12)
    .moveTo(mouseGroup)
    .setColorValue(color(255, 255, 255, 0))
    ;

  mouseGroupY += 70;
  cp5.addTextlabel("mouseStrokeColorLabel")
    .setText("Stroke color")
    .setPosition(2, mouseGroupY)
    .setColorValue(255)
    .moveTo(mouseGroup)
    ;

  mouseGroupY += 15;
  mouseStrokeColorPicker = cp5.addColorPicker("mouseStrokeColorPicker", 0, (int)mouseGroupY, 150, 12)
    .moveTo(mouseGroup)
    .setColorValue(color(255, 0, 0))
    ;

  //////
  /*
   QuadTree Menu
   */
  //////
  Group quadTreeGroup = cp5.addGroup("quadTreeGroup")
    .setLabel("QuadTree")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(130) 
    ;

  float quadTreeGroupY = 4;      
  showQuadTreeCheckBox = cp5.addCheckBox("checkBox")
    .setPosition(4, quadTreeGroupY)
    .setColorForeground(color(200))
    .setColorBackground(color(150))
    .setColorLabel(color(255))
    .setSize(10, 10)
    .setItemsPerRow(3)
    .setSpacingColumn(5)
    .setSpacingRow(20)
    .addItem("Show tree", 0)
    .moveTo(quadTreeGroup)
    ;

  quadTreeGroupY += 20;
  quadTreeLinesColorPicker = cp5.addColorPicker("quadTreeLinesColorPicker", 0, (int)quadTreeGroupY, 150, 12)
    .moveTo(quadTreeGroup)
    .setColorValue(color(0, 255, 255, 200))
    ;

  quadTreeGroupY +=65;
  quadTreeBoidPerSquareLimitSlider = cp5.addSlider("quadTreeBoidPerSquareLimitSlider")
    .setPosition(4, quadTreeGroupY)
    .setLabel("Boid limit/square")
    .setWidth(144)
    .setRange(1, 20)
    .setValue(6)
    .setNumberOfTickMarks(20)
    .moveTo(quadTreeGroup)
    ;
  quadTreeBoidPerSquareLimitSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  quadTreeBoidPerSquareLimitSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  quadTreeGroupY +=25;
  quadTreeBoidsPerceptionRadiuslider = cp5.addSlider("quadTreeBoidsPerceptionRadiuslider")
    .setPosition(4, quadTreeGroupY)
    .setLabel("Boid perception radius")
    .setWidth(144)
    .setRange(1, 200)
    .setValue(30)
    .moveTo(quadTreeGroup)
    ;
  quadTreeBoidsPerceptionRadiuslider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  quadTreeBoidsPerceptionRadiuslider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);


  //////
  /*
   Walls Menu
   */
  //////
  Group wallsGroup = cp5.addGroup("wallsGroup")
    .setLabel("Walls")
    .setBackgroundColor(color(0, 210))
    .setHeight(15)
    .setBackgroundHeight(150) 
    ;

  float wallsGroupY = 4;
  wallsSizeSlider = cp5.addSlider("wallsSizeSlider")
    .setPosition(4, wallsGroupY)
    .setLabel("Thickness")
    .setWidth(144)
    .setRange(10, 50)
    .setValue(15)
    .moveTo(wallsGroup)
    ;
  wallsSizeSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  wallsSizeSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  wallsGroupY += 15;
  wallsSteerForceSlider = cp5.addSlider("wallsSteerForceSlider")
    .setPosition(4, wallsGroupY)
    .setLabel("Force")
    .setWidth(144)
    .setRange(0.1, 5)
    .setValue(1)
    .moveTo(wallsGroup)
    ;
  wallsSteerForceSlider.getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER);
  wallsSteerForceSlider.getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER);

  wallsGroupY += 25;
  cp5.addTextlabel("WallsColorLabel")
    .setText("Color")
    .setPosition(2, wallsGroupY)
    .setColorValue(255)
    .moveTo(wallsGroup)
    ;
  wallsGroupY += 15;
  wallsColorPicker = cp5.addColorPicker("wallsColorPicker", 0, (int)wallsGroupY, 150, 12)
    .moveTo(wallsGroup)
    .setColorValue(color(200, 100, 100, 255))
    ;

  wallsGroupY += 65;
  clearWallsButton = cp5.addButton("clearWallsButton")
    .setLabel("Clear walls")
    .setValue(0)
    .setSize(140, 20)
    .setPosition(4, wallsGroupY)
    .moveTo(wallsGroup)
    ;

  /////
  settingsMenu = cp5.addAccordion("Settings")
    .setPosition(5, 22)
    .setWidth(150)
    .addItem(basicGroup)
    .addItem(flockingGroup)
    .addItem(mouseGroup)
    .addItem(quadTreeGroup)
    .addItem(wallsGroup)
    ;

  //boidsMenu.open(0, 1);
  settingsMenu.setCollapseMode(Accordion.MULTI);
  settingsMenu.setVisible(showSettings);
}

void setupBackgroundColorPicker() {
  backgroundColorPicker = cp5.addColorPicker("backgroundColorPicker")
    .setPosition(width - 500, 25)
    .setColorValue(color(50))
    ;

  backgroundColorPicker.setVisible(showBackgroundColorPicker);

  backgroundColorButton = cp5.addButton("BG Color")
    .setValue(0)
    .setPosition(width - 500, 2)
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

  if (theEvent.isFrom("boidsSizeSlider")) {
    if (boidsSizeSlider != null) {
      for (Boid boid : flock.boids) {
        boid.changeScale(boidsSizeSlider.getValue());
      }
    }
  }

  if (theEvent.isFrom("clearWallsButton")) {
    walls.clear();
    currentWall = new Wall();
    walls.add(currentWall);
  }
  
  if(theEvent.isFrom("mouseActionCheckBox")){
    firstClick = false;
  }
}

void drawUI() {
  fill(10);
  noStroke();

  rectMode(CORNER);
  rect(0, 0, width, 20);
  //rect(0, height-30, width, 30);//Bottom bar

  fill(255);
  textAlign(RIGHT, CENTER);
  text((int)frameRate + " fps", width, 10);

  text(flock.boids.size() + " boids /", width - 95, 10);
}
