// Array to hold event objects
const events = [];

// Sample events for demo (could be fetched from API in a real app)
function addSampleEvents() {
  events.push(new Event("Music Fest", "2025-06-01", 100, "Music", "Community Hall"));
  events.push(new Event("Baking Workshop", "2025-05-25", 20, "Workshop", "Kitchen Studio"));
  events.push(new Event("Art Exhibition", "2025-05-10", 50, "Art", "Gallery"));
}

// Display event cards dynamically
function displayEvents() {
  const eventList = document.getElementById("eventList");
  eventList.innerHTML = "";

  const now = new Date();

  events.forEach(event => {
    if (event.date >= now && event.checkAvailability()) {
      const card = document.createElement("div");
      card.className = "eventCard";
      card.innerHTML = `
        <h3>${event.name}</h3>
        <p>Date: ${event.date.toDateString()}</p>
        <p>Category: ${event.category}</p>
        <p>Location: ${event.location}</p>
        <p>Seats Left: ${event.seats - event.registrations}</p>
      `;
      eventList.appendChild(card);
    }
  });
}

// Populate dropdown in form with available events
function populateEventDropdown() {
  const select = document.getElementById("eventSelect");
  select.innerHTML = "";

  const now = new Date();

  events.forEach(event => {
    if (event.date >= now && event.checkAvailability()) {
      const option = document.createElement("option");
      option.value = event.name;
      option.textContent = event.name;
      select.appendChild(option);
    }
  });
}

// Handle registration form submit
function setupRegistrationHandler() {
  const form = document.getElementById("registrationForm");

  form.addEventListener("submit", event => {
    event.preventDefault();

    const userName = document.getElementById("userName").value.trim();
    const userEmail = document.getElementById("userEmail").value.trim();
    const selectedEventName = document.getElementById("eventSelect").value;

    if (!userName || !userEmail || !selectedEventName) {
      alert("Please fill all fields.");
      return;
    }

    const eventObj = events.find(e => e.name === selectedEventName);

    if (eventObj && eventObj.register()) {
      alert(Thank you ${userName}, you have successfully registered for ${selectedEventName}!);
      displayEvents();
      populateEventDropdown();
      form.reset();
    } else {
      alert("Sorry, no seats available for this event.");
    }
  });
}

// Initial page setup
function init() {
  addSampleEvents();
  displayEvents();
  populateEventDropdown();
  setupRegistrationHandler();

  console.log("Welcome to the Community Portal");
  window.onload = () => alert("Page fully loaded.");
}

init();