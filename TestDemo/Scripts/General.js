function fnvalidation() {
    var ele = $('form')[0];
    var str = '';
    for (var i = 0; i < ele.length; i++) {
        if (ele[i].tagName == 'INPUT') {
            if (ele[i].type == "file") {
                if (ele[i].className.indexOf('required') >= 0) {
                    if (ele[i].defaultValue == "" || ele[i].defaultValue == null || ele[i].defaultValue == undefined) {
                        if (str.length > 0) {
                            str += ',' + ele[i].title;
                        }
                        else {
                            str = ele[i].title;
                        }
                    }
                }
            }
            else if (ele[i].type == "checkbox") {
                if (ele[i].className.indexOf('required') >= 0) {
                    if (ele[i].checked == false) {
                        if (str.length > 0) {
                            str += ',' + ele[i].title;
                        }
                        else {
                            str = ele[i].title;
                        }
                    }
                }
            }
            else if (ele[i].className.indexOf('required') >= 0) {
                if (ele[i].value.trim() == "" || ele[i].value == null || ele[i].value == undefined) {
                    if (str.length > 0) {
                        str += ',' + ele[i].title;
                    }
                    else {
                        str = ele[i].title;
                    }
                }
            }
        }

        else if (ele[i].type == "textarea") {
            if (ele[i].className.indexOf('required') >= 0) {
                var n = ele[i].value;
                if (ele[i].value == "" || ele[i].value == null || ele[i].value == undefined) {
                    if (str.length > 0) {
                        str += ',' + ele[i].title;
                    }
                    else {
                        str = ele[i].title;
                    }
                }
            }
        }
        else if (ele[i].tagName == 'SELECT') {
            if (ele[i].className.indexOf('required') >= 0) {
                if (ele[i].value == "" || ele[i].value == null || ele[i].value == undefined || ele[i].value == 'Select' || ele[i].value == 'select') {
                    if (str.length > 0) {
                        str += ',' + ele[i].title;
                    }
                    else {
                        str = ele[i].title;
                    }
                }
            }
        }

    }
    if (str.length > 0) {
        str += ' is required';
        swal({
            title: "Error",
            text: str,
            timer: 3000,
            type: "error"
        });
        $('#validateBtn').attr('disabled', false);
        return false;
    }
}


function fnReset() {

    var ele = document.getElementsByClassName('formcontrol');
    for (var i = 0; i < ele.length; i++) {

        if (ele[i].tagName == 'INPUT') {
            ele[i].value = '';
            if (ele[i].type == 'file') {
                ele[i].defaultValue = '';
            }
            if (ele[i].type == 'checkbox') {
                ele[i].checked = false;
            }
        }
        else if (ele[i].tagName == 'TEXTAREA') {
            $(ele[i]).val('');
            try {
                for (instance in CKEDITOR.instances) {
                    CKEDITOR.instances[instance].updateElement();
                }
                CKEDITOR.instances[instance].setData('');
            } catch (e) {

            }

        }
        else if (ele[i].tagName == 'LABEL') {
            $('#' + ele[i].id).empty();
            document.getElementById(ele[i].id).innerHTML = "";
        }

        else if (ele[i].tagName == 'SELECT') {
            document.getElementById(ele[i].id).value = "";
        }

    }
    //var elecheck = document.getElementsByClassName('chkactive');
    //for (var i = 0; i < elecheck.length; i++) {
    //    elecheck[i].checked = true;
    //}
    //var eleuncheck = document.getElementsByClassName('chkinactive');
    //for (var i = 0; i < eleuncheck.length; i++) {
    //    eleuncheck[i].checked = false;
    //}
    //$(".wallUrl").empty();
    //$('.wallUrl').removeClass('wallUrl');

}
function fnSuccess() {
    var msg = document.getElementById('SuccessMessage').value;
    $('#validateBtn').attr('disabled', false);
    if (msg.length > 0 && msg != undefined && msg != " ") {
        swal({
            title: "Success",
            text: msg,
            timer: 3000,
            type: "success"
        });
    }
    else {
        //msg = document.getElementById('Errormessage').value;
        //swal({
        //    title: "Error",
        //    text: msg,
        //    timer: 3000,
        //    type: "error"
        //});
    }

    fnReset();
    fnadddatatable();
    scrolltop();
    $("a[rel^='prettyPhoto']").prettyPhoto();
}
//function fnSuccess() {
//    var msg = document.getElementById('SuccessMessage').value;
//    $('#validateBtn').attr('disabled', false);
//    swal({
//        title: "Success",
//        text: msg,
//        timer: 3000,
//        type: "success"
//    });
//    fnReset();
//    fnadddatatable();
//    scrolltop();
//    $("a[rel^='prettyPhoto']").prettyPhoto();
//}

