import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Particle> particles;
ArrayList<Plinko> plinkos;
ArrayList<Boundary> bounds;

int cols = 11;
int rows = 10;

void setup() {
  size(600, 700);
  frameRate(30);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  particles = new ArrayList<Particle>();
  plinkos = new ArrayList<Plinko>();
  bounds = new ArrayList<Boundary>();
  
  newParticle();
  float spacing = width / cols;
  for (float j = 0; j < rows; j++) {
    for (float i = 0; i < cols + 1; i++) {
      float x = i * spacing;
      if (j % 2 == 0) {
        x += spacing / 2;
      }
      float y = spacing + j * spacing;
      Plinko p = new Plinko(x, y, 16);
      plinkos.add(p);
    }
  }
  
  Boundary b = new Boundary(width / 2, height + 50, width, 100);
  bounds.add(b);
  
  for (int i = 0; i < cols + 2; i++) {
    float x = i * spacing;
    float h = 100;
    float w = 10;
    float y = height - h / 2;
    b = new Boundary(x, y, w, h);
    bounds.add(b);
    
  }
  
}

void newParticle() {
  Particle p = new Particle(300, 0, 10);
  particles.add(p);
}

void draw() {
  if (frameCount % 20 == 0) {
    newParticle();
  }
  
  
  background(0);
  for (int i = 0; i < 2; i++) {
    box2d.step();
  }
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.show();
    if (p.isOffScreen()) {
      box2d.destroyBody(p.body);
      particles.remove(i);
      i--;
    }
  }
  for (Plinko p : plinkos) {
    p.show();
  }
  for (Boundary b : bounds) {
    b.show();
  }
  
}