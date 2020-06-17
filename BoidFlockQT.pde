Flock flock;
ArrayList<Predator> predators = new ArrayList<Predator>();
QuadTree qtree;

void setup() {
  size(800, 600, P2D);

  setupUI();

  //fullScreen(P2D);
  flock = new Flock(1600);
}

void draw() {
  background(backgroundColorPicker.getColorValue());

  qtree = new QuadTree(new Rectangle(width/2, height/2, width, height), 6);
  for (Boid boid : flock.boids) {
    qtree.insert(new Point(boid.position.x, boid.position.y, boid));
  }

  if (showQTree) {
    qtree.show();
  }

  runPredators();
  flock.display();

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
