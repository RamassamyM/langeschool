if ($('meta[name=action-cable-url]').length) {
  App.notification = App.cable.subscriptions.create("WebNotificationsChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      var badge1 = $('#notification_badge_1');
      var badge2 = $('#notification_badge_2');
      var newIncrement = badge1.data('number') + data.increment;
      badge1.data('number', newIncrement);
      badge2.data('number', newIncrement);
      addTextInBadges(newIncrement);
    }
  });
}