//function fnSuccessAdvertisememnt() {
//    var msg = document.getElementById('SuccessMessage').value;
//    $('#validateBtn').attr('disabled', false);
//    swal({
//        title: "Success",
//        text: msg,
//        timer: 3000,
//        type: "success"
//    });
//    fnReset();
//    fnadddatatable();
//    scrolltop();
//    $('#ClientId').removeAttr('disabled');
//    $("a[rel^='prettyPhoto']").prettyPhoto();
//}

function fnSuccessMenu() {
    var msg = document.getElementById('SuccessMessage').value;
    $('#validateBtn').attr('disabled', false);
    swal({
        title: "Success",
        text: msg,
        timer: 3000,
        type: "success"
    });
    fnReset();
    $('#selectedicons').html('');
    fnadddatatable();
    scrolltop();
    $("a[rel^='prettyPhoto']").prettyPhoto();
}
function fnadddatatable() {
    if ($('#example')[0] != undefined) {
        $('#example').DataTable();
    }
}
function clearimage() {
    $('#hdnrmvbutton').trigger('click');
    $("#myimage").attr('src', '/Images/default.png');
    $("#ContentImg").attr('src', '/Images/default.png');
    
    
}
function clearbgimage() {
    $('#hdnrmvbutton1').trigger('click');
    $('#myimage1').attr('src', '/Images/default.png');
    $('#FooterImg').attr('src', '/Images/default.png');
}

function editclickimage() {
    $('#rmvbutton').css('display', 'block');
    $('#rmvbutton').html('Remove');
    if ($('#rmvbutton1')) {
        $('#rmvbutton1').css('display', 'block');
        $('#rmvbutton1').html('Remove');
    }
}

function scrolltop() {
    $('html, body').animate({ scrollTop: 0 }, 800);
}
function nospaces(t) {
    if (t.value.match(/\s/g)) {
        alertify.error('Sorry, you are not allowed to enter any spaces');
        t.value = t.value.replace(/\s/g, '');
    }
}

function BrowserBack() {
    window.history.back();
}

$(document).ready(function () {
    var id = document.getElementsByClassName('content');
    if (id != undefined && id.length > 0) {
        var newid = id[0].id.split('~');
        SetActiveMenu(newid[0], newid[1], newid[2]);
    }
    var specialKeys = new Array();
    specialKeys.push(8); //Backspace
    $(".numeric").bind("keypress", function (e) {
        var keyCode = e.which ? e.which : e.keyCode;
        var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1);
        $(".error").css("display", ret ? "none" : "inline");
        return ret;
    });
    $(".numeric").bind("paste", function (e) {
        return false;
    });
    $(".numeric").bind("drop", function (e) {
        return false;
    });
});

function SetActiveMenu(id, subid, ulid) {

    var lilist = document.getElementsByClassName('has-sub');
    var subLilist = document.getElementsByClassName('SubLilist');


    for (var i = 0; i < lilist.length; i++) {
        $('#' + lilist[i].id).removeClass('active');
    }
    for (var j = 0; j < subLilist.length; j++) {
        $('#' + subLilist[j].id).removeClass('active');
    }
    if (id == "Dashboard") {
        $('#' + id).addClass('active');
        $('#' + ulid).removeClass('active');
        $('#' + ulid).addClass('active');
    }
    else {
        if (subid == "" || subid == null) {
            $('#' + id).removeClass('active');
            $('#' + id).addClass('active');
        }
        else {
            $('#' + id).removeClass('active');
            $('#' + id).addClass('active');
            $('#' + ulid).removeClass('active');
            $('#' + ulid).addClass('active');
            if (document.getElementById(subid)) {
                document.getElementById(subid).className = 'active';
            }
        }
    }

}