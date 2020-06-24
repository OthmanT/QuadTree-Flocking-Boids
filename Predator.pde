class Predator extends Boid {
  float maxSpeed = 3;
  Predator() {
    super();
    maxSpeed = 10;
    shape.scale(2);
    animation = new Animation("shark_", 4);
    animation.setScale(scale);
  }

  Predator(PVector position) {
    super();
    this.position = position;
    maxSpeed = 2;
    shape.scale(2);
    animation = new Animation("shark_", 4);
    animation.setScale(1.5);
  }

  PVector seek(PVector target, float maxForce) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    desired.setMag(5);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(0.1);  // Limit to maximum steering force
    return steer;
  }

  PVector seekClosestBoid(ArrayList<Point> points) {
    noFill();
    stroke(255, 0, 0);
    strokeWeight(1);
    circle(this.position.x, this.position.y, 240);
    Boid closestBoid = null;
    float closestDistance = 10000;
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);
        if ((d > 0) && (d < closestDistance)) {
          closestDistance = d;
          closestBoid = ((Boid)point.obj);
        }
      }
    }
    if (closestBoid != null) {
      strokeWeight(2);
      stroke(255, 0, 0);
      line(this.position.x, this.position.y, closestBoid.position.x, closestBoid.position.y);
      return seek(closestBoid.position, 0.1);
    } else {
      return new PVector(0, 0);
    }
  }

  void eatCloseBoids(ArrayList<Point> points) {
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0);
    circle(this.position.x, this.position.y, 50);
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);

        if ((d > 0) && (d < 25)) {
          flock.boids.remove(point.obj);
        }
      }
    }
  }

  void update() {
    super.update();
  }

  //void display() {
  //  pushMatrix();
  //  translate(position.x, position.y);
  //  shape.setFill(color(200, 20, 10));
  //  shape(shape, 0, 0);   
  //  popMatrix();
  //}
}
