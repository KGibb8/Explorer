function cycleImages () {
  var active = $('#cycler .active');
  var next = (active.next().length > 0) ? active.next() : $('#cycler div:first');
  next.css('z-index', 2);
  active.fadeOut(1500, function () {
    active.css('z-index', 1).show().removeClass('active');
    next.css('z-index', 3).addClass('active');
  });
}

$(document).ready(function () {

  setInterval('cycleImages()', 5000);

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

  var lastActive;
  $('#adminMenu').on('click', '.item', function () {
    if (this == lastActive) {
      $(this).removeClass("active");
      lastActive = null;
    } else {
      $(lastActive).removeClass("active");
      $(this).addClass("active");
      lastActive = this;
    };
  });

  $('#adminMenuRequests').on("click", function (e) {
    e.preventDefault();
    var dropdown = $('.dropdown.admin-menu');
    if (dropdown.hasClass("visible")) {
      dropdown.removeClass("visible");
      dropdown.addClass("notVisible");
    } else {
      dropdown.addClass("visible");
      dropdown.removeClass("notVisible");
    };
  });

  // %%TODO%% Refactor below into a function to switch classes over

  $('#editDesc').on('click', function (e) {
    e.preventDefault();
    var description = $(this).parent();
    if (description.hasClass("notEditing")) {
      description.addClass("editing").removeClass("notEditing");
      $(this).fadeOut();
    } else {
      description.addClass("notEditing").removeClass("editing");
    }
  });

  $('#submitDescription').on("keydown", function (e) {
    if (e.which == 13) {
      $('#descriptionSubmit').click();
      $('#editDesc').fadeIn();
      var description = $(this).parent().parent();
      description.addClass("notEditing").removeClass("editing");
    };
  });

  $('#editStartTime').on('click', function (e) {
    e.preventDefault();
    var time = $(this).parent();
    if (time.hasClass("notEditing")) {
      time.addClass("editing").removeClass("notEditing");
      $(this).fadeOut();
    } else {
      time.addClass("notEditing").removeClass("editing");
    }
  });

  $('#startTimeSubmit').on("click", function () {
    $('#editStartTime').fadeIn();
    var time = $(this).parent().parent().parent();
    time.addClass("notEditing").removeClass("editing");
  });

  $('#submitDescription').on("ajax:success", function (e, data) {
    $(this).parent().parent().find('.descriptionBody').html(data.description);
  });

  $('#submitStartTime').on("ajax:success", function (e, data) {
    var formatDate = moment(data.start_time).format('MMMM D YYYY, h:mm');
    $(this).parent().parent().find('.startTimeBody').html('<strong>Start: </strong>' + formatDate);
  });

  $('#mountHeader').on('ajax:remotipartComplete', function (e, data) {
    var expedition = JSON.parse(data.responseText);
    $('.header > img').attr("src", expedition.header.header.url)
  });

  $('#addStart').on('ajax:success', function (e, data) {
    $('.location').children()[0].innerHTML = "<strong>Begins: </strong>" + data.coordinate.location;
  });

  $('#addEnd').on('ajax:success', function (e, data) {
    $('.location').children()[1].innerHTML = "<strong>Ends: </strong>" + data.coordinate.location;
  });

  $('#request').on('ajax:success', function (e, data) {
    console.log(data);
  });

  $('#inviteFriends').on('click', function (e) {
    e.preventDefault();
    $('#modal-1').modal('show');
  });

  $('.attending_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('.invited_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('.attended_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('.requested_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

})
