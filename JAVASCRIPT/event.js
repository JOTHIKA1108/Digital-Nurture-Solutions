// Event class with properties and methods
class Event {
  constructor(name, date, seats, category, location) {
    this.name = name;
    this.date = new Date(date);
    this.seats = seats;
    this.category = category;
    this.location = location;
    this.registrations = 0;
  }

  checkAvailability() {
    return this.registrations < this.seats;
  }

  register() {
    if (this.checkAvailability()) {
      this.registrations++;
      return true;
    }
    return false;
  }
}