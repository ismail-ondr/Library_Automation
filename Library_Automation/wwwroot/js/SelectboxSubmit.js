

var onChange = function () {
    var selectedItem = document.getElementById("selectId").value;
    localStorage.setItem('selecteditem', selectedItem);
    document.forms["deneme"].submit();
    
}

window.onload = function () {
    if (localStorage.getItem('selecteditem')) {
        var deneme = localStorage.getItem('selecteditem');
        document.getElementById("selectId").options[localStorage.getItem('selecteditem')].selected = true;
    }
    var x = 0;
}


//if (localStorage.getItem('form_frame')) {
//    $("#form_frame option").eq(localStorage.getItem('form_frame')).prop('selected', true);
//}

//$("#form_frame").on('change', function () {
//    localStorage.setItem('form_frame', $('option:selected', this).index());
//});
