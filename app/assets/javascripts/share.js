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