$(function () {
  $('#file_btn').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#profile_img_prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});