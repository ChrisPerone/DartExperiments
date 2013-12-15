part of hackathon1;

class Base extends Actor {
  int health;

  Base(num x, num y, BitmapData bitmapData):super(x, y, bitmapData) {
    health = 10;
  }
}