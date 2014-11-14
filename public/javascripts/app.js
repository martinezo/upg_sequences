$(document).ready(function() {

    //.live to activate this event in appended elements

    //adding_details
    $(".add_sequence_request_detail").live('click', function(event) {
        $(this).remove();
        event.preventDefault();
    });

    //remove_details
    $(".remove_sequence_request_detail").live('click', function(event) {
        add_link = $('.tbl_det a:last')
        $(this).parent().parent().remove();
        $('.tbl_det div:last').append(add_link)
        //if ($('#tbl_details tr').length == 2){
        //    alert('here');
        //    $('#tbl_details tr td:last').append("+")
        //}
        event.preventDefault();
    });



    //remove_details
    $(".remove_admin_sequence_request_detail").live('click', function(event) {
        add_link = $('.tbl_det a:last')
        $(this).parent().parent().remove();
        $('.tbl_det div:last').append(add_link)
        //if ($('#tbl_details tr').length == 2){
        //    alert('here');
        //    $('#tbl_details tr td:last').append("+")
        //}
        event.preventDefault();
    });

    //select oligo
    $(".oligo_sel").live('change', function(event) {
        $(this).next().val($(this).val());
    });

    activate_jq_buttons();

    $(function() {
        $(".tooltip").tipTip();
    });

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