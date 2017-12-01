$(function() {
  setBadge();
  updateBadge();
});

function setBadge() {
  if ($('#notification_badge_1').data('number') !== 0) {
    $('#notification_badge_1').text($('#notification_badge_1').data('number'));
    $('#notification_badge_2').text($('#notification_badge_2').data('number'));
  }
}

function updateBadge() {
  $('.notification-dropdown').on('shown.bs.dropdown', function(event) {
    $('#notification_badge_1').text('');
    $('#notification_badge_2').text('');
  });
}
