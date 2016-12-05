
// Ajax responses
$('#submitAvatar').on('ajax:remotipartComplete', function (e, data) {
  var profile = JSON.parse(data.responseText);
  $('#avatar > img').attr('src', profile.avatar.profile.url)
});

$('#submitBiography').on('ajax:success', function (e, data) {
  $('#biography > p').html(data.biography);
});
