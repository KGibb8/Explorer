
$('#headerBtn').on('click', function () {
  $('#headerFile').click();
});

$('#headerFile').on('change', function () {
  $('#hiddenHeader').click();
});

$('#organiseExpedition').on("click", function () {
  $('.fullscreen.modal').modal('toggle');
});

$('.inviteBox').on("mouseover", function () {
  $(this).find("a").removeAttr("href");
  var checkbox = $(this).find('.check_box');
  var classColour;
  if (checkbox.length == 0) {
    classColour = "red";
    $(this).addClass(classColour);
  } else {
    classColour = "blue";
    $(this).addClass(classColour);
  };
  $(this).on("mouseout", function () {
    $(this).removeClass(classColour);
  });
});

$('.inviteBox').click(function () {
  var checkbox = $(this).find('.check_box');
  if (checkbox.length > 0) {
    if (checkbox.is(':checked')) {
      $(this).removeClass("checkedBlue");
      checkbox.prop('checked', false);
    } else if (!checkbox.is(':checked')) {
      $(this).addClass("checkedBlue");
      checkbox.prop('checked', true);
    };
  };
});


$('#mountHeader').on('ajax:remotipartComplete', function (e, data) {
  var expedition = JSON.parse(data.responseText);
  $('.header > img').attr("src", expedition.header.header.url)
});

$('#addStart').on('ajax:success', function (e, data) {
  console.log(data);
});

$('#addEnd').on('ajax:success', function (e, data) {
  console.log(data);
});

$('#request').on('ajax:success', function (e, data) {
  console.log(data);
});

$('#inviteFriends').on('click', function (e) {
  e.preventDefault();
  $('.modal').modal('show');
});
