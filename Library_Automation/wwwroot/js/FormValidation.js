
function bookValidate() {
    let name = document.forms["form"]["BookName"].value;
    let writer = document.forms["form"]["BookWriter"].value;
    let publisher = document.forms["form"]["BookPublisher"].value;

    if (name == "") {
        alert("Kitap adı alanı boş bırakılamaz!");
        return false;
    }
    else if (writer == "") {
        alert("Yazar alanı boş bırakılamaz!");
        return false;
    }
    else if (publisher == "") {
        alert("Yayınevi alanı boş bırakılamaz!");
        return false;
    }    
}

function authValidate() {
    let authName = document.forms["form"]["AuthName"].value;
    let authMail = document.forms["form"]["AuthMail"].value;
    let authPassword = document.forms["form"]["AuthPassword"].value;

    if (authName == "") {
        alert("Yetkili adı alanı boş bırakılamaz");
        return false;
    }
    else if (authMail == "") {
        alert("Yetkili eposta alanı boş bırakılamaz");
        return false;
    }
    else if (authPassword == "") {
        alert("Yetkili parola alanı boş bırakılamaz");
        return false;
    }
}

function borrowValidate() {
    let bookId = document.forms["form"]["bookId"].value;
    let userId = document.forms["form"]["userId"].value;
    

    if (bookId == "") {
        alert("Kitap Id alanı boş bırakılamaz");
        return false;
    }
    else if (userId == "") {
        alert("Üye Id alanı boş bırakılamaz");
        return false;
    }
}

function memberValidate() {
    let userName = document.forms["form"]["UserName"].value;
    let userMail = document.forms["form"]["UserMail"].value;
    let userPassword = document.forms["form"]["UserPassword"].value;

    if (userName == "") {
        alert("Üye adı alanı boş bırakılamaz");
        return false;
    }
    else if (userMail == "") {
        alert("Üye eposta alanı boş bırakılamaz");
        return false;
    }
    else if (userPassword == "") {
        alert("Üye parola alanı boş bırakılamaz");
        return false;
    }
}


