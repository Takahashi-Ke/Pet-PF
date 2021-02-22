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
//= require jquery
//= require jquery.jscroll.min.js
//= require rails-ujs
//= require activestorage
//= require cocoon
//= require bootstrap-sprockets
//= require_tree .

/* global $*/



// bxslider設定
$(document).ready(function(){
  $('.bxslider').bxSlider({
		auto: true,
		pause: 5000,
	});
});

// ハンバーガーメニュー
$(document).ready(function(){
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#sp-menu').slideToggle();
    event.preventDefault();
  });
});


// 文字数カウント
$(document).ready(function(){
  var count = $('.js-text').text().length;
  $(".js-text-count").text( count + "/120");
  // 文字が入力される度発火
  $(".js-text").on("keyup", function() {
    var count = $(this).val().replace(/\n/g, "改行").length;
    if(count > 120){
      $(".js-text-count").css("color","#D25565");
    }else{
      $(".js-text-count").css("color","#333333");
    }
    $(".js-text-count").text( count + "/120");
  });
});



// 画像プレビュー
$(document).ready(function(){
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
$(document).ready(function(){
  $(document).on('click', '.add-diary-button, .add-diary-mini-btn', function() {
    $('.modal-wrapper').show();
    $('.diary-modal').fadeIn();
  });
  $(document).on('click', '.select-personality-btn', function() {
    $('.modal-wrapper').show();
    $('.personality-modal').fadeIn();
  });
  });
// 非表示
$(document).on('click', '.modal-wrapper, .hide-modal-btn', function() {
    $('.modal-wrapper').hide();
    $('.diary-modal').fadeOut();
    $('.personality-modal').fadeOut();
})

// タブ切り替え
$(document).ready(function(){
  $('#tab-contents .tab[id != "tab1"]').hide();
});
$(document).ready(function(){
  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});



/* global diaryId*/
// コメント表示
$(document).ready(function(){
  $('.comment-box').hide();
  // 変数の中身(個数)取得
  var $diaryComment = $('.diary-comment-id');
  // i=index,elm=diaryCommentの値
  $diaryComment.each(function(i, elm) {
    (function() {
      var diaryId = $(elm).val();
      (function() {
        $('#comment-btn-'+diaryId+'').on('click', function(){
          $('#comment-'+diaryId+'').slideToggle();
        });
      })(diaryId);
    })(elm);
  })
});



// jscroll無限スクロール
$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.scroll-list',
      nextSelector: 'span.next:last a'
    });
  }
});

// チャットを下端へスクロールする
$(document).ready(function(){
  var $scrollAuto = $('.chat-area');
　$('.chat-area').animate({scrollTop: $scrollAuto[0].scrollHeight}, 'fast');
});