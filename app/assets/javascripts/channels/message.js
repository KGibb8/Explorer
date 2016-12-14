App.message = App.cable.subscriptions.create("MessageChannel", {
  connected: function () {

  },
  disconnected: function () {

  },
  received: function (data) {
    console.log(data);
  },
  create: function (message) {
    return this.perform('create', message);
  }
});
