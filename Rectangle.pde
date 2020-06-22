class Rectangle extends SelectionShape implements SelectionShapeInterface {
  float w;
  float h;

  Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    ;
    this.w = w;
    this.h = h;
  }

  float left() {
    return this.x - this.w / 2;
  }

  float right() {
    return this.x + this.w / 2;
  }

  float top() {
    return this.y - this.h / 2;
  }

  float bottom() {
    return this.y + this.h / 2;
  }

  boolean contains(Point point) {
    return (point.x >= this.x - this.w &&
      point.x <= this.x + this.w &&
      point.y >= this.y - this.h &&
      point.y <= this.y + this.h);
  }

  boolean intersects(Rectangle range) {
    return !(range.x - range.w > this.x + this.w ||
      range.x + range.w < this.x - this.w ||
      range.y - range.h > this.y + this.h ||
      range.y + range.h < this.y - this.h);
  }
}
