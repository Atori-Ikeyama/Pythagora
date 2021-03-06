import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する

byte[] inByte = new byte[3]; // 受信データ用バッファ
int oval1, oval2;

Box2DProcessing box2d;
ArrayList<Ball> balls;
Ball b;
Box box;
Line lin;
ArrayList<Obstacle> obstacles;
ArrayList<Boundary> boundaries; 
int time = 0;
int memo_time = 0;
int flag = 0;
int stage = 0;
int counter = 0;
int frequency = 0;


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
    lin = new Line(30, 1100, 0, 1100, 300, box);

    //arduino

    printArray(Serial.list());// 使用可能なシリアルポート一覧の出力。デバッグ用
    String portName = Serial.list()[2]; // 使用するシリアルポート名
    serialPort = new Serial(this, portName, 9600);
    serialPort.buffer(inByte.length); // 読み込むバッファの長さをの指定
    initServo();

    println("unko");
}


void draw() {
    memo_time = time;
    background(255);
    box2d.step();

    switch (stage) {
        case 0:
        background(0);
        break;
        case 1:
        Scheduler();
        EveryThingDisplay();
        break;

    }

    write_end();
    println("time: ", time);
    println("frequency: ", frequency);
    println("counter: ", counter);
    frequency = 0;
}


void Scheduler(){
    switch(time){
        case 0://はじめの値
        counter++;
        if (stage==1 && counter > 100){
            time = 1;
            counter = 0;
        }
        break;
        case 1://はじめにボールが入ってくる
        if (b == null){
            b = new Ball(100, 50, 10, -100);  
        }
        break;
        case 2://obstacleが落ちて紐が引っ張られる
        if(counter == 0){
            sendServo(1, 100);
            lin.fall();
            //println("unko");
        }
    
        counter++;
        if (counter > 300){
            time = 3;
            counter = 0;
        }
        break;
        case 3://はじめのボールが外に出る
        sendServo(2, 100);
        counter++;
        if(counter > 100){
            b.killBody();
            b = null;
            time = 4;
            counter = 0;
        }
        break;
        case 4://出たボールが中に入る
        if(b == null) {
            b = new Ball(20, 550, 50, -1);
        }
        counter++;
        if(counter > 300){
            time = 5;
            counter = 0;
        }
        break;
        case 5://そのボールが外に出る
        //counter++;
        if(b != null){
            b.killBody();
            b = null;
        }
        break;
        default :
        break;	
    }
}


void keyPressed() {
    if (stage == 0){
        stage = 1;
        counter = 0;
    }

    if (key == 'e') {
        flag++;
    }else if (key == 'n') {
        flag++;
    }
   
}


void write_end() {
    textSize(600);
    fill(255, 10, 10);

    if (flag > 1 ) {
        text('E', 200, 700);
    }
    
    if (flag > 0) {
        text('N', 900, 700);
    }
}


void beginContact(Contact cp) {    
}


void endContact(Contact cp) {
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();

    Body b1 = f1.getBody();
    Body b2 = f2.getBody();

    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

    if (o1.getClass() == Box.class 
        && o2.getClass() == Ball.class 
        && time == 1) {
            time = 2;
            counter = 0;
    }
}


void EveryThingDisplay(){
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

    if (lin != null){
        lin.display();
    }
}
