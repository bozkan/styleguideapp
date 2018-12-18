$(document).on('turbolinks:load', function(){
  $('#js--toggle-brand-menu').on('click',function(e){
    e.preventDefault()
    if( $('body').hasClass('menu-closed') ) {
      openTenantNav()
    } else {
      closeTenantNav()
    }
  })
  if (matchMedia) {
    const mq = window.matchMedia("(max-width: 1200px)");
    mq.addListener(TenantNavWidthChange);
    TenantNavWidthChange(mq);
  }

  function TenantNavWidthChange(mq) {
    if (mq.matches) {
      closeTenantNav()
    } else {
      openTenantNav()
    }
  }

  function closeTenantNav(){
    Cookies.set('menu_closed', true)
    $('body').removeClass('menu-open')
    $('body').addClass('menu-closed')
  }
  function openTenantNav(){
    Cookies.set('menu_closed', false)
    $('body').removeClass('menu-closed')
    $('body').addClass('menu-open')
  }

})
