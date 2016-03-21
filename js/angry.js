function menuToggle() {
    var li = document.querySelectorAll('nav > ul');
    var lilen = li.length;
    for (var i=0; i < lilen ;i++) {
        li[i].classList.toggle('showMenu');
    }
}

function menuClick() {
    var m = document.querySelector('nav > ul > li.menu');
    m.addEventListener('click', menuToggle);
}

function addLoadListener(fn) {
  //mozilla and friends
  if (typeof window.addEventListener != 'undefined') {
    window.addEventListener('load', fn, false);
  }
  //opera
  else if (typeof document.addEventListener != 'undefined') {
    document.addEventListener('load', fn, false);
  }
  //innernetz exploder
  else if (typeof window.attachEvent != 'undefined') {
    window.attachEvent('onload', fn);
  }
}

addLoadListener(menuClick);

document.getElementsByCl
// test
