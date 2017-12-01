// App.appearance = App.cable.subscriptions.create("AppearanceChannel", {
//   connected: function() {},
//   // Called once the subscription has been successfully completed
//   appear: function() {
//     return this.perform('appear', {
//       appearing_on: this.appearingOn()
//     });
//   },
//   away: function() {
//     return this.perform('away');
//   },
//   appearingOn: function() {
//     return $('main').data('appearing-on');
//   }
// });

// $(document).on('page:change', function() {
//   return App.appearance.appear();
// });

// $(document).on('click', '[data-behavior~=appear_away]', function() {
//   App.appearance.away();
//   return false;
// });
