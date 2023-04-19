$(function() {
  $(document).on("click", '.js-edit-comment-button', function(){
    const commentId = $(this).data('comment-id');
    const commentTextAreaCommentBox = $('#js-textarea-comment-box-' + commentId);
    commentTextAreaCommentBox.slideToggle();
  });
});
