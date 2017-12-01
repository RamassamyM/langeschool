if ($('meta[name=action-cable-url]').length) {
  App.notification = App.cable.subscriptions.create("WebNotificationsChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      // todo

    }
  });
}
