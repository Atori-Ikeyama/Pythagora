class Ball {

    Body body;
    float x, y, d;

    Ball(float x_, float y_, int v1, int v2) {

        x = x_;
        y = y_;
        d = 20;

        BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;
        //bd.bullet = true;
        bd.position.set(box2d.coordPixelsToWorld(v1, v2));
        bd.setLinearVelocity(new Vec2(1, -100));
        body = box2d.createBody(bd);

        CircleShape cs = new CircleShape();
        cs.m_radius = box2d.scalarPixelsToWorld(d);

        FixtureDef fd = new FixtureDef();
        fd.shape = cs;
        fd.density = 100.0;
        fd.friction = 0.3;
        fd.restitution = 0.4;

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
        ellipseMode(CENTER);
        ellipse(0, 0, 2*d, 2*d);
        popMatrix();
    }
    
    void killBody() {
        box2d.destroyBody(body);
    }
        
}
