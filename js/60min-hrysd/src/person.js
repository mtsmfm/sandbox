class Person {
  constructor(firstName, lastName) {
    this.firstName = firstName
    this.lastName = lastName
  }

  fullname() {
    return `${this.lastName} ${this.firstName}`;
  }
}

export default Person;
