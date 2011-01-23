$(document).ready(function() {


$("input#tags_box").autocomplete({
source: "/autocomplete",
minLength:3, 
delay: 250,
select: function(event, ui) {    
$('.tags').append('<div class="selected_tags" id="'+ui.item.value+'">'  + (ui.item.value) + '</div>');
populate_id_attr(ui.item.value);
$('.error:contains("Vous devez ajouter au moins un tag.")').remove();
$('input#tags_box').val("");
check_number_of_selected_tags();
return false;
}
});





$("a.reset_tags").click(function () {
$("div[class='selected_tags']").remove();
clear_hidden_tag_values ();
$('#tags_box').show('slow');
$("a#add_link").show('slow');
});


$("a#add_link").click(function () {
if ($('input#tags_box').val() != "") {
$('.tags').append('<div class="selected_tags" id="' + $('input#tags_box').val() +'">'  + $('input#tags_box').val() + '</div>');
populate_id_attr($('input#tags_box').val());
$('.error:contains("Vous devez ajouter au moins un tag.")').remove();
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


var clear_hidden_tag_values = function(){
$("input#question_tag1").val("");
$("input#question_tag2").val("");
$("input#question_tag3").val("");
}



$('input#question_title').one('focus', function() {
toggle_rightbar('#r_title');
});

$('input#tags_box').one('focus', function() {
toggle_rightbar('#r_tags');
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


if ($.browser.msie) {
$('ul.formats').removeClass("formats").addClass("formats_ie");
}

$('input.reply_submit_button').click(function() {
validate_reply();
});

$('a.answer_edit_link').live("click",function() {
if (CKEDITOR.instances['answer_edit'] != null){
alert ("Vous devez annuler l'édition déja en court avant d'en ouvrir une autre.");
return false;
}
else {
$.get('/answers/'+this.id+'/edit/');
return false;
}
});


$('#submit_answer_edit').live("click",function() {
CKEDITOR.instances['answer_edit'].updateElement(); 
var url = $("#answer_edit").attr("action");
validate_answer_edit(url);
});


$('a#cancel_answer_edit').live("click",function() {
var url = $("a#cancel_answer_edit").attr("url");
$.get(url);
return false;
});


/////////////////////////////////// ceekay editor validation voodoo

$('input#answer_submit_button').click(function() {
CKEDITOR.instances['answer_body'].updateElement(); 
validate_answer();
});


if (CKEDITOR.instances['answer_body'] != null){
CKEDITOR.instances['answer_body'].on('contentDom', function() {
CKEDITOR.instances['answer_body'].document.on('keyup', function(event) {
CKEDITOR.instances['answer_body'].updateElement(); 
$('#answer_body').trigger('keyup');
});
});
}


if (CKEDITOR.instances['question_body'] != null){
CKEDITOR.instances['question_body'].on('focus', function() {
toggle_rightbar('#r_question');
});
}


/////////////////////////////////// Form Validations

function validate_reply(){
$("#reply_new").validate({
submitHandler: function() {
$.post("/replies", $("#reply_new").serialize());
},
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
};

function validate_answer(){
$("#answer_new").validate({
submitHandler: function() {
$.post("/answers", $("#answer_new").serialize());
},
errorElement: "div",
rules: {
"answer[body]": {required: true}
},
messages: {
"answer[body]": "Le champ ne peut pas être vide.",  
}
});
};


function validate_answer_edit(url){
$("#answer_edit").validate({
submitHandler: function() {
$.post(url, $("#answer_edit").serialize());
},
errorElement: "div",
rules: {
"answer[edit]": {required: true}
},
messages: {
"answer[edit]": "Le champ ne peut pas être vide.",  
}
});
};



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


$(".edit_question").validate({
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


$("#user_edit").validate({
errorLabelContainer: "#error_container",
wrapper: "span",
rules: {
"user[email]": {email: true},
"user[website]": {url: true},
"user[bio]": {maxlength: 200}
},
messages: {
"user[email]": {email: "Email non valide."},  
"user[website]": {url: "URL non valide."},
"user[bio]": {maxlength: "Bio: 200 caractères maxi."}
}
});


});
