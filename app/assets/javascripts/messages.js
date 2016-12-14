
$(document).ready(function () {

  $('.toggleChat').on('click', function (e) {
    var id = this.id.substring(11, 99999);
    var chats = $('.outerContainer');
    var thisChat = $('#container_' + id);
    if (thisChat.is(':visible')) {
      // Do nought!
    } else {
      for (var i = 0 ; i < chats.length ; ++i) {
        $(chats[i]).fadeOut().delay(1000);
      }
      thisChat.fadeIn();
    }
  })

  $('.submitNew').on("keydown", function (e) {
    if (e.which == 13) {
      var id = this.parentElement.parentElement.id.substring(10, 9999);
      $('#submitBtn_' + id).click();
      $(this).children()[1].value = "";
    };
  });

  $('.submitNewMessage').on("click", function () {
    var form = $(this).prev();
    var body = form.children()[1].value;
    var chat_id = this.parentElement.parentElement.id.substring(10, 999);
    App.message.create({
      message: {
        chat_id: parseInt(chat_id),
        body: body
      }
    });
  });

  $('.outerContainer').on('click', '.msgDeleteSubmit',  function () {
    var id = this.id.substring(16, 999999);
    var chat_id = this.parentElement.parentElement.parentElement.id.substring(10, 999);
    App.message.destroy({
      message: {
        id: id,
        chat_id: chat_id
      }
    });
  });

  $('.outerContainer').on('click', '.msgEditSubmit', function () {
    var id = $(this).parent()[0].id.substring(8, 9999999);
    var container = $('#message_' + id);
    if (container.hasClass("notEditing")) {
      container.addClass("editing").removeClass("notEditing");
      $(this).fadeOut();
    } else {
      container.addClass("notEditing").removeClass("editing");
    };
  });

  $('.outerContainer').on("keydown", '.submitMessage', function (e) {
    if (e.which == 13) {
      var id = this.id.substring(14, 999999);
      var body = $(this).children()[3].value;
      var chat_id = this.parentElement.parentElement.parentElement.id.substring(5, 9999);
      App.message.update({
        message: {
          id: id,
          chat_id: chat_id,
          body: body
        }
      });
      $('#msgEditSubmit_' + id).fadeIn();
      var container = $('#message_' + id);
      container.addClass("notEditing").removeClass("editing");
    };
  });
});
