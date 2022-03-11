// Stronger Together by Sarah Al Yahya
//Legend:
// Circular Shapes -> Citizens / Revolutionaries
// Large Square -> Dictator
// Smaller Orange Squares -> Elite Class
// Green area on the left is a safe shelter for the revolutionaries 
// Alpha Value corresponds to strength, maximum strength is that of the Dictator which is filled with the most opaque red. 





ArrayList<Rev> revs = new ArrayList<Rev>();
ArrayList<Elite> elites = new ArrayList<Elite>();
int numberOfRevs;
int numberOfElites; 
Dictator dict; 
color backgroundColor = color(245, 245, 220);
safeZone shelter; 
boolean startEcoSystem; 




void setup() {
  size(1600, 1000);
  numberOfRevs = 15;
  numberOfElites = 4; 
  dict = new Dictator(width/2, height/2); 
  shelter = new safeZone(); 

  for (int i = 0; i < numberOfRevs; i++) {
    revs.add(new Rev(random(0.1, 2.5), random(width), random(height))); // initial location
  }

  for (int i = 0; i < numberOfElites; i++) {
    elites.add(new Elite(random(400+30, width), random(height))); // initial location
  }
  
}

void draw() {
  //mouse pressed is only for the purpose of a clear recording
  if (mousePressed) {
    startEcoSystem = true;
  }

  background(backgroundColor);
  shelter.display();

  if (startEcoSystem) {

    dict.update();
    dict.display();
    dict.checkEdges(); 
    //checking the number of revolutionaries alive "alive" 
    numberOfRevs = revs.size(); 


    for (int i = 0; i < numberOfRevs; i++) {

      //avoiding index error
      int numberOfRevs2 = revs.size();
      if (numberOfRevs2 < numberOfRevs) {
        break;
      }

      Rev r = revs.get(i);

      //this loop navigates the relationship between the elites and other elements on the screen 
      for (int k=0; k<numberOfElites; k++) {

        Elite e = elites.get(k);

        //checking Elite - Rev collisions, the elite are attracted to the revolutionaries
        r.checkEliteCollisions(r, e); 
        r.attractElite(e); 


        //Elite-Dictator Collisions
        e.checkCollisionWDictator(dict, e);
        for (int l=0; l<numberOfElites; l++) {
          Elite e2 = elites.get(l);
          if (e != e2) {
            //ELite-Elite Collisions
            e.checkCollisionAmongElites(e, e2);
          }
        }
        e.update();
        e.display();
        e.checkEdges();
      }








      //nested loop for rev-rev attraction and rev-rev collisions
      for (int j = 0; j < numberOfRevs; j++) {
        Rev r2 = revs.get(j); 
        if (r != r2) {
          PVector force = r2.attract(r);
          r.applyForce(force);
          
          r.checkLikeCollisions(r2, r);
          
        }
      }
      
      //dictator-rev interactions 
      dict.seekRevs(r, dict, r.location); 
      r.fleeDictator(r, dict, dict.location); 
      r.seekShelter(r, shelter.center);
      r.checkDictatorCollisions(r, dict);



      r.checkEdges();
      r.update();
      r.display();
    }
  }
}
