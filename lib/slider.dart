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
  Duration delaySec = new Duration(seconds: 4);
  Duration animationTimeSec = new Duration(seconds: 1);
  Timer delayTimer;
  String animationNext = '';
  String animationPrev = '';

  String get animationNameNext => this.animationNext;
  void set animationNameNext(String name) {
    this.animationNext = name;
  }

  String get animationNamePrev => this.animationPrev;
  void set animationNamePrev(String name) {
    this.animationPrev = name;
  }

  int get animationTime => this.animationTimeSec.inSeconds;
  void set animaitonTime(int sec) {
    this.animationTimeSec = new Duration(seconds: sec);
  }

  int get delay => this.delaySec.inSeconds;
  void set delay(int sec) {
    this.delaySec = new Duration(seconds: sec);
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

    if (this.arrowLeft != null) {
      this.arrowLeft.onClick.listen((Event e) => this.prevSlide());
    }

    if (this.arrowRight != null) {
      this.arrowRight.onClick.listen((Event e) => this.nextSlide());
    }
  }

  void clearImageList() {
    this.slideList.clear();
  }

  void addImage(String imagePath) {
    this.slideList.add(imagePath);
    //print(imagePath);
  }

  void run() {
    this.mainImage.src = this.slideList.first;
    this.currentImageNum = 0;
    this.setImages();
    this.delayTimer = new Timer.periodic(delaySec, (Timer t) => this.nextSlide());
  }

  void nextSlide() {
    this.mainImage.classes.add(this.animationNext);
    this.lastImage.src = this.mainImage.currentSrc;
    this.mainImage.src = this.nextImage.currentSrc;
    new Timer(this.animationTimeSec, ()=> this.mainImage.classes.remove(this.animationNext));
    this.currentImageNum++;
    if (this.currentImageNum >= this.slideList.length) {
      this.currentImageNum = 0;
    }
    this.setImages();
  }

  void prevSlide() {
    this.mainImage.classes.add(this.animationPrev);
    this.lastImage.src = this.mainImage.currentSrc;
    this.mainImage.src = this.prevImage.currentSrc;
    new Timer(this.animationTimeSec, ()=> this.mainImage.classes.remove(this.animationPrev));
    this.currentImageNum--;
    if (this.currentImageNum < 0) {
      this.currentImageNum = this.slideList.length - 1;
    }
    this.setImages();
  }

  void changeSlide(String src) {

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
    //print('after <-(${this.prevImageNum})=(${this.currentImageNum})=(${this.nextImageNum})->, ${lastImageNum}');
    this.nextImage.src = this.slideList[this.nextImageNum];
    this.prevImage.src = this.slideList[this.prevImageNum];
  }
}


