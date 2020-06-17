Flock flock;
ArrayList<Predator> predators = new ArrayList<Predator>();
QuadTree qtree;

void setup() {
  size(1000, 720, P2D);

  setupUI();

  //fullScreen(P2D);
  flock = new Flock(1600);
}

void draw() {
  background(50);

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
}

void runPredators() {
  for (Predator predator : predators) {
    predator.wrapAround();
    predator.update();
    predator.lookForward();
    predator.display();
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
