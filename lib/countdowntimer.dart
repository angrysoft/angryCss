class CountDownTimer {
  DateTime endDate;
  Duration difference;
  Duration days;
  Duration hours;
  Duration minutes;
  Duration seconds;

  CountDownTimer(num year, num month, num day, num hour, num minute) {
    this.endDate = new DateTime(year, month, day, hour, minute);
  }

  String getRemaining() {
    this.difference = this.endDate.difference(new DateTime.now());
    if (this.difference.inSeconds <= 0) {
      return '';
    }
    this.days = new Duration(days: this.difference.inDays);
    this.hours = new Duration(hours: (this.difference - this.days).inHours);
    this.minutes = new Duration(minutes: (this.difference - this.days - this.hours).inMinutes);
    this.seconds = new Duration(seconds: (this.difference - this.days - this.hours - this.minutes).inSeconds);
    return '${this.days.inDays}d ${this.hours.inHours}h ${this.minutes.inMinutes}m ${this.seconds.inSeconds}s';
  }
}