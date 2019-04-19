function shareNative(title, text, url){
      navigator.share({
          title: title,
          text: text,
          url: url
      }).then(() => {
          // webShareTestEl.children[0].innerText = 'done';
          // resetButton();
      }).catch(error => {
              console.log('Error sharing:', error);

              // webShareTestEl.children[0].innerText = 'error';
              // resetButton();
      });
    }