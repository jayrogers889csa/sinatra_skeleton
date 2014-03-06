$(document).ready(function() {

  $('#delete_account').on('click', function(event) {
    event.preventDefault();

    var url = $(this).attr('href');

    $.get(url, function(serverResponse) {
      $('#confirm_delete_message').html(serverResponse);
    })
  })

  $(document).on('click', '#second_thoughts', function(event) {
    event.preventDefault();
    $('#confirm_delete_message').children().remove();
  })
});
