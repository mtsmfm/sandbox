function Hoge() {
  this.hoge = 1;
}
Hoge.HOGE = 'HOGE';

var hoge = new Hoge();
console.log(hoge.hoge);
console.log(Hoge.HOGE);

var old = Hoge;
Hoge = function () {
  this.hoge = 2;
}
Object.assign(Hoge, old);

var fuga = new Hoge();
console.log(fuga.hoge);
console.log(Hoge.HOGE);
