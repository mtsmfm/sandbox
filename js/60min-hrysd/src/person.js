class Person {
  constructor(firstname, lastName) {
    this.firstName = firstName
    this. lastname = lastname
  }

  fullname() {
    return `${this.lastName} ${this.firstName}`;
  }
}

export default Person;
