class Point {
  float x;
  float y;
  Object obj;

  Point(float x, float y, Object obj) {
    this.x = x;
    this.y = y;
    this.obj = obj;
  }
}

class QuadTree {

  Rectangle boundary;
  int capacity;
  ArrayList<Point> points = new ArrayList<Point>();
  Boolean divided = false;

  QuadTree northWest;
  QuadTree northEast;
  QuadTree southWest;
  QuadTree southEast;

  QuadTree(Rectangle boundary, int capacity) {
    this.boundary = boundary;
    this.capacity = capacity;
  }

  boolean insert(Point point) {
    if (!this.boundary.contains(point)) {
      return false;
    }

    if (this.points.size() < this.capacity) {
      this.points.add(point);
      return true;
    }

    if (!this.divided) {
      this.subdivide();
    }

    return(
      this.northEast.insert(point) ||
      this.northWest.insert(point) ||
      this.southWest.insert(point) ||
      this.southEast.insert(point)
      );
  }

  void subdivide() {
    float x = this.boundary.x;
    float y = this.boundary.y;
    float w = this.boundary.w /2;
    float h = this.boundary.h /2;

    Rectangle ne = new Rectangle(x + w, y - h, w, h);
    this.northEast = new QuadTree(ne, this.capacity);

    Rectangle nw = new Rectangle(x - w, y - h, w, h);
    this.northWest = new QuadTree(nw, this.capacity);

    Rectangle se = new Rectangle(x + w, y + h, w, h);
    this.southEast = new QuadTree(se, this.capacity);

    Rectangle sw = new Rectangle(x - w, y + h, w, h);
    this.southWest = new QuadTree(sw, this.capacity);

    this.divided = true;
  }

  ArrayList<Point> query(SelectionShapeInterface range, ArrayList<Point> found) {
    if (found == null) {
      found = new ArrayList<Point>();
    }

    if (!range.intersects(this.boundary)) {
      return found;
    }

    for (Point p : this.points) {
      if (range.contains(p)) {
        found.add(p);
      }
    }

    if (this.divided) {
      this.northWest.query(range, found);
      this.northEast.query(range, found);
      this.southWest.query(range, found);
      this.southEast.query(range, found);
    }
    
    return found;
  }

  void show() {
    rectMode(RADIUS);
    noFill();
    strokeWeight(1);
    stroke(quadTreeLinesColorPicker.getColorValue());
    rect(boundary.x, boundary.y, boundary.w, boundary.h);

    if (this.divided) {
      this.northEast.show();
      this.northWest.show();
      this.southEast.show();
      this.southWest.show();
    }
    /*
    for (Point point : points) {
      fill(255);
      noStroke();
      circle(point.x, point.y, 5);
    }
    */
  }
}
