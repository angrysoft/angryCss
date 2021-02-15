
class Button extends HTMLElement {
    // private name:string;
    private root;
    protected sheet:CSSStyleSheet;

    constructor() {
        super();
        this.sheet = new CSSStyleSheet();
        
        this.sheet.insertRule(`button {
            position: relative;
            margin: 0;
            color: #000;
            cursor: pointer;
            border: none;
            border-radius: 2px;
            box-shadow: 0 4px 5px 0 rgba(0,0,0,.14), 0 1px 10px 0 rgba(0,0,0,.12), 0 2px 4px -1px rgba(0,0,0,.2);
            display: inline-block;
            letter-spacing: 0;
            overflow: hidden;
            transition:.2s ease-out;
            outline: none;
            font-weight: 500;
            text-transform: uppercase;
            text-decoration: none;
            text-align: center;
            vertical-align: middle;
            background: rgba(158,158,158,.2);
        }`,0);

        this.sheet.insertRule(`button {
            font-size: 14px;
            height: 36px;
            width: 100%;
            min-width: 64px;
            padding: 0 16px;
            line-height: 36px;
        }`, 1);

        this.sheet.insertRule(`button:active {box-shadow:none;}`, 2);

        this.root = this.attachShadow({ mode: 'open'});
    }
    public connectedCallback() {
        this.root.adoptedStyleSheets = [ this.sheet ];
        this.root.innerHTML = `<button><slot /></button>`
    }
}

class ButtonSmall extends Button {
    constructor() {
        super();
        this.sheet.deleteRule(1);
        this.sheet.insertRule(`button {
            font-size: 12px;
            height: 24px;
            width: 100%;
            min-width: 48px;
            padding: 0 8px;
            line-height: 24px;
        }`, 1);
    }
}

class ButtonFloating extends ButtonSmall {
    constructor() {
        super();
        this.sheet.deleteRule(1);
        this.sheet.insertRule(`button {
            border-radius: 50%;
            font-size: 24px;
            height: 56px;
            margin: auto;
            min-width: 56px;
            width: 56px;
            padding: 0;
            box-shadow: 0 1px 1.5px 0 rgba(0,0,0,.12), 0 1px 1px 0 rgba(0,0,0,.24);
            line-height: normal;
        }`, 1);
    }
}

window.customElements.define('btn-normal', Button);
window.customElements.define('btn-small', ButtonSmall);
window.customElements.define('btn-floating', ButtonFloating);