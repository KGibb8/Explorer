App.message = App.cable.subscriptions.create("MessageChannel", {
  connected: function () {

  },
  disconnected: function () {

  },
  received: function (data) {
    debugger;
    if (data.action == "create") {
      $('#chat_' + data.chat_id).prepend(data.message);
    } else if (data.action == "update") {
      $('#message_' + data.message.id).children()[1].innerHTML = data.message.body;
    } else if (data.action == "destroy") {

    };
  },
  create: function (message) {
    return this.perform('create', message);
  },
  update: function (message) {
    return this.perform('update', message);
  },
  destroy: function (message) {
    return this.perform('destroy', message);
  }
});
