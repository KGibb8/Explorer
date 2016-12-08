
// Ajax responses
$('#submitAvatar').on('ajax:remotipartComplete', function (e, data) {
  var profile = JSON.parse(data.responseText);
  $('.avatar')[0].style = "background-image: url(" + profile.avatar.profile.url + ")";
});

$('#submitBiography').on('ajax:success', function (e, data) {
  $('#biography > p').html(data.biography);
});
