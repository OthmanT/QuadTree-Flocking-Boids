class Predator extends Boid {
  float maxSpeed = 6;
  Arc visionField;

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
    visionField = new Arc(position.x, position.y + 50, TWO_PI/1.5, 300);
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
    Boid closestBoid = null;
    float closestDistance = 10000;
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);
        if (this.visionField.containsPoint(point.x, point.y)) {//Condense line and below in one condition
          ((Boid)point.obj).setHighlighted(true);
          if ((d > 0) && (d < closestDistance)) {
            closestDistance = d;
            closestBoid = ((Boid)point.obj);
          }
        }
      }
    }
    if (closestBoid != null) {
      //strokeWeight(2);
      //stroke(255, 0, 0);
      //line(this.position.x, this.position.y, closestBoid.position.x, closestBoid.position.y);
      return seek(closestBoid.position, 0.2);
    } else {
      return new PVector(0, 0);
    }
  }

  void eatCloseBoids(ArrayList<Point> points) {
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0);
    PVector mouthPosition = new PVector(this.position.x + cos(angle - PI/2)*35, this.position.y+sin(angle - PI/2)*35);
    //circle(mouthPosition.x, mouthPosition.y, 25);
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(mouthPosition, ((Boid)point.obj).position);

        if ((d > 0) && (d < 15)) {
          flock.boids.remove(point.obj);
        }
      }
    }
  }

  void update() {
    super.update();

    visionField.updatePosition(position.x + cos(angle-PI/2)*25, position.y + sin(angle-PI/2)*25); //shifted to be close to the eyes
    visionField.setAngle(angle);
  }

  void display() {
    super.display();
    //visionField.display();
  }

  //void display() {
  //  pushMatrix();
  //  translate(position.x, position.y);
  //  shape.setFill(color(200, 20, 10));
  //  shape(shape, 0, 0);   
  //  popMatrix();
  //}
}
