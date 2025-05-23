function validatePhone(input) {
  const pattern = /^[0-9]{10}$/;
  if (!pattern.test(input.value)) {
    alert("Enter a valid 10-digit phone number.");
    input.focus();
  }
}

function updateFee(select) {
  const fee = select.value;
  document.getElementById("eventFee").textContent = "Event Fee: ₹" + fee;
  localStorage.setItem("preferredEventFee", fee);
}

function showConfirmation() {
  document.getElementById("confirmation").textContent = "Registration successful!";
  return false;
}

function enlarge(img) {
  img.style.transform = "scale(1.5)";
  img.style.transition = "transform 0.3s";
}

function countCharacters(textarea) {
  document.getElementById("charCount").textContent = textarea.value.length + " characters";
}

function videoReady() {
  document.getElementById("videoStatus").textContent = "Video ready to play";
}

function getLocation() {
  const output = document.getElementById("locationOutput");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        output.innerHTML = "Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude;
      },
      (error) => {
        output.innerHTML = "Error getting location: " + error.message;
      },
      { enableHighAccuracy: true, timeout: 5000 }
    );
  } else {
    output.textContent = "Geolocation is not supported.";
  }
}

function clearPreferences() {
  localStorage.clear();
  sessionStorage.clear();
  alert("Preferences cleared.");
}

window.onload = function () {
  const fee = localStorage.getItem("preferredEventFee");
  if (fee) {
    const select = document.querySelector("select");
    select.value = fee;
    updateFee(select);
  }
};