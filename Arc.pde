class Arc {
  float radius;
  float startingAngle;
  float endingAngle;
  float centerX;
  float centerY;
  float angle;

  Arc(float x, float y, float startingAngle, float endingAngle, float radius) {
    this.centerX = x;
    this.centerY = y;
    this.startingAngle = startingAngle - PI/2;
    this.endingAngle = endingAngle - PI/2;
    this.radius = radius;
  }

  Arc(float x, float y, float angle, float radius) {
    this.centerX = x;
    this.centerY = y;
    this.startingAngle = -angle/2 - PI/2;
    this.endingAngle = angle/2 - PI/2;
    this.radius = radius;
    this.angle = angle;
  }

  void updatePosition(float x, float y) {
    this.centerX = x;
    this.centerY = y;
  }

  void rotateBy(float angle) {
    startingAngle += angle;
    endingAngle +=angle;
  }

  void setAngle(float a) {
    this.startingAngle = -angle/2 - PI/2 + (a+TWO_PI);
    this.endingAngle = angle/2 - PI/2 + (a+TWO_PI);
  }

  boolean containsPoint(float x, float y) {
    float r = sqrt( pow((x - centerX), 2) + pow((y - centerY), 2));
    float a = atan2(y - centerY, x - centerX) + PI;//+PI to shift to a standard circle

    //Convert the angle to a standard trigonometric circle
    float s = (startingAngle + PI)%TWO_PI;
    float e = (endingAngle + PI)%TWO_PI;
    //Inspired by
    //https://stackoverflow.com/questions/6270785/how-to-determine-whether-a-point-x-y-is-contained-within-an-arc-section-of-a-c
    if (r < radius) {
      if (s < e) {
        if (a > s && a < e) {
          return true;
        }
      }
      if (s > e) {
        if (a > s || a < e) {
          return true;
        }
      }
    }
    return false;
  }

  void display() {
    noFill();
    stroke(255);
    strokeWeight(1);
    arc(centerX, centerY, radius*2, radius*2, startingAngle, endingAngle, PIE);
  }
}
