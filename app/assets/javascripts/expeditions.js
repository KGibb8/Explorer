
$('#organiseExpedition').on("click", function () {
  $('.fullscreen.modal').modal('toggle');
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
