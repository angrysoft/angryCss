import 'dart:html';
import 'dart:async';
import 'dart:convert';

class SponsorsWidget {
  ImageElement logo;
  //ParagraphElement p;
  List<Map> sponsorList;
  int currentSponsor = 0;

  SponsorsWidget() {
    //this.p = querySelector('.sponsor-widget p');
    this.logo = querySelector('#sponsor-widget-image');
  }

  void run() {
    String url = window.location.pathname + '?action=sponsor';
    HttpRequest http = new HttpRequest();
    http.onReadyStateChange.listen((Event e) {
    if (http.readyState == HttpRequest.DONE &&
        (http.status == 200 || http.status == 0)) {
      var ret = http.responseText;
      if ( ret != '-1') {
        this.sponsorList = JSON.decode(ret);
        this.changeSponsor();
      }
    }
    });
    http.open('POST', url, async: true);
    http.send();
  }

  void changeSponsor() {
    Map sp = this.sponsorList[this.currentSponsor];
    this.logo.src = sp['logo'];
    /*
    this.p.setInnerHtml(sp['category']);
    this.p.classes.add('lightSpeedIn');
    new Timer(new Duration(seconds: 3), () => this.p.classes.remove('lightSpeedIn'));
    */
    this.currentSponsor++;
    if (this.currentSponsor >= this.sponsorList.length) {
      this.currentSponsor = 0;
    }
    new Timer(new Duration(seconds: sp['time']), () => this.changeSponsor());
  }

}

class GalleryWidget {

  GalleryWidget() {

  }

  void run() {
    String url = window.location.pathname + '?action=photo';
    HttpRequest http = new HttpRequest();
    http.onReadyStateChange.listen((_) {
    if (http.readyState == HttpRequest.DONE &&
        (http.status == 200 || http.status == 0)) {
      var src = http.responseText;
      if ( src != '-1') {
        var img = querySelector('#gallery-widget-image');
        img.src = src;
      }
    }
    });
    http.open('POST', url, async: true);
    http.send();
    new Timer(new Duration(seconds: 5), () => this.run());
  }

}
/*
class RefreshWidget {
  var currentPhotoFrame;
  var currentSponsorFrame;
  var photoRefreshFrame;
  var sponsorRefreshFrame;

  RefreshWidget([var photoTime = 5000, var sponsorTime = 6000]) {
    this.currentPhotoFrame = 0;
    this.currentSponsorFrame = 0;
    this.photoRefreshFrame = (photoTime / (1000 / 60)).round();
    this.sponsorRefreshFrame = (sponsorTime / (1000 / 60)).round();
  }

  void refreshPhoto() {
    String url = window.location.pathname + '?action=photo';
    HttpRequest http = new HttpRequest();
    http.onReadyStateChange.listen((_) {
    if (http.readyState == HttpRequest.DONE &&
        (http.status == 200 || http.status == 0)) {
      var src = http.responseText;
      if ( src != '-1') {
        var img = querySelector('.galeria img');
        img.src = src;
      }
    }
    });
    http.open('POST', url, async: true);
    http.send();
  }

  void refreshSponsor() {
    String url = window.location.pathname + '?action=sponsor';
    HttpRequest http = new HttpRequest();
    http.onReadyStateChange.listen((_) {
    if (http.readyState == HttpRequest.DONE &&
        (http.status == 200 || http.status == 0)) {
      var ret = http.responseText;
      if ( ret != '-1') {
        Map sp = JSON.decode(ret);
        var p = querySelector('.sponsor p');
        var img = querySelector('.sponsor img');
        img.src = sp['logo'];
        p.setInnerHtml(sp['category']);
        p.classes.add('lightSpeedIn');
        new Timer(new Duration(seconds: 3), () => p.classes.remove('lightSpeedIn'));
      }
    }
    });
    http.open('POST', url, async: true);
    http.send();
  }

  void tick(num frame) {
    if (this.currentPhotoFrame == this.photoRefreshFrame) {
      this.refreshPhoto();
      this.currentPhotoFrame = 0;
    } else if (this.currentSponsorFrame == this.sponsorRefreshFrame) {
      this.refreshPhoto();
      this.currentSponsorFrame = 0;
    }
    this.currentPhotoFrame++;
    this.currentSponsorFrame++;
    window.requestAnimationFrame(this.tick);
  }
}
*/
