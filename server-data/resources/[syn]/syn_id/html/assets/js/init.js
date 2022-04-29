$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array;
      var sex         = event.data.sex;
      var id         = event.data.id;

      if ( type == 'id') {
        console.log("test")
        $('img').show();
        $('#name').css('color', '#282828');

        /* if ( sex == 'm' ) {
          $('img').attr('src', 'assets/images/male.png');
          $('#sex').text('male');
        } else {
          $('img').attr('src', 'assets/images/female.png');
          $('#sex').text('female');
        } */

        $('#name').text(userData.name);
        $('#dob').text(userData.job);
        $('#height').text(id);
        $('#signature').text(userData.name);
        $('#id-card').css('background', 'url(assets/images/idcard.png)');
        
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $.post('http://syn_id/close', JSON.stringify({}));
      $('#name').text('');
      $('#id').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
