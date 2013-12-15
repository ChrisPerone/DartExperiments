library hackathon1;

import 'package:polymer/polymer.dart';
import 'package:stagexl/stagexl.dart';
import 'dart:math' hide Rectangle hide Point;
import 'dart:html' as html;

part 'projectile.dart';
part 'actor.dart';
part 'base.dart';
part 'creep.dart';

Stage stage;
RenderLoop renderLoop;
Juggler juggler;
ResourceManager resourceManager;
List creeps = [];

@CustomTag('game-stage')
class GameStage extends PolymerElement {
  @published int kills;
  @published int resources;
  bool _isRunning = false;
  TextField loadingText;
  static var HackGameStage;

  var _bases = [];
  GameStage.created() : super.created() {
  }
  void enteredView() {
    HackGameStage = this;
    print('enteredView');
    super.enteredView();
    stage = new Stage('stage', shadowRoot.querySelector('#stage'), 960, 480);
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);
    juggler = renderLoop.juggler;

    loadingText = new TextField();
    loadingText.defaultTextFormat = new TextFormat('Arial', 24, Color.White);
    loadingText.text = "Click To Play";
    loadingText.autoSize = TextFieldAutoSize.LEFT;
    loadingText.x = (stage.stageWidth - loadingText.textWidth) * 0.5;
    loadingText.y = stage.stageHeight * 0.5;
    stage.addChild(loadingText);
  }

  void startGame() {
    if (_isRunning == true) {
      return;
    }
      stage.removeChild(loadingText);
      kills = resources = 0;
      _isRunning = true;

    var baseShape = new Shape();
    baseShape.graphics.rect(0, 0, 16, 16);
    baseShape.graphics.fillColor(Color.Green);
    for (int i = 0; i < 4; ++i) {
      BitmapData bmd = new BitmapData(16, 16);
      bmd.draw(baseShape);

      Base b = new Base(5, 480/5 * (i+1), bmd);

      stage.addChild(b);
      _bases.add(b);
    }

    var creepShape = new Shape();
    creepShape.graphics.ellipse(15, 10, 30, 20);
    creepShape.graphics.fillColor(Color.Red);
    for (int j = 0; j < 19; ++j) {
      BitmapData bmd = new BitmapData(30, 20, true, 0);
      bmd.draw(creepShape);

      Creep c = new Creep(960 + 10 * j % 22, j * 25 % 480, bmd);

      stage.addChild(c);
      creeps.add(c);
    }

    shadowRoot.querySelector('#stage').onMouseDown.listen(mouseDownListener);
    //stage.onMouseClick.listen(mouseDownListener);
  }
  void mouseDownListener(e) {
    //MouseEvent m = e as MouseEvent;
    var m = e;

    Shape bulletShape = new Shape();
    bulletShape.graphics.ellipse(6,6,12,12);
    bulletShape.graphics.fillColor(Color.White);

    Base b;
    Point p1, p2;
    for(int i = 0; i < 4; ++i) {
      b = _bases[i];
      p1 = new Point(b.x, b.y);
      p2 = new Point(m.clientX - 12, m.clientY - 56);

      var angle = atan2(p2.y - p1.y, p2.x - p1.x);

      BitmapData bmd = new BitmapData(12, 12, true, 0);
      bmd.draw(bulletShape);

      Projectile p = new Projectile(b.x, b.y, bmd, cos(angle) * 200, sin(angle) * 200);
      stage.addChild(p);
    }
  }

  void incrementKills() {
    kills++;
  }

  void incrementResources(int numResources) {
    resources += numResources;
  }
}

