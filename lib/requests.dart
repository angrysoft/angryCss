import 'dart:html';
import 'dart:async';

/*
HttpRequest.request('/submit', method: 'POST', sendData: data)
  .then((HttpRequest resp) {
    // Do something with the response.
});
 */

/*
HttpRequest.getString(path)
    .then((String fileContents) {
      print(fileContents.length);
    })
    .catchError((Error error) {
      print(error.toString());
    });
 */


class UrlResponse {
  String baseUrl;
  Map<String,String> args = new Map();

  void set url(String u) {
    this.baseUrl = u;
  }

  String get url {
    if (this.args.isEmpty) {
      return this.baseUrl;
    }

    List<String> ret = new List();
    this.args.forEach((k, v) {
      ret.add('${k}=${v}');
    });
    return '${this.baseUrl}?${ret.join('&')}';
  }
}

class Requests {
  HttpRequest http;
  String requestUrl;
  Map<String,String> requestsArgs;
  String received = '';
  StreamController receivedEvent = new StreamController.broadcast();
  Stream get onReceived => receivedEvent.stream;

  Requests() {
    this.http = new HttpRequest();
    this.requestsArgs = new Map();
    this.requestUrl = '';

    http.onReadyStateChange.listen((Event e) {
      if (http.readyState == HttpRequest.DONE && http.status == 200 ) {
        this.received = http.responseText;
        this.receivedEvent.add('received');
      }
    });
  }

  void set url(String u) {this.requestUrl = u;}
  String get url => this.requestUrl;

  void addArg(String name, String value) {
    if (requestsArgs.containsKey(name)) {
      throw('Arg ${name} already exist');
    }
    this.requestsArgs[name] = value;
  }

  void setArg(String name, String value) {
    if (requestsArgs.containsKey(name)) {
      this.requestsArgs[name] = value;
    } else {
      throw('Arg ${name} not exist');
    }
  }

  void removeArg(String name) {
    if (requestsArgs.containsKey(name)) {
      this.requestsArgs.remove(name);
    } else {
      throw('Arg ${name} not exist');
    }
  }

  void removeAllArgs() {
    this.requestsArgs.clear();
  }

  String _makeUrl() {
    if (this.requestsArgs.isEmpty) {
      return this.requestUrl;
    }
    List<String> ret = new List();
    this.requestsArgs.forEach((k, v) {
      ret.add('${k}=${v}');
    });
    return '${this.requestUrl}?${ret.join('&')}';
  }

  void _send(String method, {data: null}) {
    String u = this._makeUrl();
    this.http.open(method, u, async: true);
    if (data != null) {
      this.http.send(data);
    } else {
     this.http.send();
    }
  }

  void get() {
    this._send('GET');
  }

  void post() {
    this._send('POST');
  }

  void put() {
    this._send('PUT');
  }

  void delete() {
    this._send('DELETE');
  }

  void postData(var data) {
    this._send('POST', data: data );
  }

}