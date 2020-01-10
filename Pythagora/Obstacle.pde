class Obstacle {

    Body body;
    float x, y, w, h;

    Obstacle(float x_, float y_, float w_, float h_) {

        x = x_;
        y = y_;
        w = w_;
        h = h_;

        BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;
        //bd.bullet = true;
        bd.position.set(box2d.coordPixelsToWorld(x, y));
        body = box2d.createBody(bd);

        PolygonShape ps = new PolygonShape();
        float box2dW = box2d.scalarPixelsToWorld(w/2);
        float box2dH = box2d.scalarPixelsToWorld(h/2);
        ps.setAsBox(box2dW, box2dH);

        FixtureDef fd = new FixtureDef();
        fd.shape = ps;
        fd.density = 30;
        fd.friction = 0.2;
        fd.restitution = 0.2;

        body.createFixture(fd);
    }
        
    void display() {
        Vec2 pos = box2d.getBodyPixelCoord(body);
        float a = body.getAngle();

        pushMatrix();
        translate(pos.x, pos.y);
        rotate(-a);
        fill(175);
        stroke(0);
        rectMode(CENTER);
        rect(0, 0, w, h);
        popMatrix();
    }
    
    void killBody() {
        box2d.destroyBody(body);
    }
}
