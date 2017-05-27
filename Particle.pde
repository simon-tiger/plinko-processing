class Particle {
  Body body;
  float r;
  color col;
  
  Particle(float x, float y, float r_) {
    r = r_;
    float chance = random(100);
    col = color(random(255), 0, 255);
    if (chance < 75) {
      col = color(255, 0, random(255));
    }
    if (chance < 50) {
      col = color(0, random(255), 255);
    }
    if (chance < 25) {
      col = color(0, 255, random(255));
    }
    if (chance < 12) {
      col = color(random(255), 255, 0);
    }
    if (chance < 6) {
      col = color(255, random(255), 0);
    }
    x += random(-1, 1);
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    
    body = box2d.world.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
  }
  
  boolean isOffScreen() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float x = pos.x;
    float y = pos.y;
    return (x < -50 || x > width + 50 || y > height);
  }
  
  void show() {
    fill(col);
    noStroke();
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, r * 2, r * 2);
    popMatrix();
  }
}