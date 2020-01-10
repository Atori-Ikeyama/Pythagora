class Box {

    Body body;
    float x, y, w, h;

    Box(float x_, float y_) {

        x = x_;
        y = y_;
        w = 80;
        h = 60;

        BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;
        //bd.bullet = true;
        bd.position.set(box2d.coordPixelsToWorld(x, y));
        //bd.setLinearVelocity(new Vec2(2, -10));
        body = box2d.createBody(bd);

        PolygonShape pd = new PolygonShape();
        // Figure out the box2d coordinates
        float box2dW = box2d.scalarPixelsToWorld(w/2);
        float box2dH = box2d.scalarPixelsToWorld(h/2);
        // We're just a box
        pd.setAsBox(box2dW, box2dH);

        FixtureDef sd = new FixtureDef();
        sd.shape = pd;
        sd.density = 100.0;
        sd.friction = 0.1;
        sd.restitution = 0.9;

        body.createFixture(sd);
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
