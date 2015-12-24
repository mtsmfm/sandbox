"use strict"

class Star {
  constructor() {
    this.lines = [
    {
      'A': 'W',
      'J': 'R',
      'I': 'R',
      'C': 'W',
    },
    {
      'C': 'W',
      'H': 'R',
      'G': 'R',
      'E': 'W',
    },
    {
      'E': 'W',
      'F': 'R',
      'J': 'R',
      'B': 'W',
    },
    {
      'B': 'W',
      'I': 'R',
      'H': 'R',
      'D': 'W',
    },
    {
      'D': 'W',
      'G': 'R',
      'F': 'R',
      'A': 'W',
    },
    ]
  }

  toString() {
    return 'ABCDEFGHIJ'.split('').map((e) => this.value(e)).join('');
  }

  reverse(point) {
    this.reversePoint(point);

    this.lines.filter((line) => { return point in line });

    console.log(this.toString());

    switch(point) {
      case 'F':
        if (this.value(point) == this.value('B')) {
          this.applyValue('J', this.value(point));
        }
        if (this.value(point) == this.value('D')) {
          this.applyValue('G', this.value(point));
        }
        break;
      case 'G':
        if (this.value(point) == this.value('C')) {
          this.applyValue('H', this.value(point));
        }
        if (this.value(point) == this.value('A')) {
          this.applyValue('F', this.value(point));
        }
        break;
      case 'H':
        if (this.value(point) == this.value('B')) {
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('E')) {
          this.applyValue('G', this.value(point));
        }
        break;
      case 'I':
        if (this.value(point) == this.value('A')) {
          this.applyValue('J', this.value(point));
        }
        if (this.value(point) == this.value('D')) {
          this.applyValue('H', this.value(point));
        }
        break;
      case 'J':
        if (this.value(point) == this.value('E')) {
          this.applyValue('F', this.value(point));
        }
        if (this.value(point) == this.value('C')) {
          this.applyValue('I', this.value(point));
        }
        break;
      case 'A':
        if (this.value(point) == this.value('C')) {
          this.applyValue('J', this.value(point));
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('I')) {
          this.applyValue('J', this.value(point));
        }
        if (this.value(point) == this.value('D')) {
          this.applyValue('G', this.value(point));
          this.applyValue('F', this.value(point));
        }
        if (this.value(point) == this.value('G')) {
          this.applyValue('F', this.value(point));
        }
        break;
      case 'B':
        if (this.value(point) == this.value('D')) {
          this.applyValue('H', this.value(point));
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('H')) {
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('E')) {
          this.applyValue('J', this.value(point));
          this.applyValue('F', this.value(point));
        }
        if (this.value(point) == this.value('F')) {
          this.applyValue('J', this.value(point));
        }
        break;
      case 'C':
        if (this.value(point) == this.value('A')) {
          this.applyValue('J', this.value(point));
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('J')) {
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('E')) {
          this.applyValue('H', this.value(point));
          this.applyValue('G', this.value(point));
        }
        if (this.value(point) == this.value('G')) {
          this.applyValue('H', this.value(point));
        }
        break;
      case 'D':
        if (this.value(point) == this.value('B')) {
          this.applyValue('H', this.value(point));
          this.applyValue('I', this.value(point));
        }
        if (this.value(point) == this.value('I')) {
          this.applyValue('H', this.value(point));
        }
        if (this.value(point) == this.value('A')) {
          this.applyValue('G', this.value(point));
          this.applyValue('F', this.value(point));
        }
        if (this.value(point) == this.value('F')) {
          this.applyValue('G', this.value(point));
        }
        break;
    }
  }

  value(point) {
    return this.lines.find((line) => {
      return (point in line);
    })[point];
  }

  reversePoint(point) {
    this.lines.forEach((e) => {
      if (point in e) {
        e[point] = e[point] == 'W' ? 'R' : 'W';
      }
    })
  }

  applyValue(point, value) {
    this.lines.forEach((e) => {
      if (point in e) {
        e[point] = value;
      }
    })
  }
}

const solve = (input) => {
  const star = new Star();
  input.split("").forEach((c) => {
    star.reverse(c);
  })

  return star.toString();
}

const test = (input, expected) => {
  const actual = solve(input);
  if (expected == actual) {
    console.log(input + ': passed')
  } else {
    console.log(`${input} : failed,  expect : ${expected} but got ${actual}`)
  }
}

//test("A", "RWWWWRRRRR");
//test("F", "WWWWWWWRRW");
//test("J", "WWWWWWRRWW");
//test("AA", "WWWWWWWRWW");
//test("IC", "WWRWWRRRWW");
//test("FC", "WWRWWWWRRW");
//test("AE", "RWWWRRRRRR");
//test("GJ", "WWWWWWWWWW");
//test("CCB", "WRWWWRWWWR");
//test("BEF", "WRWWRWWRRR");
//test("JGD", "WWWRWWWWWW");
//test("IHCC", "WWWWWRWWWW");
//test("AIDD", "RWWWWRRWWR");
//test("IJFA", "RWWWWWWWWW");
//test("ABCDE", "RRRRRRRRRR");
//test("ICEBA", "RRRWRRRRRR");
//test("DAHHD", "RWWWWRWWWR");
//test("GJIJC", "WWRWWWWWRR");
//test("FGHIJ", "WWWWWWWWRR");
//test("HJICGA", "RWRWWRRRRR");
//test("IBCIGC", "WRWWWWWWWW");
//test("BIJJJB", "WWWWWWRWWW");
//test("DCBCHGD", "WRWWWWWRRW");
//test("JEABDHD", "RRWWRRRWRR");
//test("JHFADHE", "RWWRRRRRWW");
//test("HDGGDBIB", "WWWWWWWWWW");
//test("IIDIHCCG", "WWWRWRRWWW");
test("BBFBICIE", "WRRWRRRWWW");
//test("HJHCFBJGG", "WRRWWWWRRW");
//test("AJJIEAAII", "RWWWRWWWWR");
//test("AIDHJFGAE", "WWWRRWWWWW");
//test("FGBGHCBHJJ", "WWRWWWWRRW");
//test("EFIGIGGHHJ", "WWWWRRRWWR");
//test("HGAFDIFFFF", "RWWRWRRRRW");
//test("AABBCCDDEE", "WWWWWWWWWW");
//test("ABCDEFGHIJ", "RRRRRWWWWW");
//test("FGHIJABCDE", "RRRRRRRRRR");
