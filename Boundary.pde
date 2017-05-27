class Boundary {
  Body body;
  float w;
  float h;
  
  Boundary(float x, float y, float w_, float h_) {
    w = w_;
    h = h_;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    body = box2d.world.createBody(bd);
    
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 0.001;
    fd.friction = 0.1;
    fd.restitution = 0;
    
    body.createFixture(fd);
  }
  
  void show() {
    fill(255);
    stroke(255);
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}