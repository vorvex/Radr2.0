// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require_tree .

function alert(type, message) {
  if (message.length > 0){
  var popup = $('<div class="alert alert-dismissible fade show" role="alert"></div>');
  var close = $('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>')
  popup.append(message);
  popup.append(close);
  popup.addClass('alert-' + type);  
  $('.container').prepend(popup);  
  $('button.close').on('click', function(){
    $(this).parent('div').remove();
  })};
}

function toast(message) {
  var toast = $('<div class="toast" role="alert" aria-live="assertive" aria-atomic="true"><div class="toast-header"><img src="" class="rounded mr-2" alt=""><strong class="mr-auto">Radr</strong><small class="text-muted">just now</small><button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close"><span aria-hidden="true">&times;</span></button></div></div>');
  var toastbody = $('<div class="toast-body"></div>');
      toastbody.html(message);
      toast.prepend(toastbody);
  $('#toastContainer').prepend(toast);
}


