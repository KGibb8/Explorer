$(document).ready(function () {

  $('#bioEdit').click(function () {
    var bio = $(this).parent();
    if (bio.hasClass("notEditing")) {
      bio.addClass("editing").removeClass("notEditing");
      $(this).fadeOut();
    } else {
      bio.addClass("notEditing").removeClass("editing");
    };
  });

  $('#submitBiography').on("keydown", function (e) {
    if (e.which == 13) {
      $('#bioSubmit').click();
      $('#bioEdit').fadeIn();
      var description = $(this).parent().parent();
      description.addClass("notEditing").removeClass("editing");
    };
  }).on('ajax:success', function (e, data) {
    $('.bioBody').html(data.biography);
  });

  $('#nameEdit').click(function () {
    var name = $(this).parent();
    if (name.hasClass("notEditing")) {
      name.addClass("editing").removeClass("notEditing");
      $(this).fadeOut();
    } else {
      name.addClass("notEditing").removeClass("editing");
    }
  });

  $('#submitNames').on("keydown", function (e) {
    if (e.which == 13) {
      $('#nameSubmit').click();
      $('#nameEdit').fadeIn();
      var description = $(this).parent().parent();
      description.addClass("notEditing").removeClass("editing");
    };
  }).on('ajax:success', function (e, data) {
    $('.nameBody').html(data.first_name + ' ' + data.last_name)
  });

  $('#avatar').click(function () {
    $('#avatarFile').click();
  });

  $('#avatarFile').change(function () {
    $('#avatarSubmit').click();
  });

  $('#submitAvatar').on('ajax:remotipartComplete', function (e, data) {
    var profile = JSON.parse(data.responseText);
    $('.avatar')[0].style = "background-image: url(" + profile.avatar.profile.url + ")";
  });

  $('#submitBiography').on('ajax:success', function (e, data) {
    $('#biography > p').html(data.biography);
  });

  $($('#requestFriend').parent()[0]).on('ajax:success', function (e, data) {
    var column = this.parentElement;
    $(column).empty();
    var ele = document.createElement('p');
    ele.innerHTML = data.message;
    column.appendChild(ele);
  });

  $($('#acceptFriend').parent()[0]).on('ajax:success', function (e, data) {
    var container = this.parentElement;
    $(container).empty();
    var ele = document.createElement('p');
    ele.innerHTML = data.message;
    container.appendChild(ele);
    // %%TODO%% Render partial instead!!
    var friend = createFriend(data.user, data.profile);
    $('#friends').append(friend);
  });

  $($('#rejectFriend').parent()[0]).on('ajax:success', function (e, data) {
    var container = this.parentElement;
    $(container).empty();
    var ele = document.createElement('p');
    ele.innerHTML = data.message;
    container.appendChild(ele);
  });

  $('.friends_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('.past_expeditions_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  $('.future_expeditions_pagination a').on("click", function (e){
    e.preventDefault();
    $.get(this.href, null, null, 'script');
    return false;
  });

  function createFriend (user, profile) {
    var a = document.createElement('a');
    a.setAttribute("href", "/users/" + user.id + "/profile")
    var friend = document.createElement('div');
    friend.className = 'user';
    var pic = document.createElement('div');
    pic.className = "avatar thumb";
    pic.style = "background-image: url(" + profile.avatar.thumb.url + ");";
    friend.appendChild(pic);
    var p = document.createElement('p');
    p.innerHTML = user.username;
    friend.appendChild(p);
    a.appendChild(friend);
    return a
  }
});

