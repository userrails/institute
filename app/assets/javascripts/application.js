// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){


    setTimeout(function(){
        $(".alert").fadeOut();
    }, 1000);

    $(".alert").click(function(){
        $(".alert").fadeOut();
    });


    $("#hide").click(function(){
        $("#content").hide();
        return false;
    })

    $("#show").click(function(){
        $("#content").show();
        return false;
    })

    $('#fadeOut').click(function(){
        $('#content').fadeOut(2000);
        return false;
    })

    $('#fadeIn').click(function(){
        $('#content').fadeIn(3000);
        return false;
    })

    $('#focus').click(function() {
        $('#text1').focus();
        return false;
    })

        $('#text1').blur(function(){
        alert("Textbox blur function activated");
        return false;
    })

     $('#slide').click(function() {
        $('#book').slideDown('slow');
        return false;
    })
    
});