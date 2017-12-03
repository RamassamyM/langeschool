$(function() {
  setBadge();
  updateBadge();
});

function setBadge() {
  var badge_initial_number = $('#notification_badge_1').data('number');
  addTextInBadges(badge_initial_number);
}

function addTextInBadges(number) {
  if ( number !== 0) {
    $('#notification_badge_1').text(number);
    $('#notification_badge_2').text(number);
  }
}

function updateBadge() {
  $('.notification-dropdown').on('shown.bs.dropdown', function(event) {
    clearBadge('#notification_badge_1');
    clearBadge('#notification_badge_2');
  });
}

function clearBadge(badgeId) {
  $(badgeId).text('');
  $(badgeId).data('number', 0);
}
