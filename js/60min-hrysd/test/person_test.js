var assert = require('power-assert');
var Person = require('../src/person.js');

describe('Person', function() {
  describe('#fullname', function() {
    var person = new Person('Hiroshi', 'Yoshida');

    it('return fullname', function() {
      assert(person.fullname() === 'HHYoshida Hiroshi');
    });
  });
});
