
$(document).ready(function () {

  $('#organiseExpedition').on("click", function () {
    $('.fullscreen.modal').modal('toggle');
  });

  var lastActive;
  var url = window.location.href;
  // $('#adminMenu').on('click', '.item', function () {
  //   if (this == lastActive) {
  //     $(this).removeClass("active");
  //     lastActive = null;
  //   } else {
  //     $(lastActive).removeClass("active");
  //     $(this).addClass("active");
  //     lastActive = this;
  //   };
  // });

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
  });
});
