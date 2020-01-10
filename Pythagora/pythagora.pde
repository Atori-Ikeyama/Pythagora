import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*; 

Box2DProcessing box2d;
//ArrayList<Ball> balls;
Ball b;
Box box;
ArrayList<Obstacle> obstacles;
ArrayList<Boundary> boundaries; 
int time = 0;
int stage = 1;

void setup() {

    fullScreen();
    smooth();

    box2d = new Box2DProcessing(this);
    box2d.createWorld();
    box2d.setGravity(0, -100);

    boundaries = new ArrayList<Boundary>();
    obstacles = new ArrayList<Obstacle>();
    //balls = new ArrayList<Ball>();

    obstacles.add(new Obstacle(660, 350, 1000, 20));
    obstacles.add(new Obstacle(600, 600, 1500, 20));

    boundaries.add(new Boundary(1000, 400, 100, 10));
    boundaries.add(new Boundary(200, 500, 100, 10));
    boundaries.add(new Boundary(155, 490, 10, 10));
    boundaries.add(new Boundary(100, 300, 300, 10));
    boundaries.add(new Boundary(800, 380, 50, 10));
    boundaries.add(new Boundary(150, 650, 100, 10));
    boundaries.add(new Boundary(1000, 700, 100, 10));
    //boundaries.add(new Boundary(50, 500, 100, 1000));

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
                b = new Ball(1250, 50, -3, -100);
                time = 3;
            }else if (time == 1) {
                //b.killBody();
                b = new Ball(-10, 600, 10, -10);
                time = 3;
            }else if (time == 2) {
                //b.killBody();
                b = new Ball(1000, 600, 10, -100);
                time = 3;
            }

            box.display();

            b.display();

            for (Obstacle ob: obstacles) {
                ob.display();
            }

            for (Boundary boun: boundaries) {
                boun.display();
            }
            break;

    }
}

void keyPressed() {
   stage = 1;
   if (key == 'a') {
       time = 1;
   }else if (key == 'b') {
       time = 2;
   }
}

