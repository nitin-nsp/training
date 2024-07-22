function showError(inputId, errorMessage) {
    const errorContainer = document.querySelector(`#${inputId}Error-msg`);
    errorContainer.textContent = errorMessage;
    errorContainer.style.display = "block";
    console.log('showErro user => ', errorContainer)


}

function hideError(inputId) {
    const errorContainer = document.querySelector(`#${inputId}Error-msg`);
    console.log('showErro user => ', errorContainer, inputId)
    errorContainer.textContent = "";
    errorContainer.style.display = "none";
}




function debounce(func, delay) {
    let timeoutId;
    return function () {
        const context = this;
        const args = arguments;
        clearTimeout(timeoutId);
        console.log('in debounce', func, delay)
        timeoutId = setTimeout(() => {
            func.apply(context, args);
        }, delay);
    };
}

function formValidationHandler() {
    return (
        userNameValidator() &&
        emailValidator() &&
        passwordValidator() &&
        confirmPasswordValidator() &&
        dobValidator() &&
        phoneValidator() &&
        addressValidator()
    );
}
function fillFormAgainUsingTempData(dataObj) {

    //userName
    if (dataObj?.username) {


        dataObj.username.value = localStorage.getItem('temp_username');
    }

    if (dataObj?.email) {
        dataObj.email.value = localStorage.getItem('temp_Email');
    }
    if (dataObj?.password) {
        dataObj.email.value = localStorage.getItem('temp_Password')
    }
    if (dataObj?.confirmPassWord) {
        dataObj.confirmPassWord.value = localStorage.getItem('temp_confirmPassWord')
    }
    if (dataObj?.dob) {
        dataObj.dob.value = localStorage.getItem('temp_dob');
    }

    if (dataObj?.phone) {
        dataObj.phone.value = localStorage.getItem('temp_phone')
    }
    if (dataObj?.address) {
        let addressObj = localStorage.getItem('temp_address')

        if (addressObj !== '' &&  addressObj?.address && addressObj?.street && addressObj?.city && addressObj?.zipCode) {
            addressObj = JSON.parse(addressObj)

            dataObj.address.value = addressObj?.address;
            dataObj.street.value = addressObj?.street;
            dataObj.city.value = addressObj?.city;
            dataObj.zipCode.value = addressObj?.zipCode;
        }

    }


}
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('form');

    const dataObj = {
        username: document.getElementById("Username"),
        email: document.getElementById("Email"),
        password: document.getElementById("PassWord"),
        confirmPassWord: document.getElementById("confirmPassWord"),

        dob: document.getElementById("dob"),
        phone: document.getElementById("phone"),

        address: document.getElementById("address"),
        street: document.getElementById("street"),
        city: document.getElementById("city"),
        state: document.getElementById("state"),
        zipCode: document.getElementById("zipCode")
    };
    fillFormAgainUsingTempData(dataObj);



    // console.log("from get loaded...", form);

    function userNameValidator() {
        const username = dataObj.username.value.trim();
        let ch = username.charAt(0);
        if (ch > '0' && ch < '9') {
            hideError("Username");
            showError("Username", "Username cannot start with a number.");
            return false;
        }

        if (username.length < 5) {
            hideError("Username");
            showError("Username", "Username should be at least 5 characters long.");
            return false;
        }


        if (username.length > 15) {
            hideError("Username");
            showError("Username", "Username cannot exceed 15 characters.");
            return false;
        }




        for (let i = 0; i < username.length; ++i) {
            const ch = username.charAt(i);

            if (ch >= 'a' && ch <= 'z') continue;
            if (ch >= 'A' && ch <= 'Z') continue;

            if (ch >= '0' && ch <= '9') continue;
            hideError("Username");
            showError("Username", `This charator is not allowed ${ch}`);
            return false
        }

        hideError("Username");
        localStorage.setItem('temp_username', username)
        return true;
    }


    function emailValidator() {
        const email = dataObj.email.value.trim();

        const emailReg = /^[A-Za-z0-9._%+-]+@abc\.in$/;

        if (!emailReg.test(email)) {
            showError('Email', "Only emails from the abc.in domain are allowed.");
            return false;
        } else {
            hideError('Email');
            localStorage.setItem('temp_Email', email)
            return true;
        }
    }



    function passwordValidator() {
        const password = dataObj.password.value.trim();

        if (password.length < 8) {
            hideError("PassWord");
            showError("PassWord", "Password must be at least 8 characters long.");
            return false;
        }

        let hasUpperCase = false;
        let hasLowerCase = false;
        let hasNumber = false;
        let hasSpecialChar = false;

        const specialCharacters = "!@#$%^&*()_-+=<>?";

        for (let i = 0; i < password.length; i++) {
            const ch = password.charAt(i);

            if ('a' <= ch && ch <= 'z') {
                hasLowerCase = true;
            } else if ('A' <= ch && ch <= 'Z') {
                hasUpperCase = true;
            } else if ('0' <= ch && ch <= '9') {
                hasNumber = true;
            } else if (specialCharacters.includes(ch)) {
                hasSpecialChar = true;
            } else {
                hideError("PassWord");
                showError("PassWord", `${ch} is not allowed in the password.`);
                return false;
            }
        }

        if (!hasUpperCase) {
            hideError("PassWord");
            showError("PassWord", "Password must contain at least one uppercase letter.");
            return false;
        }

        if (!hasLowerCase) {
            hideError("PassWord");
            showError("PassWord", "Password must contain at least one lowercase letter.");
            return false;
        }

        if (!hasNumber) {
            hideError("PassWord");
            showError("PassWord", "Password must contain at least one numeric digit.");
            return false;
        }

        if (!hasSpecialChar) {
            hideError("PassWord");
            showError("PassWord", "Password must contain at least one special character (!@#$%^&*()_-+=<>?).");
            return false;
        }

        hideError("PassWord");
        localStorage.setItem('temp_Password', password)
        return true;
    }
    function confirmPasswordValidator() {
        const password = dataObj.password.value.trim();
        const confirmPassWord = dataObj.confirmPassWord.value.trim();
        if (password !== confirmPassWord) {
            hideError('confirmPassWord')
            showError('confirmPassWord', 'Confirm PassWord is not Matching password')
            return false
        }
        hideError('confirmPassWord')
        localStorage.setItem('temp_confirmPassWord', password)
        return true;

    }

    function phoneValidator() {
        const phoneNumber = dataObj.phone.value.trim();
        if (phoneNumber.length < 10) {
            hideError("phone");
            showError("phone", "InValid ");
            return false;
        }
        hideError('phone')
        localStorage.setItem('temp_phone', phoneNumber)
        return true
    }

    function dobValidator() {
        const dob = dataObj.dob.value.trim();
        const currentDate = new Date();
        const userDOB = new Date(dob);


        const ageDifference = currentDate.getFullYear() - userDOB.getFullYear();

        if (ageDifference < 18) {
            showError('dob', 'You should be at least 18 years old.');
            return false;
        }

        hideError('dob');
        localStorage.setItem('temp_dob', dob)
        return true;
    }

    function hideAddressError() {
        hideError('address');
        hideError('street');
        hideError('city');
    }
    function addressValidator() {
        const addressObj = {
            address: dataObj.address.value.trim(),
            street: dataObj.street.value.trim(),
            city: dataObj.city.value.trim(),
            state: dataObj.state.value.trim(),
            zipCode: dataObj.zipCode.value.trim()

        }

        if (addressObj.address.length === 0) {
            hideAddressError()
            showError('address', "Address can't be empty")
            return false
        }
        if (addressObj.street.length === 0) {
            hideAddressError()
            showError('street', "Address can't be empty")
            return false
        }

        for (let x of addressObj.city) {
            if (x >= 'a' && x <= 'z') continue;
            if (x >= 'A' && x <= 'Z') continue;

            hideAddressError()
            showError('city', "city can only have characters")
            return false

        }
        hideAddressError()

        localStorage.setItem('temp_address', JSON.stringify(addressObj))
        return true

    }


    dataObj.username.addEventListener('blur', debounce(userNameValidator, 300));
    dataObj.email.addEventListener('blur', debounce(emailValidator, 300));
    dataObj.password.addEventListener('blur', debounce(passwordValidator, 300));
    dataObj.confirmPassWord.addEventListener('blur', debounce(confirmPasswordValidator, 300));
    dataObj.phone.addEventListener('blur', debounce(phoneValidator, 300));

    dataObj.dob.addEventListener('blur', debounce(dobValidator, 300));


    dataObj.street.addEventListener('blur', debounce(addressValidator, 300));


    form.addEventListener('submit', function (e) {
        e.preventDefault();
        if (formValidationHandler()) {
            alert('Form submitted successfully!');
            localStorage.clear();
            localStorage.setItem('userInfo', JSON.stringify(dataObj));
            console.table("saved userInfo", dataObj);
            form.reset();
        } else {
            console.log("Error on submit event");
        }
    });
});

const Icons = document.querySelectorAll('.toggle-password');

Icons.forEach(function (icon) {
    icon.addEventListener('click', function () {
        const targetId = this.getAttribute('data-target');
        const targetInput = document.getElementById(targetId);

        if (targetInput.getAttribute('type') === 'password') {
            targetInput.setAttribute('type', 'text');
            this.classList.remove('fa-eye-slash');
            this.classList.add('fa-eye');
        } else {
            targetInput.setAttribute('type', 'password');
            this.classList.remove('fa-eye');
            this.classList.add('fa-eye-slash');
        }
    });
});
