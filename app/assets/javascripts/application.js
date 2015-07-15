// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-timepicker.min
//= require chosen-jquery
//= require ImageSelect.jquery
//= require jquery.autocomplete.multiselect
//= require modernizr-2.6.2.min
//= require jquery.validate.min
//= require messages

$(document).ready(function() {

    //Adding guest manager fields
    $("#addMoreGuestLink").click(function (e) {
        e.preventDefault();

        $("#guests_fields").append('<div id="guests_fields"><div class="col-sm-3"><input type="text" name="guests[][name]" class="form-control"/></div>'+
        '<div class="col-sm-3"><input type="text" name="guests[][email]" class="form-control"/></div>'+
        '<div class="col-sm-2"><input type="text" name="guests[][mobile]" class="form-control"/></div>'+
        '<div class="col-sm-2"><input type="text" name="guests[][city]" class="form-control"/></div>'+
        '<div class="col-sm-2"><a id="removeGuestsField" href="javascript:;" class="text-danger"><img src="/assets/close.png"/></a></div>'+
        '<div class="clearfix"></div>'+
        '</div>');
    });

    //Removing guest manager fields
    $("body").on("click",'#removeGuestsField',function(){
        $(this).parent().parent().remove();
    });

    //Adding ceremony fields
    $("#addMoreCeremonyLink").click(function (e) {
        e.preventDefault();

        $("#ceremony_fields").append('<div class="one_ceremony_field">' +
        '<div class="form-group">' +
        '<div class="col-sm-3"><input type="text" name="ceremonies[][program]" class="form-control" required="required"/></div>'+
        '<div class="col-sm-2"><input type="text" name="ceremonies[][date]" class="form-control datepicker" required="required"/></div>'+
        '<div class="col-sm-3"><div class="input-group bootstrap-timepicker">' +
        '<input type="text" name="ceremonies[][time]" class="form-control ceremonytimepicker" required="required"/>' +
        '<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i>' +
        '</span>' +
        '</div>' +
        '</div>' +
        '<div class="col-sm-2"><input type="text" name="ceremonies[][venue]" class="form-control" required="required"/></div>'+
        '</div>' +
        '<div class="form-group">' +
        '<div class="col-sm-5">I prefer to receive reminder for the above event prior to:</div>' +
        '<label class="col-sm-1"><div class="row">' +
        '<input name="ceremonies[][is_reminder_on_one_day_prior]" id="ceremonies__is_reminder_on_one_day_prior" value="true" type="checkbox"/>1 day'+
        '</div></label>'+
        '<label class="col-sm-1"><div class="row">' +
        '<input name="ceremonies[][is_reminder_on_three_day_prior]" id="ceremonies__is_reminder_on_three_day_prior" value="true" type="checkbox"/>3 day'+
        '</div></label>'+
        '<label class="col-sm-1"><div class="row">' +
        '<input name="ceremonies[][is_reminder_on_seven_day_prior]" id="ceremonies__is_reminder_on_seven_day_prior" value="true" type="checkbox"/>7 day'+
        '</div></label>'+
        '</div>' +
        '<div class="col-sm-2"><a id="removeCeremonyField" href="javascript:;" class="text-danger"><img src="/assets/close.png"/></a></div>'+
        '<div class="clearfix"></div>'+
        '</div>');
        //Added datepicker
        $('.datepicker').datepicker({
            format: 'mm/dd/yyyy',
            autoclose: true
        });
        $('.ceremonytimepicker').timepicker({
            defaultTime: "07:00 AM"
        });
    });

    //Removing ceremony fields
    $("body").on("click",'#removeCeremonyField',function(){
        $(this).parent().parent().remove();
    });

    $('.ceremonytimepicker').timepicker({
        defaultTime: "07:00 AM"
    });

    $('.datepicker').datepicker({
        format: 'mm/dd/yyyy',
        autoclose: true
    });

    $(".portfolio").on("mouseenter",function(){
        $(".overlay").fadeOut("fast");
        $(this).find(".overlay").fadeIn("fast");
    });

    $(".portfolio").on("mouseleave",function(){
        $(".overlay").fadeOut("fast");
    });

    //Adding User keywords fields
    $("#addMoreUserKeywordLink").click(function (e) {
        e.preventDefault();

        $("#keyword_fields").append('<div class="form-group"><div class="col-sm-3 col-sm-offset-3"><input type="text" name="user_keywords[][keyword]" class="form-control"/></div>'+
        '<div class="col-sm-2"><a id="removeUserKeywordField" href="javascript:;" class="text-danger"><img src="/assets/close.png"/></a></div>'+
        '<div class="clearfix"></div>'+
        '</div>');
    });

    //Removing user keywords fields
    $("body").on("click",'#removeUserKeywordField',function(){
        $(this).parent().parent().remove();
    });

    var footer_height= $("footer").height();
    $("body").css("margin-bottom",footer_height);

    $(".new_ceremony").validate({
        rules: {
            "ceremonies[][date]": {
                required: true
            }
        },
        messages: {
            "ceremonies[][date]": {
                required: "Please select date"
            }
        }
    });

    //var availableTags = [
    //    "ActionScript",
    //    "AppleScript",
    //    "Asp",
    //    "BASIC",
    //    "C",
    //    "C++",
    //    "Clojure",
    //    "COBOL",
    //    "ColdFusion",
    //    "Erlang",
    //    "Fortran",
    //    "Groovy",
    //    "Haskell",
    //    "Java",
    //    "JavaScript",
    //    "Lisp",
    //    "Perl",
    //    "PHP",
    //    "Python",
    //    "Ruby",
    //    "Scala",
    //    "Scheme"
    //];
    //$('#myAutocomplete').autocomplete({
    //    source: availableTags,
    //    multiselect: true
    //});
});