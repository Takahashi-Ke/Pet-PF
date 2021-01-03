// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require cocoon
//= require bootstrap-sprockets
//= require_tree .

/* global $*/

// 画像プレビュー
$(document).on("click", ".owner-image", function(){
  function readURL(input) {
    if(input.files && input.files[0]){
      var reader = new FileReader();
      reader.onload = function (e) {
          $('.owner-prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $(".owner-image").change(function(){
    readURL(this);
  });
});
$(document).on("click", ".pet-image", function(){
  function readURL(input) {
    if(input.files && input.files[0]){
      var reader = new FileReader();
      reader.onload = function (e) {
          $('.pet-prev').attr('src', e.target.result);
        
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $(".pet-image").change(function(){
    readURL(this);
  });
});

// モーダルウィンドウ
// 表示
$(function() {
  $(document).on('click', '.add-diary-button', function() {
    $('.modal-wrapper').show();
    $('.diary-modal').show();
  });
  $(document).on('click', '.select-personality-btn', function() {
    $('.modal-wrapper').show();
    $('.personality-modal').show();
  });
  });
// 非表示
$(document).on('click', '.modal-wrapper, .hide-modal-btn', function() {
    $('.modal-wrapper').hide();
    $('.diary-modal').hide();
    $('.personality-modal').hide();
})

// タブ切り替え
$(document).on("turbolinks:load", function(){
  $('#tab-contents .tab[id != "tab1"]').hide();
});
$(document).on("turbolinks:load", function(){
  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});

// コメント表示
$(document).on("turbolinks:load", function(){
  $('.comment-box').hide();
  $('.comment-btn').on('click', function(){
    $('.comment-box').toggle();
  });
});
