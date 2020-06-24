Flock flock;
ArrayList<Predator> predators = new ArrayList<Predator>();

ArrayList<Wall> walls = new ArrayList<Wall>();
Wall currentWall = new Wall();

QuadTree qtree;

void setup() {
  size(1000, 800, P2D);
  //fullScreen(P2D);
  setupUI();
  flock = new Flock(100);
  walls.add(currentWall);
  predators.add(new Predator(new PVector(width/2, height/2)));
}

void keyPressed() {
  if (str(key).toLowerCase().equals("c")) {
    showMouseCursorCheckBox.toggle(0);
  }
}

boolean firstClick = false;
void mousePressed() {
  if (mouseActionCheckBox.getArrayValue()[1] == 1) {
    if (mousePressed) {
      if (firstClick == false) {
        firstClick = true;
      } else if (!currentWall.finished) {
        if (currentWall.addPoint(new PVector(mouseX, mouseY))) {
          currentWall = new Wall();
          walls.add(currentWall);
        }
      }
    }
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

  for (Wall wall : walls) {
    for (Obstacle obstacle : wall.obstacles) {
      qtree.insert(new Point(obstacle.position.x, obstacle.position.y, obstacle));
    }
  }


  //ArrayList<Point> selection = qtree.query(new Circle(mouseX, mouseY, 100), null);
  //for(Point p : selection){
  //  p.boid.setHighlighted(true);
  //}

  flock.display();
  runPredators();

  for (Wall wall : walls)
    wall.display();

  if (showQuadTreeCheckBox.getArrayValue()[0] == 1) {
    qtree.show();
  }

  drawUI();

  //reachDesiredNumberOfBoids();
}

void runPredators() {

  for (Predator predator : predators) {
    ArrayList<Point> query = qtree.query(new Circle(predator.position.x, predator.position.y, 
      120), 
      null);

    predator.wrapAround();
    predator.applyForce(predator.seekClosestBoid(query));
    predator.eatCloseBoids(query);
    predator.update();
    predator.lookForward();
    predator.display();
  }
}

void reachDesiredNumberOfBoids() {
  if (flock.boids.size() < int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = flock.boids.size(); i < int(desiredBoidsTextField.getStringValue()); i++) {
        flock.boids.add(new Boid());
      }
    } else {
      flock.boids.add(new Boid());
    }
  }

  if (flock.boids.size() > int(desiredBoidsTextField.getStringValue())) {
    if (slowChangeCheckBox.getArrayValue()[0] == 0) {
      for (int i = flock.boids.size(); i > int(desiredBoidsTextField.getStringValue()); i--) {
        flock.boids.remove(flock.boids.size()-1);
      }
    } else {
      flock.boids.remove(flock.boids.size()-1);
    }
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
