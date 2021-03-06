addEventListener("load", function () {
  $('#friendNav').on("click", function (e) {
    e.preventDefault();
    var dropdown = $('.dropdown.top-menu');
    if (dropdown.hasClass("visible")) {
      dropdown.removeClass("visible");
      dropdown.addClass("notVisible");
    } else {
      dropdown.addClass("visible");
      dropdown.removeClass("notVisible");
    };
    return false;
  });
});

$(document).ready(function () {

  $('body').on("click", "#organiseExpedition", function () {
    $('.fullscreen.modal').modal('toggle');
  });

  $($('#acceptFriend').parent()[0]).on('ajax:success', function (e, data) {
    $(this).parent().parent().fadeOut();
  });

  $($('#rejectFriend').parent()[0]).on('ajax:success', function (e, data) {
    $(this).parent().parent().fadeOut();
  });

});
