import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
ArrayList<Ball> balls;
Ball b;
Box box;
ArrayList<Obstacle> obstacles;
ArrayList<Boundary> boundaries; 
int time = 3;
int flag = 0;
int stage = 0;
int counter = 0;

void setup() {

    fullScreen(P2D);
    smooth();

    box2d = new Box2DProcessing(this);
    box2d.createWorld();
    box2d.setGravity(0, -100);
    box2d.listenForCollisions();

    boundaries = new ArrayList<Boundary>();
    obstacles = new ArrayList<Obstacle>();
    balls = new ArrayList<Ball>();

    obstacles.add(new Obstacle(660, 350, 1000, 20));
    obstacles.add(new Obstacle(600, 600, 1500, 20));

    boundaries.add(new Boundary(1000, 400, 100, 10));
    boundaries.add(new Boundary(200, 500, 100, 10));
    boundaries.add(new Boundary(155, 490, 10, 10));
    boundaries.add(new Boundary(100, 300, 300, 10));
    boundaries.add(new Boundary(800, 380, 50, 10));
    boundaries.add(new Boundary(150, 650, 100, 10));
    boundaries.add(new Boundary(1000, 700, 100, 10));
    boundaries.add(new Boundary(1250, 200, 100, 10));

    box = new Box(1100, 300);
}

void draw() {

    background(255);
    box2d.step();

    switch (stage) {
        case 0:
            background(0);
            break;
        case 1:
            if (time == 0) {
                b = new Ball(100, 50, 5, -100);
                flag = time;
                time = 3;
            }else if (time == 1) {
                b.killBody();
                b = new Ball(-100, 500, 30, -10);
                flag = time;
                time = 3;
            }else if (time == 2) {
                b.killBody();
                b = new Ball(1250, 50, 20, -100);
                flag = time;
                time = 3;
            }
            //println(flag);

            box.display();
            
            if(b != null) {
                b.display();
            }

            for (Obstacle ob: obstacles) {
                ob.display();
            }

            for (Boundary boun: boundaries) {
                boun.display();
            }
            break;

    }

    write_end();
}

void keyPressed() {
   stage = 1;
   if (key == 'a') {
       time = 0;
   }else if (key == 'b') {
       time = 1;
   }else if (key == 'c') {
       time = 2;
   }else if (key == 'e') {
        counter++;
    }else if (key == 'n') {
        counter++;
    }
   
}

void write_end() {
    textSize(600);
    fill(255, 10, 10);

    if (counter > 1 ) {
        text('E', 200, 700);
    }
    
    if (counter > 0) {
        text('N', 900, 700);
    }
}

void beginContact(Contact cp) {

    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();

    Body b1 = f1.getBody();
    Body b2 = f2.getBody();

    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

    println("o1: ", o1.getClass());
    println("o2: ", o2.getClass());

    if (o1.getClass() == Obstacle.class && o2.getClass() == Ball.class) {
        Obstacle p1 = (Obstacle) o1;
        Ball p2 = (Ball) o2;
        
    }
}

void endContact(Contact cp) {
}
