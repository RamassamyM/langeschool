$(document).ready(function() {
  $("#alertbox").fadeTo(4000, 1).slideUp(400, function(){
      $("#alertbox").alert('close');
  });
});
