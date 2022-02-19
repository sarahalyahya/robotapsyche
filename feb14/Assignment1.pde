
Predator pred; 
ArrayList<Prey> preys = new ArrayList<Prey>();
int numberOfPreys;
boolean startEcoSystem; 
color backgroundColor = color(1,22,39); 
 

void setup(){
  size(1600,1000);
  pred = new Predator(width/2, height/2); 
  numberOfPreys = 20; 
  
  for (int i = 0; i < numberOfPreys; i++) {
    preys.add(new Prey(random(0.1, 2.5), random(width), random(height))); // initial location
  }
  

}

void draw(){
  //mouse pressed is only for the purpose of a clear recording
  if(mousePressed){
  startEcoSystem = true;
  }
  
  background(backgroundColor);
  
  if (startEcoSystem){
  pred.update();
  pred.display(); 
  pred.checkEdges();
  
  //checking the number of preys "alive" 
  numberOfPreys = preys.size(); 
 
  for (int i = 0; i < numberOfPreys -1; i++) {
    
    //avoiding index error by constantly checking number of preys alive
    int numberOfPreys2 = preys.size();
    if (numberOfPreys2 < numberOfPreys){
    break;
    }
    
    Prey p = preys.get(i); 
    
    //predator attracting preys
    PVector aForce = pred.attract(p);
    pred.applyForce(aForce);
    
    //preys "running away" by repelling predator - only if they're too weak -
    if(p.mass <=10){
    PVector rForce = p.repel(pred); 
    p.applyForce(rForce); 
  } 
    

   //nested loop for prey-prey attraction and pre-prey collisions
    for (int j = 0; j < numberOfPreys; j++) {
      Prey p2 = preys.get(j); 
      if (p != p2) {
        PVector force = p2.attract(p);
        p.applyForce(force);
        p.checkLikeCollisions(p2, p);
        
      }
    }
    
    //checking predator collisions  
   p.checkPredatorCollisions(p, pred);
   
   
   p.update();
   p.checkEdges();
   p.display();
    
    
    }  
  }
}





class Prey{
  PVector location;
  PVector velocity; 
  PVector acceleration; 
  float mass; 
  float G = 0.4; 
  float radius; 
  color preyColor; 
  
  
  Prey(float _mass, float _x, float _y){
    mass = _mass;
    //size impacted by mass
    radius = 20*mass;
    location = new PVector(_x, _y);
    velocity = new PVector(0,0); 
    acceleration = new PVector(0,0); 
    preyColor = color(0, 187, 204);
     
  
  }
  
  //force function
  void applyForce(PVector force){
    PVector f = PVector.div(force,mass);
    acceleration.add(f); 
  }
  
  //attraction function
  PVector attract(Prey p) {
    PVector force = PVector.sub(location, p.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();

    float strength = (G * mass * p.mass) / (distance * distance);
    force.mult(strength);

    

    return force;
  }
  
  // repelling the predator 
   PVector repel(Predator p) {

    PVector force = PVector.sub(location, p.location);
    float distance = force.mag();
    distance = constrain(distance, 5.0, 25.0);
    force.normalize();

    float strength = (G * mass * p.mass) / (distance * distance);
    force.mult(strength);
    force.mult(-1);
    return force;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    stroke(255); 
    strokeWeight(5);
    fill(preyColor); 
    ellipseMode(RADIUS);
    ellipse(location.x, location.y, radius, radius); 
  
  }
  //bouncing off edges of the screen
  void checkEdges() {
    if (location.x > width - radius) {
      velocity.x *= -1; 
    } else if (location.x < 0 + radius) {
      velocity.x *= -1; 
    }

    if (location.y > height - radius) {
      velocity.y *= -1; 
    } else if (location.y < 0 + radius) {
      velocity.y *= -1; 
    }
  }
  
  void checkLikeCollisions(Prey p1, Prey p2){
    //Pythagorean theorem to check for collisions 
    PVector vectorBtwnCenters = PVector.sub(p1.location, p2.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 
    
     //upon collision:
    if(distBtwnCenters <= p1.radius + p2.radius){
     
      //they bounce off
      p1.velocity.mult(-1);
      p2.velocity.mult(-1);
      
     //prey velocity is sliiightly incremented with reference to the other prey's velocity
     PVector addedVelocity1 = PVector.mult(p2.velocity, 0.001);
     PVector addedVelocity2 = PVector.mult(p1.velocity, 0.001); 
     
     float velocity1Mag = abs(p1.velocity.mag());
     float velocity2Mag = abs(p2.velocity.mag());
     //constraining a float 
     if(velocity1Mag > 40){
     p1.velocity.mult(0.5);
     }
      if(velocity2Mag > 40){
     p2.velocity.mult(0.5);
     }
     
     //if the preys are still weaker than the predator (mass < 10) then increment their velocity and mass 
     if(p1.mass <= 10 || p2.mass <= 10 && velocity1Mag <= 20 || velocity2Mag <= 20){
      p1.applyForce(addedVelocity1);
      p2.applyForce(addedVelocity2);
      p1.mass += 0.2;
      p2.mass += 0.2;
    }
      //growth in size to indicate increase in strength - just for visuals - 
      if(p1.radius <= 50 || p1.radius <= 50){
        p1.radius+=0.07;
        p2.radius+=0.07;
      }
      
    }
     
  }
  
  
  //Prey dies if it too weak (mass too low), otherwise it bounces off.  
  void checkPredatorCollisions(Prey p, Predator pred){
    PVector vectorBtwnCenters = PVector.sub(p.location, pred.location); 
    float distBtwnCenters = vectorBtwnCenters.mag(); 
     
    if(distBtwnCenters <= p.radius + pred.shapeWidth  && p.mass <= 10){
      preys.remove(p); 
   } else if (distBtwnCenters <= p.radius + pred.shapeWidth && p.mass >= 1){
      p.velocity.mult(-1);
     } 
  } 
}
  
  
  

class Predator{
float mass;
PVector location;
PVector velocity; 
PVector acceleration; 
float G; 
int shapeWidth; 
color predColor;  


Predator(float _x, float _y){

mass = 10; 
location = new PVector(_x, _y); 
velocity = new PVector(0,0); 
acceleration = new PVector(0.2,0.1); 
predColor = color(255, 68, 51); 
shapeWidth = 90; 

}

void applyForce(PVector force){
  PVector f = PVector.div(force,mass); 
  acceleration.add(f); 
}


//prey attraction
PVector attract(Prey p){
  PVector force = PVector.sub(location, p.location); 
  float distance = force.mag(); 
   distance = constrain(distance, 5.0,25.0); 
   force.normalize(); 
   
   float strength = (G* mass * p.mass) / (distance*distance); 
   force.mult(strength);
   return force; 
   

}

void update(){
  velocity.add(acceleration);
  location.add(velocity);
  acceleration.mult(0); 
}

void display(){
rectMode(RADIUS);
noStroke();
fill(predColor); 
rect(location.x, location.y, shapeWidth,shapeWidth, 20); 
}

 //bouncing off edges of the screen
void checkEdges() {
    if (location.x > width - shapeWidth) {
      velocity.x *= -1; 
    } else if (location.x < 0 + shapeWidth) {
      velocity.x *= -1; 
    }

    if (location.y > height - shapeWidth) {
      velocity.y *= -1; 
    } else if (location.y < 0 + shapeWidth) {
      velocity.y *= -1; 
    }
  }


}
