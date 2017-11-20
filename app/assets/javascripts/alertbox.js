$(document).ready(function() {
  $("#alertbox").fadeTo(2000, 500).slideUp(500, function(){
      $("#alertbox").alert('close');
  });
});
