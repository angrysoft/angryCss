import 'dart:html';
import 'dart:core';

class ColorPicker {
  DivElement picker = new DivElement();
  bool visible = false;

  ColorPicker() {
  	TableElement table = new TableElement();
  	List<int> colorCell = new List();
    colorCell = ['255', '223', '191', '158', '127', '95', '63','32', '0'];
    this.picker.style.width = '198px';
    this.picker.style.backgroundColor = 'rgb(255,255,255)';
    this.picker.style.zIndex = "100";
    this.picker.id = 'colorPicker';
    this.picker.style.position = 'absolute';
    TableRowElement r1 = new TableRowElement();
    colorCell.forEach((i) {
      r1.append(
        new TableCellElement()
        ..title = "rgb(${i},${i},${i})"
        ..style.backgroundColor = "rgb(${i},${i},${i})"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r2 = new TableRowElement();
    colorCell.forEach((i) {
      r2.append(
        new TableCellElement()
        ..title = "rgb(${i},255,0)"
        ..style.backgroundColor = "rgb(${i},255,0)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r3 = new TableRowElement();
    colorCell.forEach((i) {
      r3.append(
        new TableCellElement()
        ..title = "rgb(255,${i},0)"
        ..style.backgroundColor = "rgb(255,${i},0)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r4 = new TableRowElement();
    colorCell.forEach((i) {
      r4.append(
        new TableCellElement()
        ..title = "rgb(${i},0,255)"
        ..style.backgroundColor = "rgb(${i},0,255)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r5 = new TableRowElement();
    colorCell.forEach((i) {
      r5.append(
        new TableCellElement()
        ..title = "rgb(${i},125,255)"
        ..style.backgroundColor = "rgb(${i},125,255)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r6 = new TableRowElement();
    colorCell.forEach((i) {
      r6.append(
        new TableCellElement()
        ..title = "rgb(125,${i},255)"
        ..style.backgroundColor = "rgb(125,${i},255)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    TableRowElement r7 = new TableRowElement();
    colorCell.forEach((i) {
      r7.append(
        new TableCellElement()
        ..title = "rgb(125,${i},125)"
        ..style.backgroundColor = "rgb(125,${i},125)"
        ..style.width = '20px'
        ..style.height = '20px'
        ..style.margin = '1px'
      );
    });
    table
      ..append(r1)
      ..append(r2)
      ..append(r3)
      ..append(r4)
      ..append(r5)
      ..append(r6)
      ..append(r7);
    this.picker.append(table);
    this.picker.style.visibility = 'hidden';
  }

  void setPosition(String x, String y) {
    this.picker.style.top = "${x}px";
    this.picker.style.left = "${y}px";
  }

  void toggleShow() {
    if ( this.visible) {
      this.hide();
    } else {
      this.show();
    }
  }

  void show() {
    this.visible = true;
    this.picker.style.visibility = 'visible';
  }

  void hide() {
    this.visible = false;
    this.picker.style.visibility = 'hidden';
  }
}

class TextEditor {
  DivElement editor;
  DivElement editorButtons;
  DivElement editorTextArea;
  ColorPicker cp = new ColorPicker();
  var range;

  TextEditor(var id) {
    this.editor = querySelector('#${id}');
    if ( this.editor == null) {
      throw('Incorect editor id');
    }
    this.editorButtons = querySelector('#${id} .editor-buttons');
    if (this.editorButtons == null) {
      this.editorButtons = new DivElement();
      this.editorButtons.className = 'editor-buttons';
      this.editor.append(this.editorButtons);
    }

    this.editorTextArea = querySelector('#${id} .textArea');
    if (this.editorTextArea == null) {
      this.editorTextArea = new DivElement();
      this.editorTextArea.className = 'textArea';
      this.editor.append(this.editorTextArea);
    }

    this.editorTextArea
      ..contentEditable = 'true'
      ..style.minWidth = this.editorButtons.style.width
      ..style.minHeight = '100px';

    ButtonElement btnBold = new ButtonElement();
    btnBold
      ..name = 'bold'
      ..title = 'Bold'
      ..text = 'B'
      ..onClick.listen((Event e) => this.bold());
    ButtonElement btnItalic = new ButtonElement();
    btnItalic
      ..name = 'italic'
      ..title = 'Italic'
      ..text = 'I'
      ..onClick.listen((Event e) => this.italic());
    ButtonElement btnUnderline = new ButtonElement();
    btnUnderline
      ..name = 'underline'
      ..title = 'Underline'
      ..text = 'U'
      ..onClick.listen((Event e) => this.underline());
    ButtonElement btnStrike = new ButtonElement();
    btnStrike
      ..name = 'strike'
      ..title = 'Strike'
      ..text = 'S'
      ..onClick.listen((Event e) => this.strike());
    ButtonElement btnSubscript = new ButtonElement();
    btnSubscript
      ..name = 'subscript'
      ..title = 'Subscript'
      ..text = 'Sub'
      ..onClick.listen((Event e) => this.subscript());
    ButtonElement btnSuperscript = new ButtonElement();
    btnSuperscript
      ..name = 'superscript'
      ..title = 'Superscript'
      ..text = 'Sup'
      ..onClick.listen((Event e) => this.superscript());
    ButtonElement btnTextLeft = new ButtonElement();
    btnTextLeft
      ..name = 'textLeft'
      ..title = 'Text Left'
      ..text = 'L'
      ..onClick.listen((Event e) => this.textLeft());
    ButtonElement btnTextCenter = new ButtonElement();
    btnTextCenter
      ..name = 'textCenter'
      ..title = 'Text Center'
      ..text = 'C'
      ..onClick.listen((Event e) => this.textCenter());
    ButtonElement btnTextRight = new ButtonElement();
    btnTextRight
      ..name = 'textRight'
      ..title = 'Text Right'
      ..text = 'R'
      ..onClick.listen((Event e) => this.textRight());
    ButtonElement btnTextFull = new ButtonElement();
    btnTextFull
      ..name = 'textFull'
      ..title = 'Text Full'
      ..text = 'F'
      ..onClick.listen((Event e) => this.textFull());
    ButtonElement btnList = new ButtonElement();
    btnList
      ..name = 'unorderedList'
      ..title = 'Lista'
      ..text = '• List'
      ..onClick.listen((Event e) => this.unorderedList());
    ButtonElement btnOrderedList = new ButtonElement();
    btnOrderedList
      ..name = 'orderedList'
      ..title = 'Lista numerowana'
      ..text = '1. List'
      ..onClick.listen((Event e) => this.orderedList());
    ButtonElement btnIndent = new ButtonElement();
    btnIndent
      ..name = 'indent'
      ..title = 'Dodaj wcięcie'
      ..text = '→|'
      ..onClick.listen((Event e) => this.indent());
    ButtonElement btnOutdent = new ButtonElement();
    btnOutdent
      ..name = 'outdent'
      ..title = 'Usuń wcięcie'
      ..text = '|←'
      ..onClick.listen((Event e) => this.outdent());
    ButtonElement btnHorizontalLine = new ButtonElement();
    btnHorizontalLine
      ..name = 'horizontalLine'
      ..title = 'Linia'
      ..text = '–'
      ..onClick.listen((Event e) => this.horizontalLine());
    ButtonElement btnRemoveFormat = new ButtonElement();
    btnRemoveFormat
      ..name = 'removeFormat'
      ..title = 'Usuń formatowanie'
      ..text = 'Usuń Formatowanie'
      ..onClick.listen((Event e) => this.removeFormat());
    ButtonElement btnFontColor = new ButtonElement();
    btnFontColor
      ..name = 'fontColor	'
      ..title = 'Kolor tekstu'
      ..text = 'Color'
      ..onClick.listen((Event e) => this.showColorPicker(e));
    editorButtons
      ..append(btnBold)
      ..append(btnItalic)
      ..append(btnUnderline)
      ..append(btnStrike)
      ..append(btnFontColor)
      ..append(btnSubscript)
      ..append(btnSuperscript)
      ..append(btnTextLeft)
      ..append(btnTextCenter)
      ..append(btnTextRight)
      ..append(btnTextFull)
      ..append(btnIndent)
      ..append(btnOutdent)
      ..append(btnList)
      ..append(btnOrderedList)
      ..append(btnHorizontalLine)
      ..append(cp.picker)
      ..append(btnRemoveFormat);

    querySelectorAll('#colorPicker td').onClick.listen((Event e) => this.setFontColor(e));
    document.execCommand('styleWithCSS', false, 'true');
  }

  void set textArea(String html) {
    NodeValidatorBuilder val = new NodeValidatorBuilder();
    val
      ..allowHtml5()
      ..allowInlineStyles();
    this.editorTextArea.setInnerHtml(html, validator: val);
  }

  String get textArea => this.editorTextArea.innerHtml;

  String get tabindex => this.editorTextArea.getAttribute('tabindex');
  void set tabindex(String idx) {
      this.editorTextArea.setAttribute('tabindex', idx);
  }


  void bold() {
    document.execCommand("bold", null, null);
  }

  void italic() {
    document.execCommand('italic', null, null);
  }

  void underline() {
    document.execCommand('underline', null, null);
  }

  void strike() {
    document.execCommand('strikeThrough', null, null);
  }

  void subscript() {
    document.execCommand('subscript', null, null);
  }

  void superscript() {
    document.execCommand('superscript', null, null);
  }

  void showColorPicker(Event e) {
    ButtonElement btn = e.target;
    int x = btn.offsetTop + btn.offsetHeight;
    int y = btn.offsetLeft;
    this.setRange();
    this.cp.setPosition(x.toString(), y.toString());
    this.cp.toggleShow();
  }

  void setFontColor(Event e) {
    TableCellElement tab = e.target;
    this.setSelection();
    document.execCommand('foreColor', null, tab.title);
    this.cp.hide();
  }

  void textLeft() {
    document.execCommand('justifyLeft', null, null);
  }

  void textCenter() {
    document.execCommand('justifyCenter', null, null);
  }

  void textRight() {
    document.execCommand('justifyRight', null, null);
  }

  void textFull() {
    document.execCommand('justifyFull', null, null);
  }

  void indent() {
    document.execCommand('indent', null, null);
  }

  void outdent() {
    document.execCommand('outdent', null, null);
  }

  void removeLink() {
    document.execCommand('unlink', null, null);
  }

  void orderedList() {
    document.execCommand('insertOrderedList', null, null);
  }

  void unorderedList() {
    document.execCommand('insertUnorderedList', null, null);
  }

  void horizontalLine() {
    document.execCommand('insertHorizontalRule', null, null);
  }

  void addHtml(var html) {
    document.execCommand('insertHtml', null, html);
  }

  void removeFormat() {
    document.execCommand('removeFormat', null, null);
  }

  void setFocus() {
    this.editorTextArea.focus();
  }

  void setSelection() {
    this.editorTextArea.focus();
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(this.range);
  }

  void setRange() {
    this.editorTextArea.focus();
    var sel = window.getSelection();
    this.range = sel.getRangeAt(0);
    sel.removeAllRanges();
  }

  void addCustomButton(ButtonElement btn) {
    this.editorButtons.append(btn);
  }
}
