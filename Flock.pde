class Flock{
  ArrayList<Boid> boids = new ArrayList<Boid>();
  
  Flock(int nbBoids){
    for(int i = 0; i < nbBoids; i++){
      boids.add(new Boid());
    }
  }
  
  void display(){
    for(Boid boid : boids){
      
      ArrayList<Point> query = qtree.query(new Circle(boid.position.x, boid.position.y,
        quadTreeBoidsPerceptionRadiuslider.getValue()),
        null);
        
      boid.flock(query);
      boid.wrapAround();
      boid.update();
      boid.lookForward();
      //boid.averageColor(boids);
      boid.display();
    }
  }
}
