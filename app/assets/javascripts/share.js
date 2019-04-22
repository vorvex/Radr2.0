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

function shareDefault(){
  $('.share-default').addClass('active');
  setTimeout(function(){
    $('.share-default-container').addClass('active');
  }, 50);
}

function shareThis(title, text, url){
  if(!navigator.share) {
    shareDefault();
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