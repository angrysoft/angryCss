import 'dart:html';
import 'dart:core';
import 'dart:async';

class Slider {
  List<String> slideList = new List();
  int currentImageNum = -1;
  int nextImageNum = 0;
  int prevImageNum = 0;
  ImageElement mainImage;
  ImageElement prevImage = new ImageElement();
  ImageElement nextImage = new ImageElement();
  ImageElement lastImage = new ImageElement();
  DivElement slider;
  Element arrowLeft;
  Element arrowRight;
  Duration animationTimeSec = new Duration(seconds: 1);
  String animationNext = '';
  String animationPrev = '';
  num delayTime = 4000;
  StreamSubscription eventBtnNext = null;
  StreamSubscription eventBtnPrev = null;
  num animationTime = 1000;
  num currentTime = 0;
  num startTime = 0;
  num stopTime = 0;
  num animationStop = -1;

  String get animationNameNext => this.animationNext;
  void set animationNameNext(String name) {
    this.animationNext = name;
  }

  String get animationNamePrev => this.animationPrev;
  void set animationNamePrev(String name) {
    this.animationPrev = name;
  }

  int get animationFadeTime => (this.animationTime / 1000).round();
  void set animationFadeTime(int sec) {
    this.animationTime = sec * 1000;
  }

  int get delay => (this.delayTime / 1000).round();
  void set delay(int sec) {
    this.delayTime = sec * 1000;
  }

  Slider(String id) {
    this.slider = querySelector('#${id}');
    this.lastImage = querySelector('#${id} .prevSlide');
    this.mainImage = querySelector('#${id} .currentSlide');
    this.arrowLeft = querySelector('#${id} .arrow-left');
    this.arrowRight = querySelector('#${id} .arrow-right');
    this.lastImage.className = 'prevSlide';
    this.mainImage.className = 'currentSlide animated';
    if (this.mainImage == null) {
      this.mainImage = new ImageElement();
      this.mainImage.className = 'slide';
      this.slider.append(this.mainImage);
    }

    this.setArrows();

  }

  void setArrows() {
    if (this.arrowLeft != null) {
      this.eventBtnPrev = this.arrowLeft.onClick.listen((Event e) => this.prevSlide());
    }

    if (this.arrowRight != null) {
      this.eventBtnNext = this.arrowRight.onClick.listen((Event e) => this.nextSlide());
    }
  }

  void unsetArrows() {
    if (this.arrowLeft != null) {
      this.eventBtnPrev.cancel();
    }

    if (this.arrowRight != null) {
      this.eventBtnNext.cancel();
    }
  }

  void clearImageList() {
    this.slideList.clear();
  }

  void addImage(String imagePath) {
    this.slideList.add(imagePath);
  }

  void run() {
    this.mainImage.src = this.slideList.first;
    this.currentImageNum = 0;
    this.setImages();
    window.animationFrame.then(this.setStartFrame);
  }

  void nextSlide() {
    this.stopTime = this.currentTime + this.delayTime;
    this.mainImage.classes.add(this.animationNext);
    this.lastImage.src = this.mainImage.currentSrc;
    this.mainImage.src = this.nextImage.currentSrc;
    this.unsetArrows();
    this.currentImageNum++;
    if (this.currentImageNum >= this.slideList.length) {
      this.currentImageNum = 0;
    }
    this.setImages();
    window.animationFrame.then(this.animationRemove);
    //new Timer(this.animationTimeSec, ()=> this.mainImage.classes.remove(this.animationNext));
  }

  void prevSlide() {
    this.stopTime = this.currentTime + this.delayTime;
    this.mainImage.classes.add(this.animationPrev);
    this.lastImage.src = this.mainImage.currentSrc;
    this.mainImage.src = this.prevImage.currentSrc;
    this.unsetArrows();
    this.currentImageNum--;
    if (this.currentImageNum < 0) {
      this.currentImageNum = this.slideList.length - 1;
    }
    this.setImages();
    window.animationFrame.then(this.animationRemove);
    //new Timer(this.animationTimeSec, ()=> this.mainImage.classes.remove(this.animationPrev));
  }

  void animationRemove(num time) {
    if (this.animationStop < 0 ) {
      this.animationStop = time + this.animationTime;
    }

    if (time >= this.animationStop) {
      this.mainImage.classes.remove(this.animationNext);
      this.mainImage.classes.remove(this.animationPrev);
      this.animationStop = -1;
      this.setArrows();
    } else {
      window.animationFrame.then(this.animationRemove);
    }
  }

  void setStartFrame(num time) {
    this.startTime = time;
    this.stopTime = time + this.delayTime;
    window.animationFrame.then(this.changeSlide);
  }

  void changeSlide(num time) {
    this.currentTime = time;
    if (time >= this.stopTime) {
      this.nextSlide();
    }
    window.animationFrame.then(this.changeSlide);

  }

  void setImages() {
    if (this.slideList.length == 1 ) {
      return;
    }
    this.nextImageNum = this.currentImageNum + 1;
    this.prevImageNum = this.currentImageNum - 1;
    int lastImageNum = this.slideList.length - 1;
    if (this.nextImageNum > lastImageNum) {
      this.nextImageNum = 0;
    }

    if (this.prevImageNum < 0) {
      this.prevImageNum = lastImageNum;
    }
    this.nextImage.src = this.slideList[this.nextImageNum];
    this.prevImage.src = this.slideList[this.prevImageNum];
  }
}


