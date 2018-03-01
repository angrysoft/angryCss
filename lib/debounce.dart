import 'dart:html';
/*
class Debounce {
  Duration wait;
  bool run = true;
  Timer tm;
  var fn;
  Debounce(var func, num waitms) {
    this.fn = func;
    this.wait = new Duration(milliseconds: waitms);
  }

  void pull() {
    this.tm?.cancel();
    this.tm = new Timer(this.wait, this.fn);
  }
}
*/
class Debounce {
  int frames;
  bool first = true;
  var fn;
  int currentFrame;
  Debounce(var func, num waitms) {
    this.fn = func;
    this.frames = (waitms / (1000 / 60)).round();
    this.currentFrame = 0;
  }

  void watch(num frame) {
    if (this.currentFrame >= this.frames) {
      this.fn();
      this.first = true;
    } else {
      this.currentFrame++;
      window.animationFrame.then(this.watch);
    }
  }

  void tick() {
    this.currentFrame = 0;
    if (this.first) {
      this.first = false;
      window.animationFrame.then(this.watch);
    }
  }
}
