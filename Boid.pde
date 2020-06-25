class Boid {
  //Parameters
  PVector position = new PVector(random(width), random(height));
  PVector acceleration = new PVector();
  PVector velocity = new PVector(random(-3, 3), random(-3, 3));

  Animation animation;

  PShape shape;
  float angle = 0;
  color c = color(random(0, 100), random(50, 200), random(50, 200));
  float scale = random(0.6, 1);

  boolean highlighted = false;

  Boid() {
    setupShape(0.5);
    animation = new Animation("fish_", 4);
    animation.setScale(scale);
  }

  Boid(PVector position) {
    this.position = position;
    setupShape(0.5);
    animation = new Animation("fish_", 4);
    animation.setScale(scale);
  }

  void setupShape(float scale) {
    shape = createShape();
    shape.beginShape();
    shape.vertex(-10, 10);
    shape.vertex(0, 0);
    shape.vertex(10, 10);
    shape.vertex(0, -20);
    shape.endShape(CLOSE);
    shape.scale(scale);
    angle = 0;
  }

  void wrapAround() {
    if (position.x < 0) {
      position.x = width;
    }
    if (position.x > width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = height;
    }
    if (position.y > height) {
      position.y = 0;
    }
  }

  PVector separationVector(ArrayList<Point> points) {
    PVector steer = new PVector();
    int count = 0;

    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);

        if ((d > 0) && (d < separationRadiusSlider.getValue()/2)) {
          PVector diff = PVector.sub(position, ((Boid)point.obj).position);
          diff.normalize();
          diff.div(d);
          steer.add(diff);
          count++;
        }
      }
    }

    // Average
    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxSpeedSlider.getValue());
      steer.sub(velocity);
      steer.limit(separationMaxForceSlider.getValue());
    }
    return steer;
  }

  PVector alignmentVector (ArrayList<Point> points) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);
        if ((d > 0) && (d < alignmentRadiusSlider.getValue()/2)) {
          sum.add(((Boid)point.obj).velocity);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.setMag(maxSpeedSlider.getValue());
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(alignmentMaxForceSlider.getValue());
      return steer;
    } else {
      return new PVector();
    }
  }

  PVector cohesionVector(ArrayList<Point> points) {
    PVector sum = new PVector();
    int count = 0;
    for (Point point : points) {
      if (point.obj instanceof Boid) {
        float d = PVector.dist(position, ((Boid)point.obj).position);
        if ((d > 0) && (d < cohesionRadiusSlider.getValue()/2)) {
          sum.add(((Boid)point.obj).position);
          count++;
        }
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum, cohesionMaxForceSlider.getValue());
    } else {
      return new PVector();
    }
  }

  PVector avoidanceVector(PVector pos) {
    PVector result = new PVector();
    float d = PVector.dist(position, pos);

    if ((d > 0) && (d < 150)) {
      result = seek(pos, 1);
    }

    return result.mult(-1);
  }

  PVector avoidPredators(ArrayList<Predator> predators) {
    PVector sum = new PVector();
    int count = 0;
    for (Predator predator : predators) {
      float d = PVector.dist(position, predator.position);
      if ((d > 0) && (d < 150)) {
        sum.add(predator.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum, 1).mult(-1);
    } else {
      return new PVector();
    }
  }

  PVector avoidWalls(ArrayList<Point> points) {
    PVector sum = new PVector();
    int count = 0;
    for (Point point : points) {
      if (point.obj instanceof Obstacle) {
        float d = PVector.dist(position, ((Obstacle)point.obj).position);
        if ((d > 0) && (d < wallsSizeSlider.getValue()/2+10)) {
          sum.add(((Obstacle)point.obj).position);
          count++;
        }
      }
    }

    if (count > 0) {
      sum.div(count);
      return seek(sum, 3).mult(-1);
    } else {
      return new PVector();
    }
  }

  PVector avoidPosition(PVector position, float distance) {
    float d = PVector.dist(this.position, position);
    if ((d > 0) && (d < distance)) {
      return seek(position, 3).mult(-1);
    } else return new PVector();
  }

  PVector seekPosition(PVector position, float distance) {
    float d = PVector.dist(this.position, position);
    if ((d > 0) && (d < distance)) {
      return seek(position, 3);
    } else return new PVector();
  }

  void lookForward() {
    PVector up = new PVector(0, -1);
    float a = PVector.angleBetween(velocity, up);
    if (velocity.x < 0) {
      a = -a;
    }

    shape.rotate(-angle);
    angle = 0;
    shape.rotate(a);
    angle += a;
  }

  void averageColor(ArrayList<Boid> boids) {
    PVector averageColor = new PVector(red(c), green(c), blue(c));
    int total = 1;
    for (Boid other : boids) {
      if (this.position.dist(other.position) < 20 && other != this) {
        averageColor.set(averageColor.x + red(other.c), averageColor.y + green(other.c), averageColor.z + blue(other.c));
        total++;
      }
    }

    averageColor.div((float)total);
    this.c = color(averageColor.x, averageColor.y, averageColor.z);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  PVector seek(PVector target, float maxForce) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    desired.setMag(maxSpeedSlider.getValue());

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);  // Limit to maximum steering force
    return steer;
  }

  void flock(ArrayList<Point> points) {
    //Flocking
    applyForce(separationVector(points).mult(separationScaleSlider.getValue()));
    applyForce(alignmentVector(points).mult(alignmentScaleSlider.getValue()));
    applyForce(cohesionVector(points).mult(cohesionScaleSlider.getValue()));

    applyForce(avoidPredators(predators).mult(0.08));

    //Mouse behavior
    int behavior = mouseBehaviorRadioButton.getArrayValue()[0] == 0 ? 1 : -1;
    applyForce(avoidPosition(new PVector(mouseX, mouseY), 
      mouseRadiusSlider.getValue()/4)
      .mult(mouseForceSlider.getValue())
      .mult(behavior)
      );

    if (mouseActionCheckBox.getArrayValue()[0] == 1) {
      if (seekMouseOnClickCheckBox.getArrayValue()[0] == 0 || (mousePressed && seekMouseOnClickCheckBox.getArrayValue()[0] == 1)) {
        applyForce(seek(new PVector(mouseX, mouseY), seekMouseForceSlider.getValue()));
      }
    }


    applyForce(avoidWalls(points).mult(wallsSteerForceSlider.getValue()));
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeedSlider.getValue());
    position.add(velocity);

    acceleration.mult(0);
  }

  void setHighlighted(boolean h) {
    this.highlighted = h;
  }

  void changeScale(float scale) {
    setupShape(scale);
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);

    if (boidApparenceRadioButton.getArrayValue()[0] == 1) {//Arrow
      if (!this.highlighted) {
        shape.setFill(boidsFillColorPicker.getColorValue());
        shape.setStroke(boidsStrokeColorPicker.getColorValue());
        shape.setStrokeWeight(boidsStrokeWeightSlider.getValue());
      } else {
        shape.setStroke(boidsStrokeColorPicker.getColorValue());
        shape.setStrokeWeight(boidsStrokeWeightSlider.getValue());
        shape.setFill(color(230, 20, 20, 255));
      }
      shape(shape, 0, 0);
    } else if (boidApparenceRadioButton.getArrayValue()[1] == 1) {//Circle
    
      fill(boidsFillColorPicker.getColorValue());
      strokeWeight(boidsStrokeWeightSlider.getValue());
      stroke(boidsStrokeColorPicker.getColorValue());
      
      if (boidsSizeSlider != null)
        circle(0, 0, boidsSizeSlider.getValue()*20);
        
    } else if (boidApparenceRadioButton.getArrayValue()[2] == 1) {//Fish
      rotate(angle);
      if (!this.highlighted) {
        noTint();
        //tint(255, 255, 255);
      } else {
        tint(255, 220, 220);
      }
      //tint(c);
      //tint(color(150,50,60));
      animation.display(0, 0);
    }

    popMatrix();

    this.highlighted = false;
  }
}
