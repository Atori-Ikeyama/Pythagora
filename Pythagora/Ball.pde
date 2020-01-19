class Ball {

    Body body;
    int d;

    Ball(int x, int y, int v1, int v2) {

        d = 20;

        BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;
        bd.bullet = true;
        bd.position.set(box2d.coordPixelsToWorld(x, y));
        bd.setLinearVelocity(new Vec2(v1, v2));
        body = box2d.createBody(bd);
        body.setUserData(this);

        CircleShape cs = new CircleShape();
        cs.m_radius = box2d.scalarPixelsToWorld(d);

        FixtureDef fd = new FixtureDef();
        fd.shape = cs;
        fd.density = 100.0;
        fd.friction = 0.5;
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
