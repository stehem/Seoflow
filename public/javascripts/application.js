$(document).ready(function() {

$("input#tags_box").autocomplete({
source: "/autocomplete",
minLength:3, 
delay: 250,
select: function(event, ui) {    
$('.tags').append('<div class="selected_tags" id="'+ui.item.value+'">'  + (ui.item.value) + '</div>');
populate_id_attr(ui.item.value);
$('input#tags_box').val("");
check_number_of_selected_tags();
return false;
}
});

$("a.reset_tags").click(function () {
$("div[class='selected_tags']").remove();
$("input#question_tag1").val("");
$("input#question_tag2").val("");
$("input#question_tag3").val("");
$('#tags_box').show('slow');
$("a#add_link").show('slow');
});

$("a#add_link").click(function () {
if ($('input#tags_box').val() != "") {
$('.tags').append('<div class="selected_tags" id="' + $('input#tags_box').val() +'">'  + $('input#tags_box').val() + '</div>');
populate_id_attr($('input#tags_box').val());
$('input#tags_box').val("");
$('input#tags_box').focus();
check_number_of_selected_tags();
}
});


var populate_id_attr = function(f){
var nbtags = $("div[class='selected_tags']").length;
if (nbtags == 1){
$("input#question_tag1").val(f);
}
if (nbtags == 2){
$("input#question_tag2").val(f);
}
if (nbtags == 3){
$("input#question_tag3").val(f);
}
}


var check_number_of_selected_tags = function(){
var n = $("div[class*='selected_tags']").length;
if (n > 2) {
$('#tags_box').fadeOut('slow');
$("a#add_link").fadeOut('slow');	
}
}


$('input#question_title').one('focus', function() {
toggle_rightbar('#r_title');
});

$('input#tags_box').one('focus', function() {
toggle_rightbar('#r_tags');
});

$('textarea#question_body').one('focus', function() {
toggle_rightbar('#r_question');
});


var toggle_rightbar = function(f){
$('#display_gdl').hide(0);
$('#display_gdl').empty();
$('#display_gdl').append($(f).clone());
$('#display_gdl').fadeIn(1000);
}

$("input#tags_search").typeWatch({callback:finished,wait:750,highlight:true,captureLength:-1});

function finished(txt) {
$.get("/autocomplete/tags_search?filter="+txt);
}


$("input#users_search").typeWatch({callback:finished_users,wait:750,highlight:true,captureLength:-1});

function finished_users(txt) {
$.get("/autocomplete/users_search?filter="+txt);
}


$("a.reply_link").click(function () {
$("div#reply_box").hide(0);
var answer_id = $(this).attr("id");
var selector = "div#answer_" + answer_id
$(selector).append($("div.reply_box_hidden"));
$("input#answer_id").val($(this).attr("id"));
$("div.reply_box_hidden").fadeIn(1000);
$("#reply_body").removeClass("reply_body answer_form_validate").addClass("reply_body");
});


$("a.reply_link").click(function(ev){
ev.preventDefault();
ev.stopPropagation();
});


$("#reply_new").validate({
rules: {
"reply[body]": {required: true}
},
messages: {
"reply[body]": "",  
},
highlight: function(element, errorClass) {
$(element).addClass("answer_form_validate");
}
});




$("#answer_new").submit(function() {
tinyMCE.triggerSave();
});



$("#answer_new").validate({
rules: {
"answer[body]": {required: true}
},
messages: {
"answer[body]": "Le champ ne peut pas être vide.",  
}
});


$(".error_notification").live('click', function() {
$(this).fadeOut("slow", function() {
$(this).remove();
});
});

$('#spinner').hide() 
.ajaxStart(function() {
$(this).show();
})
.ajaxStop(function() {
$(this).hide();
});


$(".karma").tipTip();
$(".medals").tipTip();
$(".vote_up").tipTip({defaultPosition: "top"});
$(".vote_down").tipTip();
$(".favorite").tipTip();
$(".favorite-on").tipTip();
$(".question_votes_score").tipTip({defaultPosition: "right"});
$(".answer_votes_score").tipTip({defaultPosition: "right"});
$(".solved_link").tipTip({defaultPosition: "right"});
$(".reply_link").tipTip({defaultPosition: "right"});

$('.ajax_pagination a').live("click", function () {
$.get(this.href, null, null, 'script');
return false;
});


$("#new_question").submit(function() {
tinyMCE.triggerSave();
});


$("#new_question").validate({
errorElement: "div",
rules: {
"question[title]": {
required: true,
maxlength: 200},
"question[body]": {required: true},
"tag1": {required: true, maxlength: 30}
},
messages: {
"question[title]": {
maxlength: "Le titre ne peut pas excéder 200 caractères.",
required: "Le titre ne peut pas être vide."
}
,  
"question[body]": "Le corps de la question ne peut pas être vide.",
"tag1": {
required: "Vous devez ajouter au moins un tag.",
maxlength: "Le tag ne peut pas excéder 30 caractères."}
}
});


$("#new_user").validate({
rules: {
"user[name]": {required: true, remote: "validate_user_name"},
"user[password]": {required: true},
"user[password_confirmation]": {required: true, equalTo: "#user_password" }
},
messages: {
"user[name]": {required: "Le champ ne peut pas être vide.", remote: "Cet identifiant est déja utilisé"},  
"user[password]": {required: "Le champ ne peut pas être vide."},
"user[password_confirmation]": {required: "Le champ ne peut pas être vide.", equalTo: "Introduisez le même mot de passe."}
}
});


$("#new_session").validate({
rules: {
"session[name]": {required: true},
"session[password]": {required: true},
},
messages: {
"session[name]": {required: "Le champ ne peut pas être vide."},  
"session[password]": {required: "Le champ ne peut pas être vide."},
}
});


});
