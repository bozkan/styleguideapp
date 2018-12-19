$(function () {
  $(".show-password").each(function (index, input) {
    var $input = $(input);
    $(this).closest('.form-group.password').find('.toggle-show-password').on('click', function (e) {
      e.preventDefault()
      var change = "";
      if ($(this).hasClass('hidden')) {
        $(this).removeClass('hidden').addClass('shown').text('Hide Password')
        change = "text";
      } else {
        $(this).removeClass('shown').addClass('hidden').text('Show Password')
        change = "password";
      }
      var rep = $("<input type='" + change + "' required />")
        .attr("id", $input.attr("id"))
        .attr("name", $input.attr("name"))
        .attr('class', $input.attr('class'))
        .val($input.val())
        .insertBefore($input);
      $input.remove();
      $input = rep;
    }).insertAfter($input);
  });
});
