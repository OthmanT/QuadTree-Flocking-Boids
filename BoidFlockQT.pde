Flock flock;
ArrayList<Predator> predators = new ArrayList<Predator>();
QuadTree qtree;

void setup() {
  size(800, 600, P2D);
  setupUI();
  flock = new Flock(1600);
}

void keyPressed() {
  if (str(key).toLowerCase().equals("c")) {
    showMouseCursorCheckBox.toggle(0);
  }
}


void draw() {
  if (backgroundColorPicker != null)
    background(backgroundColorPicker.getColorValue());

  if (showMouseCursorCheckBox.getArrayValue()[0] == 1) {
    cursor();
  } else {
    noCursor();
  }

  if (showMouseRadiusCheckBox.getArrayValue()[0] == 1) {
    fill(mouseFillColorPicker.getColorValue());
    stroke(mouseStrokeColorPicker.getColorValue());
    circle(mouseX, mouseY, mouseRadiusSlider.getValue()/2);
  }

  qtree = new QuadTree(new Rectangle(width/2, height/2, width, height), (int)quadTreeBoidPerSquareLimitSlider.getValue());
  for (Boid boid : flock.boids) {
    qtree.insert(new Point(boid.position.x, boid.position.y, boid));
  }

  runPredators();
  flock.display();

  if (showQuadTreeCheckBox.getArrayValue()[0] == 1) {
    qtree.show();
  }

  drawUI();

  reachDesiredNumberOfBoids();
}

void runPredators() {
  for (Predator predator : predators) {
    predator.wrapAround();
    predator.update();
    predator.lookForward();
    predator.display();
  }
}

void reachDesiredNumberOfBoids() {
  if (flock.boids.size() < int(desiredBoidsTextField.getStringValue())) {
    flock.boids.add(new Boid());
  }

  if (flock.boids.size() > int(desiredBoidsTextField.getStringValue())) {
    flock.boids.remove(flock.boids.size()-1);
  }
}

void stabilizeFrameRate() {
  if (frameRate < 50) {
    flock.boids.remove(flock.boids.size()-1);
  }
  if (frameRate > 50) {
    flock.boids.add(new Boid());
  }
}
