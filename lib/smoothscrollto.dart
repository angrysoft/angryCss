import 'dart:html';

class SmoothScrollTo_old {
  var totalFrames;
  var currentFrame;
  var scrollStep;
  var body;

  SmoothScrollTo() {
    this.body = querySelector('body');
  }

  void click(var id, [int duration = 500]) {
  	var startPos = window.scrollY;
  	var endPos = querySelector(id).offsetTop;
    this.totalFrames = ( duration / (1000 / 60) ).round();

    if ( endPos > startPos ) {
      this.scrollStep = ((endPos - startPos) / this.totalFrames);
    } else {
      this.scrollStep = ((startPos - endPos) / this.totalFrames * -1);
    }
    this.currentFrame = 0;
    this.body.style.pointerEvents = 'none';
    //window.animationFrame.then(this.scroll);
    window.requestAnimationFrame(this.scroll);
  }

  void scroll(num frame) {
    if (this.currentFrame < this.totalFrames) {
      //new Future(() => window.scrollBy(0, this.scrollStep));
      window.scrollBy(0, this.scrollStep);
      this.currentFrame++;
      //window.animationFrame.then(this.scroll);
      window.requestAnimationFrame(this.scroll);
    } else {
      this.body.style.pointerEvents = 'auto';
    }
  }
}

class SmoothScrollTo {
  int scrollStep;
  BodyElement body;
  int startPos;
  int endPos;
  String direction;

  SmoothScrollTo() {
    this.body = querySelector('body');
  }

  void click(var id, [int duration = 500]) {
  	this.startPos = window.scrollY;
  	this.endPos = querySelector(id).offsetTop;
  	int steps = ( duration / (1000 / 60) ).round();
    this.scrollStep = ((this.endPos - this.startPos) / steps).round();

    this.body.style.pointerEvents = 'none';
    window.animationFrame.then(this.scroll);
  }

  void scroll(num time) {
    print("${time} ${window.scrollY} ${this.endPos}");
    if (window.scrollY != this.endPos) {
      window.scrollBy(0, this.scrollStep);
      window.animationFrame.then(this.scroll);
    } else {
      this.body.style.pointerEvents = 'auto';
    }
  }
}
