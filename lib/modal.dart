import 'dart:html';

class Modal {
  DivElement modalContainer = new DivElement();
  DivElement modalContent = new DivElement();
  DivElement modalHeader = new DivElement();
  DivElement modalBody = new DivElement();
  DivElement modalFooter = new DivElement();

  List get body => this.modalBody.nodes;

  String get header => this.modalHeader.text;

  void set header(String text) {
    this.modalHeader.text = text;
  }

  String get footer => this.modalFooter.text;

  void set footer(String text) {
    this.modalFooter.text = text;
  }

  void set zindex(String zi) {
    this.modalContainer.style.zIndex = zi;
  }

  String get zindex => this.modalContainer.style.zIndex;

  Modal() {
    this.modalContainer.className = 'modal';
    //this.modalContainer.id = id;
    this.modalContent.className = 'modal-content';
    this.modalContainer.nodes.add(this.modalContent);
    this.modalHeader.className = 'modal-header';
    this.modalContent.nodes.add(this.modalHeader);
    this.modalBody.className = 'modal-body';
    this.modalContent.nodes.add(this.modalBody);
    this.modalFooter.className = 'modal-footer';
    this.modalContent.nodes.add(this.modalFooter);
    document.body.nodes.add(this.modalContainer);
  }

  Modal.fromHtml(String id) {
    this.modalContainer = querySelector('#${id}');
    this.modalContent = querySelector('#${id} .modal-content');
    this.modalHeader = querySelector('#${id} .modal-header');
    this.modalBody = querySelector('#${id} .modal-body');
    this.modalFooter = querySelector('#${id} .modal-footer');
  }

  void show() {
    this.modalContainer.classes.add('modal-show');
  }

  void hide() {
    this.modalContainer.classes.remove('modal-show');
  }

  String get bodyHtml => this.modalBody.innerHtml;
  set bodyHtml(String html) => this.modalBody.setInnerHtml(html);

  void bodyAdd(Element el) {
    this.modalBody.nodes.add(el);
  }

  void bodyClear() {
    this.modalBody.nodes.clear();
  }
}

class ModalDialog extends Modal {
  ModalDialog() : super() {
    this.modalContainer.className = 'modal-dialog';
  }

  ModalDialog.fromHtml(var id) : super.fromHtml(id);
}

class ModalSmall extends Modal {
  ModalSmall() : super() {
    this.modalContainer.className = 'modal-small';
  }
  ModalSmall.fromHtml(var id) : super.fromHtml(id);
}

void alert(String msg) {
  ModalSmall info = new ModalSmall();
  DivElement div = new DivElement();
  ParagraphElement alertMsg = new ParagraphElement();
  ButtonElement okBtn = new ButtonElement();
  alertMsg.text = msg;
  okBtn.text = 'ok';
  div.nodes.add(alertMsg);
  div.nodes.add(okBtn);
  info.header = 'Info';
  info.bodyAdd(div);
  okBtn.onClick.listen((Event e) => info.hide());
  info.show();
}
