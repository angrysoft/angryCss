import { BaseComponent, Css } from "./basecomponent.js";


class Button extends BaseComponent {
    

    constructor() {
        super();
        this.sheet.insertRule(`button {
            display: inline-block;
            transition:.2s ease-out;
            position: relative;
            overflow: hidden;
            width: 100%;
            height: 36px;
            min-width: 64px;
            margin: 0;
            padding: 0 16px;
            border: none;
            border-radius: 2px;
            box-shadow: 0 4px 5px 0 rgba(0,0,0,.14), 0 1px 10px 0 rgba(0,0,0,.12), 0 2px 4px -1px rgba(0,0,0,.2);
            outline: none;
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            text-decoration: none;
            text-align: center;
            letter-spacing: 0;
            vertical-align: middle;
            line-height: 36px;
            color: #000;
            cursor: pointer;
            background: rgba(158,158,158,.2);
        }`, 0);

        this.sheet.insertRule(`button:active {box-shadow:none;}`, 1);

        this.html = `<button><slot /></button>`;
        let css = new Css();
        console.log(css);
    }

    
    static get observedAttributes() {
        return ['color'];
    }

    public attributeChangedCallback(name:string, oldValue:string, newValue:string) {
        console.log(`${name}'s value has been changed from ${oldValue} to ${newValue}`);
        // switch(name) {
        //     case "color":
        //         this.setColor(newValue);
        //         break;

        // }
    }

    private setColor(value:string) {
        console.log(value);

    }
    
}

class ButtonSmall extends Button {
    constructor() {
        super();
        let rule:CSSStyleRule = this.sheet.rules[0] as CSSStyleRule;
        rule.style.fontSize = "12px";
        rule.style.height = "24px";
        rule.style.width = "100%";
        rule.style.minWidth = "48px";
        rule.style.padding = "0 8px";
        rule.style.lineHeight = "24px";
    }
}

class ButtonFloating extends Button {
    constructor() {
        super();
        let rule:CSSStyleRule = this.sheet.rules[0] as CSSStyleRule;
        rule.style.borderRadius = "50%";
        rule.style.fontSize = "24px";
        rule.style.height = "56px";
        rule.style.width = "56px";
        rule.style.minWidth = "56px";
        rule.style.padding = "0";
        rule.style.lineHeight = "24px";
        rule.style.boxShadow = "0 1px 1.5px 0 rgba(0,0,0,.12), 0 1px 1px 0 rgba(0,0,0,.24)";
    }
}

window.customElements.define('button-normal', Button);
window.customElements.define('button-small', ButtonSmall);
window.customElements.define('button-floating', ButtonFloating);
