class Flock{
  ArrayList<Boid> boids = new ArrayList<Boid>();
  
  Flock(int nbBoids){
    for(int i = 0; i < nbBoids; i++){
      boids.add(new Boid());
    }
  }
  
  void display(){
    for(Boid boid : boids){
      ArrayList<Point> query = qtree.query(new Rectangle(boid.position.x, boid.position.y, 30,30), null);
      boid.flock(query);
      boid.wrapAround();
      boid.update();
      boid.lookForward();
      //boid.averageColor(boids);
      boid.display();
    }
  }
}
