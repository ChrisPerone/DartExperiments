part of hackathon1;

class Projectile extends Actor {
  Projectile(num x, num y, BitmapData bitmapData, num vx, num vy):super(x, y, bitmapData) {
    _vx = vx;
    _vy = vy;
    juggler.add(this);
  }

  bool advanceTime(num delta) {
    super.advanceTime(delta);
    for (var i = 0; i < creeps.length; ++i) {
      if (hitTestObject(creeps[i])) {
        creeps[i].destroy();
      }
    }

    return true;
  }

  void destroy() {
    removeFromParent();
    juggler.remove(this);
  }
}