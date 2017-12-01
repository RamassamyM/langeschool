if ($('meta[name=action-cable-url]').length) {
  App.notification = App.cable.subscriptions.create("WebNotificationsChannel", {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      var badge = $('#notification_badge_1');
      var increment = badge.data('number') + data.increment;
      badge.data('number', increment);
      $('#notification_badge_1').text(badge.data('number'));
      $('#notification_badge_2').text(badge.data('number'));
    }
  });
}
