class Plinko {
  Body body;
  float r;
  
  Plinko(float x, float y, float r_) {
    r = r_;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    body = box2d.world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 0.001;
    fd.friction = 0;
    fd.restitution = 1;
    
    body.createFixture(fd);
  }
  
  void show() {
    fill(255);
    noStroke();
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, r * 2, r * 2);
    popMatrix();
  }
}