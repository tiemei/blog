//= require jquery
//= require jquery_ujs
jQuery(function($) {
  // 按钮事件
  $(".input_submit").mouseover(function(event) {
     $(event.target).css("background-color", "#66CC66");
  });
  $(".input_submit").mouseout(function(event) {
     $(event.target).css("background-color", "#3fa156");
  });

  $(".focus_clear").focus(function(event) {
      $(event.target).attr("value", "");
  });
  
});
