$(function() {
  setBadge();
  updateBadge();
});


function setBadge() {
  if ($('#notification-badge').data('number') !== 0) {
    $('#notification-badge').text($('#notification-badge').data('number'));
  }
}

function getNotificationsIdList() {
  const notificationsResults = $('.dropdown .notification-card a.notification-unseen .notifid');
  var arrayOfNotificationsId = notificationsResults.map(function() { return $(this).data("id") }).get();
  return arrayOfNotificationsId.slice(0, (notificationsResults.length / 2));
}

// function updateNotificationOnServer(list) {
//   var notificationsParams = JSON.stringify({
//       notification_list: list
//     });
//   $.ajax({
//     type: "POST",
//     url: '/notifications',
//     data: notificationsParams,
//     success: function(data) {
//       console.log(data);
//     },
//     error: function(jqXHR) {
//       console.error(jqXHR.responseText);
//     }
//   });
// }

function makeNotificationSeen() {
  $('#notification-dropdown').on('hidden.bs.dropdown', function(event) {
    $('.dropdown .notification-card a.notification-box').removeClass('notification-unseen');
  });
}

function updateBadge() {
  $('#notification-dropdown').on('shown.bs.dropdown', function(event) {
    $('#notification-badge').text('');
    // updateNotificationOnServer(getNotificationsIdList());
  });

}

// depuis ES6 pour noter une fonction  cont setbadge = () => {}

// pour attendre que le dom soit chargé :
// pas besoin si scripts sont chargés après,
// parfois besoin selon certaines librairies :
// document.addEventListener("DOMContentLoaded", () => {
  // Add here your addEventListener code
// });
