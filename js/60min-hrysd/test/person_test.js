import assert from 'power-assert';
import Person from '../src/person.js';

describe('Person', () => {
  describe('#fullname', () => {
    var person = new Person('Hiroshi', 'Yoshida');

    it('return fullname', () => {
      assert(person.fullname() === 'HHYoshida Hiroshi');
    });
  });
});
