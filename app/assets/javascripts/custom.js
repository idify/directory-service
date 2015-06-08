$(document).ready(function(){

    /*for fixed nav after scrolling*/
$(window).bind('scroll',function () {
    //alert($(window).scrollTop());
    if ($(window).scrollTop() > 80) {
        $('.navbar').addClass('navbar-fixed-top');
    } else {
        $('.navbar').removeClass('navbar-fixed-top');
    }
});
});