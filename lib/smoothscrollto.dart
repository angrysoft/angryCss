import 'dart:html';

class SmoothScrollTo {
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
