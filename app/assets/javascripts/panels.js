function closePanel(){
  $('#js--panel').removeClass('show')
  $('body').removeClass('panel-open')
}
$(document).on('turbolinks:load', function(){

  $('button[data-dismiss="panel"]').on('click', function(e){
    e.preventDefault();

    closePanel()
  })

  if( $('.panel-open') ){
    $(document).keydown(function(e){
      if(e.keyCode == 27) {
        closePanel()
      }
    });
  }

})
