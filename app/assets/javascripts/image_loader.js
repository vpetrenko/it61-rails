function deleteAvatar($imageForm) {
  $.ajax({
    url: $imageForm.data('avatar-path'),
    type: 'DELETE',
    success: function success() {
    },
    cache: false
  });
}

function uploadAvatar($imageForm) {
  var formData = new FormData($imageForm[0]);
  $.ajax({
    url: $imageForm.data('avatar-path'),
    type: 'POST',
    xhr: function () {  // Custom XMLHttpRequest
      var myXhr = $.ajaxSettings.xhr();
      if (myXhr.upload) { // Check if upload property exists
        myXhr.upload.addEventListener('progress', function progressHandlingFunction() {
        }, false); // For handling the progress of the upload
      }
      return myXhr;
    },
    //Ajax events
    beforeSend: function beforeSendHandler() {
    },
    success: function completeHandler() {
    },
    error: function errorHandler() {
    },
    // Form data
    data: formData,
    //Options to tell jQuery not to process data or worry about content-type.
    cache: false,
    contentType: false,
    processData: false
  });
}