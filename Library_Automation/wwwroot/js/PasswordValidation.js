

var check = function () {
    var button = document.getElementById("signup");
    var confirm_password_input = document.getElementById('confirm_password');

    if (document.getElementById('password').value ==
        document.getElementById('confirm_password').value) {
        confirm_password_input.style.background = "rgba(82, 106, 174, 0.5)";
        button.disabled = false;
    } else {
        button.disabled = true;
        confirm_password_input.style.background = "rgba(255, 99, 71, 0.5)";
    }
}

