class Line {

  // Bridge properties
  float xtotalLength, ytotalLength;  // How long
  int numPoints;      // How many points

  // Our chain is a list of particles
  ArrayList<Particle> particles;

  // Chain constructor
  Line(int n, float sx, float sy, float ex, float ey, Box b) {

    xtotalLength = abs(sx - ex);
    ytotalLength = abs(sy - ey);
    numPoints = n;

    particles = new ArrayList();

    float xlen = xtotalLength / numPoints;
    float ylen = ytotalLength / numPoints;
    // Here is the real work, go through and add particles to the chain itself
    for(int i=0; i < numPoints+1; i++) {
      // Make a new particle
      Particle p = null;
      
      // First and last particles are made with density of zero
      if (i == 0) p = new Particle(sx, sy, 2, true);
      else if(i == numPoints) p = new Particle(ex, ey, 2, false);
      else p = new Particle(sx + i*xlen, sy + i*ylen, 2, false);
      particles.add(p); 
      //println(i*xlen, " : ", i*ylen);
      // Connect the particles with a distance joint
      if (i > 0) {
         DistanceJointDef djd = new DistanceJointDef();
         Particle previous = particles.get(i-1);
         // Connection between previous particle and this one
         
         djd.bodyA = previous.body;
         djd.bodyB = p.body;
         
         // Equilibrium length
         djd.length = box2d.scalarPixelsToWorld(sqrt(ylen*ylen + xlen*xlen));
         // These properties affect how springy the joint is 
         djd.frequencyHz = 0;
	       djd.dampingRatio = 0;
         
         // Make the joint.  Note we aren't storing a reference to the joint ourselves anywhere!
         // We might need to someday, but for now it's ok
         DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
      }

      if(i == numPoints){
        DistanceJointDef djd = new DistanceJointDef();
         // Connection between previous particle and this one
         
         djd.bodyA = p.body;
         djd.bodyB = b.body;
         

         // Equilibrium length
         djd.length = box2d.scalarPixelsToWorld(sqrt(ylen*ylen + xlen*xlen));
         // These properties affect how springy the joint is 
         djd.frequencyHz = 0;
	       djd.dampingRatio = 0;
         
         // Make the joint.  Note we aren't storing a reference to the joint ourselves anywhere!
         // We might need to someday, but for now it's ok
         DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);

      }
    }
  }

    void fall(){
      particles.get(0).killBody();
      println("fall");
  }


  // Draw the bridge
  void display() {
    for (Particle p: particles) {
      p.display();
      //println(p.x_, p.y_);
    }
  }

}
