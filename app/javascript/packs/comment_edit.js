$(function() {
  $('.js-edit-comment-button').on("click",function(){
    const commentId = $(this).data('comment-id');
    const commentTextAreaCommentBox = $('#js-textarea-comment-box-' + commentId);
    commentTextAreaCommentBox.slideToggle();
  });
});
