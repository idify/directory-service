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
//= require jquery.validate.min
//= require messages
//= require jquery-ui.min
//= require jquery-fileupload/basic
//= require jquery.tagsinput
//= require jquery.raty
//= require ratyrate

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
        '<div class="col-sm-2"><input type="checkbox" name="ceremonies[][public]"/></div>'+
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
    var dateToday = new Date();
    $('.datepicker').datepicker({
        format: 'mm/dd/yyyy',
        autoclose: true,
        minDate: dateToday
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

    function split( val ) {
        return val.split( /,\s*/ );
    }
    function extractLast( term ) {
        return split( term ).pop();
    }

    $( "#AutocompleteServiceArea" )
        // don't navigate away from the field on tab when selecting an item
        .bind( "keydown", function( event ) {
            if ( event.keyCode === $.ui.keyCode.TAB &&
                $( this ).autocomplete( "instance" ).menu.active ) {
                event.preventDefault();
            }
        })
        .autocomplete({
            minLength: 0,
            //source: function( request, response ) {
            //    // delegate back to autocomplete, but extract the last term
            //    response( $.ui.autocomplete.filter(
            //        availbleTags, extractLast( request.term ) ) );
            //},
            source: '/categories/autocomplete_locations.json',
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            select: function( event, ui ) {
                var terms = split( this.value );
                // remove the current input
                terms.pop();
                // add the selected item
                terms.push( ui.item.value );
                // add placeholder to get the comma-and-space at the end
                terms.push( "" );
                this.value = terms.join( ", " );
                return false;
            }
        });


    var emailRregex = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;// Email address
    $('#subsite_invitees').tagsInput({
        pattern: emailRregex
    });

    $('#category_keywords').tagsInput();
    $("#modal-window").modal('show');


    $('.role_social_login').click(function(){
        if($("input[name='role']:checked").val() == 'customer'){
            $("#social_login_customer").show();
            $("#social_login_vendor").hide();
        }
        if($("input[name='role']:checked").val() == 'vendor'){
            $("#social_login_vendor").show();
            $("#social_login_customer").hide();
        }
    });
});

//validation
$(document).ready(function() {

    $("#new_user").validate({
        rules: {

            "user[email]": {
                required: true
            },
            "user[password]": {
                required: true
            }
        }
    });
    $("#new_gallery").validate({
        rules: {

            "gallery[attachment][]": {
                required: true
            }
        }
    });
    $("#new_subsite").validate({
        rules: {

            "subsite[domain_name]": {
                required: true
            },
            "subsite[contact_email]": {
                required: true
            },
            "subsite[invitees][]": {
                required: true
            }
        }
    });
    $("#new_wishlist").validate({
        rules: {

            "wishlist[name]": {
                required: true
            },
            "wishlist[category]": {
                required: true
            },
            "wishlist[mobile_number]": {
                number: true,
                minlength: 10, 
                maxlength: 10
            },
            "wishlist[email]": {
                email: true
            },
            "wishlist[program_date]": {
                required: true
            },
            "wishlist[city]": {
                required: true
            },
            "wishlist[wish_list]": {
                required: true
            }

        }
    });
        $("#sign_up").validate({
        rules: {

            "user[email]": {
                required: true,
                email: true
            },
            "user[password]": {
                required: true,
                minlength: 8
            },
            "user[password_confirmation]": {
                required: true,
                equalTo: "#user_password"
            },
            "user[mobile]": {
                required: true,
                number: true,
                minlength: 10, 
                maxlength: 10
            }
        },
        messages: {
        "user[email]": {
                required: 'Email should be present.',
                email: 'Email should be in valid format.',
                remote: "This email has already been taken."
            },
        "user[password]": {
            required: "Please provide a password"

            
        },
        "user[password_confirmation]": {
            required: "Please provide a confirm password",
            equalTo: "Password should match with above"
        },
        "user[mobile]": {
            required: "Please enter your mobile number",
            number: "Please enter number only",
            minlength: "Length must be 10", 
            maxlength: "Length must be 10"
        }
        }
    });

    $("#new_reference").validate({
        rules: {

            "reference[name]": {
                required: true
            },
            "reference[email]": {
                required: true
            },
            "reference[comment]": {
                required: true
            }
        }
    });
});