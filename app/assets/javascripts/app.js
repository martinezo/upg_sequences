$(document).ready(function() {

    //.live to activate this event in appended elements

    //adding_details
    $(".add_sequence_request_detail").live('click', function(event) {
        $(this).remove();
        event.preventDefault();
    });

    //remove_details
    $(".remove_sequence_request_detail").live('click', function(event) {
        add_link = $('.sample a:last')
        $(this).parent().parent().remove();
        $('.sample div:last').append(add_link)
        //if ($('#tbl_details tr').length == 2){
        //    alert('here');
        //    $('#tbl_details tr td:last').append("+")
        //}
        activate_jq_icons();
        event.preventDefault();
    });



    //remove_details
    $(".remove_admin_sequence_request_detail").live('click', function(event) {
        add_link = $('.sample a:last')
        $(this).parent().parent().remove();
        $('.sample div:last').append(add_link)
        //if ($('#tbl_details tr').length == 2){
        //    alert('here');
        //    $('#tbl_details tr td:last').append("+")
        //}
        activate_jq_icons();
        event.preventDefault();
    });

    //select oligo
    $(".oligo_sel").live('change', function(event) {
        $(this).next().val($(this).val());
    });

    activate_jq_buttons();
    activate_jq_icons();

    //check inb_member if payment method = ur or conacyt or papiit
    $("#sequence_request_payment_method_1,#sequence_request_payment_method_2,#sequence_request_payment_method_3").live('click', function(event) {
       $("#sequence_request_inb_member").attr('checked', true);
       $(".ur").show();
    });

    $("#sequence_request_inb_member").live('click', function(event) {
       if(! $(this).attr('checked') && ($("#sequence_request_payment_method_1").attr('checked') || $("#sequence_request_payment_method_2").attr('checked') || $("#sequence_request_payment_method_3").attr('checked'))){
           $("#sequence_request_payment_method_4").attr('checked',true);
       }
       if($(this).attr('checked')){
           $(".ur").show();
       } else {
         $(".ur").hide();
         $("#sequence_request_ur_id").val(0);
       }
    });

    $('.clear_file').click(function(event) {
        event.preventDefault();
        $($(this).val()).attr('value','');
    });

    $('.remove_results_file').click(function(event) {
        event.preventDefault();
        $($(this).val()).attr('value','true');
        $("#sequence_request_results_file").attr('value','');
    });
//    $(function() {
//        $(".tooltip").tipTip();
//    });

});

// ACTIVATE JQUERY BUTTONS

function activate_jq_buttons() {
    $(".jq-button").button();

    // Cancel button
    $("#cancel,#back").click(function() {
        $(".new_edit").hide(600);
        $(".details").hide(600);
        $(".list").show(600);
        $(".pagination a").attr('data-remote', 'true');
    });
}
function activate_jq_icons() {
    $(".jq-icon-plus").button({icons: {primary: "ui-icon-plus"}, text: false});
    $(".jq-icon-minus").button({icons: {primary: "ui-icon-minus"}, text: false});
}