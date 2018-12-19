$(document).on('turbolinks:load', function () {

  $('.input-file-preview').on('change', function(e){

    var $this = $(this)
    if(e.target.files[0].size > 5242880){
      swal({
        title: "File must be under 5MB",
        type: "warning",
        showCancelButton: false,
        closeOnConfirm: true
      });
      $this.closest('fieldset').removeClass('has-preview');
      $(this).val("")
    } else {
      $this.closest('fieldset').find('.custom-file-label').text(e.target.files[0].name);
      $this.closest('fieldset').addClass('has-preview');
    }
  });

});
