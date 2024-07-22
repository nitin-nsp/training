const submitHandler = async (e) => {
  e.preventDefault();

  const formData = new FormData(e.target);
  console.log("formData", formData)
  console.log("e.target", e.target);
  let isValid = true;

  // Validate form fields
  const emailRegex = /^[A-Za-z0-9._%+-]+@abc\.in$/;
  const phoneRegex = /^[0-9]{10}$/;
  const passwordRegex =
    /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,20}$/;

  if (!emailRegex.test(formData.get("email"))) {
    showError("email", "Please enter a valid habilelabs email address.");
    isValid = false;
  } else {
    hideError("email");
  }

  if (!phoneRegex.test(formData.get("phone"))) {
    showError("phone", "Please enter a valid 10-digit phone number.");
    isValid = false;
  } else {
    hideError("phone");
  }

  if (!passwordRegex.test(formData.get("password"))) {
    showError(
      "password",
      "Password should be 8-20 characters and include at least 1 letter, 1 number, and 1 special character!"
    );
    isValid = false;
  } else {
    hideError("password");
  }

  if (isValid) {
    formData.forEach((value, key) => {
      console.log(key, value);
      window.localStorage.setItem(key, value);
    });
    console.log("Form is valid. Proceeding with submission.");
  }
};

function showError(inputId, errorMessage) {
  const inputField = document.getElementById(inputId);
  const errorContainer =
    inputField.parentElement.querySelector(".error-message");
  errorContainer.innerHTML = errorMessage;
  errorContainer.style.color = "red";
}

function hideError(inputId) {
  const inputField = document.getElementById(inputId);
  const errorContainer =
    inputField.parentElement.querySelector(".error-message");
  errorContainer.innerHTML = "";
}
