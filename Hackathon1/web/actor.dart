part of hackathon1;

class Actor extends Bitmap implements Animatable {
  double _vx, _vy;

  Actor(num x, num y, BitmapData bitmapData):super(bitmapData) {
    _vx = _vy = 0.0;
    this.x = x;
    this.y = y;
    pivotX = bitmapData.width * 0.5;
    pivotY = bitmapData.height * 0.5;
  }

  bool advanceTime(num delta) {
    x += _vx * delta;
    y += _vy * delta;

    return true;
  }

}