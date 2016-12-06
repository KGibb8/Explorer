
$('#organiseExpedition').on("click", function () {
  $('#createExpedition').fadeIn();
});

$('#mountHeader').on('ajax:remotipartComplete', function (e, data) {
  var expedition = JSON.parse(data.responseText);
  $('.header > img').attr("src", expedition.header.header.url)
});
