
$('#submitBtn').on("click", function () {
  var form = $(this).prev()
  var body = form.children()[1].value
  var chat_id = this.parentElement.parentElement.id.substring(10, 999)
  App.message.create({
    message: {
      chat_id: parseInt(chat_id),
      body: body
    }
  });
});
