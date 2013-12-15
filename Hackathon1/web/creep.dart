part of hackathon1;

class Creep extends Actor {
  Creep(num x, num y, BitmapData bitmapData):super(x, y, bitmapData) {
    _vx = -5.0;
    juggler.add(this);
  }

  void destroy() {
    removeFromParent();
    juggler.remove(this);
    GameStage.HackGameStage.incrementKills();
    GameStage.HackGameStage.incrementResources(100);
  }
}