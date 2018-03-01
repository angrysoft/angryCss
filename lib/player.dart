import 'dart:html';

//TODO: http://stream.radiowoodstock.pl:8000/currentsong?sid=1
class AudioPlayer {
  AudioElement player;

  AudioPlayer(var id) {
    this.player = querySelector(id);
  }

  String get url => this.player.src;
  set url(var url) => this.player.src = url;

  void play() {
    this.player.play();
  }

  void pause() {
    this.player.pause();
  }
  bool get autoplay => this.player.autoplay;
  set autoplay(bool a) => this.player.autoplay = a;

  String togglePlay() {
    if (this.player.paused) {
      this.player.play();
      return "Pause";
    } else {
      this.player.pause();
      return "Play";
    }
  }

  String toogleMute() {
    if (this.player.muted) {
      this.player.muted = false;
      return 'mute';
    } else {
      this.player.muted = true;
      return 'unmute';
    }
  }

  set volume(int value) {
    if (value >= 0 && value <= 10) {
      this.player.volume = value / 10;
    }
  }
}