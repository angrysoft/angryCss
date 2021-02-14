
export class Button extends HTMLElement {
    // private name:string;
    private const root;
    private const sheet:CSSStyleSheet;

    constructor() {
        super();
        this.sheet = new CSSStyleSheet();
        /* Normalize */
        sheet.insertRule(`button {
            font-family: inherit;
            font-size: 100%;
            line-height: 1.15;
            margin: 0;
            overflow: visible;
          }`);
        
        sheet.insertRule(`button {
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
        }`);
        this.root = this.attachShadow({ mode: 'open'});
        // this.root.adopted
        this.root.adoptedStyleSheets = 
    }
}

window.customElements.define('btn', Button);