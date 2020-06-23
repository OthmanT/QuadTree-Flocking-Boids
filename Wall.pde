class Obstacle {
  PVector position;
  Obstacle(PVector pos) {
    this.position = pos;
  }
}

class Wall {
  PVector start;
  PVector end;
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  boolean finished = false;

  Wall() {
  }

  boolean addPoint(PVector point) {
    if (start == null) {
      setStart(point);
      return false;
    } else if (end == null) {
      setEnd(point);
      return true;
    }
    return false;
  }

  void setStart(PVector point) {
    this.start = point;
  }

  void setEnd(PVector point) {
    this.end = point;
    finished = true;

    obstacles.add(new Obstacle(start));
    obstacles.add(new Obstacle(end));

    float l = PVector.dist(start, end);
    float s = int(l/10);

    for (int j = 1; j<=s; j++) {
      PVector a = start.copy();
      PVector b = end.copy();

      PVector p = a.sub(b).normalize().mult(-j*10).add(start);
      obstacles.add(new Obstacle(p));
    }
  }

  void display() {
    fill(200);
    noStroke();

    if (start != null)
      circle(start.x, start.y, 10);

    if (end != null)
      circle(end.x, end.y, 10);

    if (finished) {
      stroke(wallsColorPicker.getColorValue());
      strokeWeight(wallsSizeSlider.getValue());
      noFill();
      line(start.x, start.y, end.x, end.y);
      /*
      circle(start.x, start.y, 20);
       circle(end.x, end.y, 20);
       
       for (Obstacle p : obstacles)
       circle(p.position.x, p.position.y, 20);*/
    }
  }
}
