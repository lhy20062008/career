$(document).ready(function () {
  $(".history").parent().addClass('history-sidebar')
  $(".history").parents('#active_admin_content').removeClass('with_sidebar').addClass('without_sidebar')
})
