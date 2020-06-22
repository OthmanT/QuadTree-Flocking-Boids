class SelectionShape{
  float x;
  float y;
}
interface SelectionShapeInterface{
  boolean intersects(Rectangle shape);
  boolean contains(Point point);
}
