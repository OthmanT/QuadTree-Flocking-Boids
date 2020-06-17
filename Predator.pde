class Predator extends Boid {

  Predator() {
    super();
    maxSpeed = 2;
    shape.scale(2);
  }

  Predator(PVector position) {
    super();
    this.position = position;
    maxSpeed = 2;
    shape.scale(2);
  }

  void update() {
    if (frameCount % 100 == 0)
      acceleration.set(acceleration.x + random(-20, 20), acceleration.y + random(-20, 20));

    super.update();
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    shape.setFill(color(200, 20, 10));
    shape(shape, 0, 0);   
    popMatrix();
  }
}
