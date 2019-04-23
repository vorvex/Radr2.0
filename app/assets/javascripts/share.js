function shareNative(title, text, url){
      navigator.share({
            title: title,
            text: text,
            url: url
        }).then(() => {
          // Perform Action on Success
        })
        .catch(error => {
          console.log('Error sharing:', error);
        });
    }

function shareDefault(title, text, url){
  $('#facebookshare').attr('href', 'https://www.facebook.com/sharer/sharer.php?u=' + url + "?f=share");
  $('#twittershare').attr('href', 'https://twitter.com/share?text=Sieh dir ' + title + '%20' + text + '%20' + url + "?f=share");
  $('#mailshare').attr('href', 'mailto:?subject=' + title + '&body=' + text + '%20' + url + "?f=share");
  if(navigator.userAgent.includes('iPhone' || 'Android')){
    $('#messengershare').attr('href', 'fb-messenger://share/?link=' + url + "?f=share");  
    $('#whatsappshare').attr('href', 'whatsapp://send/?text=' + title + '%20' + text + '%20' + url + "?f=share");
    $('#messengershare').show();
    $('#whatsappshare').show(); 
  } else {
    $('#messengershare').hide();
    $('#whatsappshare').hide();    
  }
  $('.share-default').addClass('active');
  setTimeout(function(){
    $('.share-default-container').addClass('active');
  }, 50);
}

function shareThis(title, text, url){
  if(!navigator.share) {
    shareDefault(title, text, url);
  } else {
    navigator.share({
        title: title,
        text: text,
        url: url
    }).then(() => {
      // Perform Action on Success
    })
    .catch(error => {
      console.log('Error sharing:', error);
    });
  }
}

function closeShareDefault(){      
  $('.share-default-container').removeClass('active');
  setTimeout(function(){
    $('.share-default').removeClass('active');
  }, 500);
}